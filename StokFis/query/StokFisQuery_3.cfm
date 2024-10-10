<cfparam name="attributes.clot" default="0">
<cfset attributes.ACTIVE_PERIOD =session.ep.period_id>
<cfquery name="SS" datasource="#DSN3#">
    UPDATE GENERAL_PAPERS SET STOCK_FIS_NUMBER=STOCK_FIS_NUMBER+1 WHERE STOCK_FIS_NUMBER IS NOT NULL
    select STOCK_FIS_NO,STOCK_FIS_NUMBER from GENERAL_PAPERS
</cfquery>
<cfinclude template="/v16/stock/query/check_our_period.cfm"> 
<cfinclude template="/v16/stock/query/get_process_cat.cfm">  


<cfset attributes.fis_type = get_process_type.PROCESS_TYPE>

<cfset ATTRIBUTES.XML_MULTIPLE_COUNTING_FIS =1>
<cfset attributes.fis_date=now()>
<cfset attributes.fis_date_h=0>
<cfset attributes.fis_date_m=0>

<cfset attributes.PROD_ORDER = ''>  
<cfset attributes.PROD_ORDER_NUMBER = ''>  
<cfset attributes.PROJECT_HEAD = PROJECT_HEAD> 
<cfset attributes.PROJECT_HEAD_IN = PROJECT_HEAD_IN>  
<cfset attributes.PROJECT_ID = PROJECT_ID>  
<cfset attributes.PROJECT_ID_IN = PROJECT_ID_IN> 
<cfset attributes.member_type='' >
<cfset attributes.member_name='' >
<cfset ATTRIBUTES.XML_MULTIPLE_COUNTING_FIS =1>
<cfset ATTRIBUTES.FIS_DATE_H  ="00">
<cfset ATTRIBUTES.FIS_DATE_M  ="0">
<cfset attributes.rows_=0>


<cfloop from="1" to="#ROW_COUNT#"  index="ix">
  <cfset attributes.rows_=attributes.rows_+1>
    <cfset STOCK_ID=evaluate("attributes.STOCK_ID#ix#")>
    <cfset AMOUNT=evaluate("attributes.QUANTITY#ix#")>
   
    <cfquery name="getSinfo" datasource="#dsn3#">                            
      select PRODUCT_UNIT.MAIN_UNIT,STOCKS.PRODUCT_UNIT_ID,STOCKS.TAX,STOCKS.PRODUCT_ID,STOCKS.IS_INVENTORY from #dsn3#.STOCKS 
      left join #dsn3#.PRODUCT_UNIT on PRODUCT_UNIT.PRODUCT_ID=STOCKS.PRODUCT_ID and IS_MAIN=1                            
      where STOCK_ID=#STOCK_ID#
  </cfquery>
<!----
    <cfif isDefined("attributes.RAF_KODU_CIKIS") and len(attributes.RAF_KODU_CIKIS)>
      <cfset "attributes.shelf_number#ix#"=attributes.RAF_ID_CIKIS>
    <cfelse>
      <cfset "attributes.shelf_number#ix#"="">
    </cfif>---->
    
    <cfif isDefined("attributes.RAF_KODU_GIRIS") and len(attributes.RAF_KODU_GIRIS)>
      <cfset "attributes.to_shelf_number#ix#"=attributes.RAF_ID_GIRIS>
      <cfset "attributes.to_shelf_number_txt#ix#"=attributes.RAF_KODU_GIRIS>
    <cfelse>
      <cfset "attributes.to_shelf_number#ix#"="">
      <cfset "attributes.to_shelf_number_txt#ix#"="">
    </cfif>
  
   



      <cfset ROW_UNIQ_RELATION="">
    
    <cfif isDefined(trim("attributes.PBS_RELATION_ID#ix#"))>
    <cfset 'attributes.PBS_RELATION_ID#ix#'=evaluate("attributes.PBS_RELATION_ID#ix#")>
    <cfelse>
      <cfset 'attributes.PBS_RELATION_ID#ix#'="">
  </cfif>
      <cfset 'attributes.stock_id#ix#' = STOCK_ID>
      <cfset 'attributes.amount#ix#' = AMOUNT>
      <cfset 'attributes.unit#ix#' = getSinfo.MAIN_UNIT>
      <cfset 'attributes.unit_id#ix#' = getSinfo.PRODUCT_UNIT_ID>
      <cfset 'attributes.tax#ix#' = getSinfo.TAX>
      <cfset 'attributes.product_id#ix#' = getSinfo.PRODUCT_ID>
      <cfset 'attributes.is_inventory#ix#' = getSinfo.IS_INVENTORY>
      <cfset 'attributes.WRK_ROW_ID#ix#' = "#round(rand()*65)##dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHmmssL')##session.ep.userid##round(rand()*100)#">
      <cfset 'attributes.row_unique_relation_id#ix#'=ROW_UNIQ_RELATION>
      <cfset "attributes.amount_other#ix#"=amount_other>
      <cfset "attributes.unit_other#ix#"=unit_other>
     
      <cfset "attributes.lot_no#ix#"=evaluate("attributes.lot_no#ix#")>
   
      <cfset ix=ix+1>   
</cfloop>
<cfif isDefined("attributes.wodate")>
  
  <cfinclude template="/v16/stock/query/add_ship_fis_1_PBSWoDate.cfm">    
  <cfinclude template="/v16/stock/query/add_ship_fis_2_PBSWoDate.cfm">
<cfelse>
  <cfinclude template="/v16/stock/query/add_ship_fis_1_PBS.cfm">    
  <cfinclude template="/v16/stock/query/add_ship_fis_2_PBS.cfm">
</cfif>


<cfif isdefined("attributes.rows_")>            
    <cfinclude template="/v16/stock/query/add_ship_fis_3_PBS.cfm">
    <cfinclude template="/v16/stock/query/add_ship_fis_4_PBS.cfm">                    
<cfelse>
    <cfquery name="ADD_STOCK_FIS_ROW" datasource="#dsn2#">
        INSERT INTO STOCK_FIS_ROW (FIS_NUMBER,FIS_ID) VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#FIS_NO#">,#GET_ID.MAX_ID#)
    </cfquery>
</cfif>   