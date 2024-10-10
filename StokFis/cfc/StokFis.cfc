
<cfcomponent>
    <cfsetting showdebugoutput="no">
    <cfset dsn = application.systemParam.systemParam().dsn>
<cfset dsn3="#dsn#_1">
<cfset DSN3_ALIAS="#dsn#_1">
<cfset dsn2="#dsn#_#YEAR(NOW())#_1">
<cfset DSN2_ALIAS="#dsn#_#YEAR(NOW())#_1">
    <cffunction name="SaveRafTasi" ccess="remote" httpMethod="POST"  returntype="any" returnFormat="json">
        <cfargument name="Data">
       <cftry>
       
        <cfset FormData=deserializeJSON(arguments.Data)>
        <cfdump var="#FormData#">
        <cfset ReturnArr=arrayNew(1)>        
       <cfset attributes=structNew()>
        <cfloop array="#FormData#" item="it">
            <cfset ax=arrayfind(ReturnArr,function(item){
                return item.DEPARTMENT_LOCATION=="#it.FROM_DEPARTMENT#-#it.FROM_LOCATION#"
            })>
            <cfif isDefined("it.RELATION_ID")>
                <CFSET RELATION_ID=it.RELATION_ID>
            <CFELSE>
                <CFSET RELATION_ID="">
            </cfif>
            <cfif isDefined("it.REF_NO")>
                <CFSET REF_NO=it.REF_NO>
            <CFELSE>
                <CFSET REF_NO="">
            </cfif>
            <cfif ax eq 0>
                <cfscript>
                    Obje={
                        DEPARTMENT_LOCATION="#it.FROM_DEPARTMENT#-#it.FROM_LOCATION#",
                        TO_DEPARTMENT_LOCATION="#it.TO_DEPARTMENT#-#it.TO_LOCATION#",
                        REF_NO="#REF_NO#",
                        ROWS:[
                            {
                                FROM_SHELF_CODE:it.FROM_SHELF_CODE,
                                FROM_SHELF_ID:it.FROM_SHELF_ID,
                                LOT_NO:it.LOT_NO,
                                PRODUCT_ID:it.PRODUCT_ID,
                                STOCK_ID:it.STOCK_ID,
                                TO_SHELF_CODE:it.TO_SHELF_CODE,
                                TO_SHELF_ID:it.TO_SHELF_ID,
                                RELATION_ID:RELATION_ID
                                

                            }
                        ]
                    };
                    arrayAppend(ReturnArr,Obje);
                </cfscript>
            <cfelse>
                <cfscript>
                   Obje=ReturnArr[ax];
                   var Item={
                    FROM_SHELF_CODE:it.FROM_SHELF_CODE,
                                FROM_SHELF_ID:it.FROM_SHELF_ID,
                                LOT_NO:it.LOT_NO,
                                PRODUCT_ID:it.PRODUCT_ID,
                                STOCK_ID:it.STOCK_ID,
                                TO_SHELF_CODE:it.TO_SHELF_CODE,
                                TO_SHELF_ID:it.TO_SHELF_ID,
                                RELATION_ID:RELATION_ID
                   }
                   arrayAppend(Obje.ROWS,Item);
                </cfscript>
            </cfif>
        
        </cfloop>

        <cfdump var="#ReturnArr#">
        
        <cfquery name="GETPRI" datasource="#DSN#">
            SELECT * FROM catalyst_prod.SETUP_PERIOD WHERE PERIOD_YEAR=YEAR(GETDATE())
        </cfquery>
<cfloop array="#ReturnArr#" item="it2">
    <cfset attributes=structNew()>
    <cfset attributes.LOCATION_IN=listGetAt(it2.TO_DEPARTMENT_LOCATION,2,"-")>
    <cfset attributes.LOCATION_OUT=listGetAt(it2.DEPARTMENT_LOCATION,2,"-")>
    <cfset attributes.department_out=listGetAt(it2.DEPARTMENT_LOCATION,1,"-")>
    <cfset attributes.department_in =listGetAt(it2.TO_DEPARTMENT_LOCATION,1,"-")>
    <cfif isDefined("it2.REF_NO")><cfset attributes.ref_no=it2.REF_NO><cfelse><cfset attributes.REF_NO=""> </cfif>
    <CFSET attributes.FIS_DATE=NOW()>
    <CFSET attributes.FIS_DATE_H =hour(NOW())>
    <CFSET attributes.FIS_DATE_M  =minute(NOW())>
    <cfset form.process_cat=87>
    <cfset attributes.process_cat = form.process_cat>
    <cfloop array="#it2.ROWS#" item="it3" index="ix">
        <cfquery name="getSinfo" datasource="#dsn3#">                            
            select PRODUCT_UNIT.MAIN_UNIT,STOCKS.PRODUCT_UNIT_ID,STOCKS.TAX,STOCKS.PRODUCT_ID,STOCKS.IS_INVENTORY from #dsn3#.STOCKS 
            left join #dsn3#.PRODUCT_UNIT on PRODUCT_UNIT.PRODUCT_ID=STOCKS.PRODUCT_ID and IS_MAIN=1                            
            where STOCK_ID=#it3.STOCK_ID#
        </cfquery>
      
        <cfset "attributes.STOCK_ID#ix#"=it3.STOCK_ID>
        <cfset "attributes.PRODUCT_ID#ix#"=it3.PRODUCT_ID>
        <cfset "attributes.shelf_number#ix#"=it3.FROM_SHELF_ID>  
        <cfset "attributes.to_shelf_number#ix#"=it3.TO_SHELF_ID>  
        <cfset "attributes.to_shelf_number_txt#ix#"=it3.TO_SHELF_CODE>  
        <cfset "attributes.PBS_RELATION_ID#ix#"="">
        <cfset "attributes.amount#ix#"=1>
        <cfset "attributes.unit#ix#"=getSinfo.MAIN_UNIT>
        <cfset "attributes.unit_id#ix#"=getSinfo.PRODUCT_UNIT_ID>
        <cfset "attributes.tax#ix#"=getSinfo.TAX>
        <cfset "attributes.is_inventory#ix#"=getSinfo.IS_INVENTORY>
        <cfset 'attributes.WRK_ROW_ID#ix#' = "#round(rand()*65)##dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHmmssL')##session.ep.userid##round(rand()*100)#">
        <cfset 'attributes.wrk_row_relation_id#ix#' = "#it3.RELATION_ID#">
        
        <cfset "attributes.amount_other#ix#"="">
      <cfset "attributes.unit_other#ix#"="">
      <cfset "attributes.lot_no#ix#"="#it3.LOT_NO#">
    </cfloop>
<cfset attributes.rows_=arrayLen(it2.ROWS)>
<CFSET attributes.wodate=1>
<CFSET attributes.XML_MULTIPLE_COUNTING_FIS=1>
<cfset attributes.ACTIVE_PERIOD =GETPRI.PERIOD_ID>
<cfset attributes.PROD_ORDER = ''>  
<cfset attributes.PROD_ORDER_NUMBER = ''>  
<cfinclude template="/v16/stock/query/check_our_period.cfm"> 
<cfinclude template="/v16/stock/query/get_process_cat.cfm">  


<cfset attributes.fis_type = get_process_type.PROCESS_TYPE>

<cfif isDefined("attributes.wodate")>
  
    <cfinclude template="/v16/stock/query/add_ship_fis_1_PBSWoDate.cfm">    
    <cfinclude template="/v16/stock/query/add_ship_fis_2_PBS.cfm">
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
  <cfquery name="SS" datasource="#DSN3#">
    UPDATE GENERAL_PAPERS SET STOCK_FIS_NUMBER=STOCK_FIS_NUMBER+1 WHERE STOCK_FIS_NUMBER IS NOT NULL
    select STOCK_FIS_NO,STOCK_FIS_NUMBER from GENERAL_PAPERS
</cfquery>
</cfloop>
<cfset ReturnData.STATUS="1">
<CFSET ReturnData.MESSAGE="Başarılı">
<cfreturn (replace(serializeJSON(ReturnData),"//",""))>
<cfcatch>
    <cfset ReturnData.STATUS="1">
<CFSET ReturnData.MESSAGE=cfcatch.message>
<cfdump var="#cfcatch#">
<cfreturn (replace(serializeJSON(ReturnData),"//",""))>
</cfcatch>
</cftry>
    </cffunction>
</cfcomponent>