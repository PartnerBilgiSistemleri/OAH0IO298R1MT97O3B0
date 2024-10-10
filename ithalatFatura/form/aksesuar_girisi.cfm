<cfif isDefined("attributes.emrecim") and attributes.emrecim eq 1>
    <cfinclude template="ithal_mal_girisi__0.cfm">
    <cfabort>
</cfif>
<cfif isDefined("attributes.is_submit")>
<CFSET ATTRIBUTES.XML_MULTIPLE_COUNTING_FIS =1>
    <cfdump var="#attributes#">
    
    
    <cfquery name="GETMAXID" datasource="#DSN2#">
        SELECT MAX(FIS_ID) AS MXIDD FROM STOCK_FIS
    </cfquery>
    <cfset attributes.rows_=attributes.ROW_COUNT>
    <cfset SHIP_NUMBER='IMG-#GETMAXID.MXIDD#'>
    <cfset attributes.ACTIVE_PERIOD=session.ep.period_id>
    
    <cfset form.process_cat=1209>
    <cfset attributes.process_cat = form.process_cat>
    <CFSET attributes.ref_no="#attributes.INVOICE_ID#">
<cfset attributes.FIS_DATE=now()>
<cfset attributes.deliver_date_frm=now()>

<cfset attributes.LOCATION_IN=    2>
<cfset attributes.department_in = 1>

<cfset attributes.LOCATION_OUT=   0>
<cfset attributes.department_out= 1>

<cfset attributes.FIS_DATE_H  =0>
<cfset attributes.FIS_DATE_M  =0>

<cfinclude template="/v16/stock/query/check_our_period.cfm"> 
<cfinclude template="/v16/stock/query/get_process_cat.cfm">  


<cfset attributes.fis_type = get_process_type.PROCESS_TYPE>
<CFSET attributes.PROD_ORDER_NUMBER ="">
<cfset form.BASKET_RATE2=1>
<cfset form.BASKET_NET_TOTAL=0>
<cfset form.BASKET_RATE1=0>
<cfset form.basket_money="TL">
<cfquery name="getMaxIDsh" datasource="#dsn2#">
    SELECT MAX(SHIP_ID) AS MXIDD FROM SHIP
</cfquery>
<CFSET SHIP_NUMBER='IMG-0000#getMaxIDsh.MXIDD#'>

<cfloop from="1" to="#attributes.ROW_COUNT#" index="i">
    <cfset 'attributes.deliver_date#i#'=now()>
<cfquery name="getProductInfo" datasource="#dsn3#">
    SELECT TOP 10 s.PRODUCT_NAME,S.STOCK_ID,PU.MAIN_UNIT,PU.PRODUCT_UNIT_ID,PRODUCT_CODE_2,S.IS_INVENTORY,S.PRODUCT_ID FROM STOCKS AS S INNER JOIN PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND IS_MAIN=1
 WHERE S.PRODUCT_ID=#evaluate("attributes.PRODUCT_ID_#i#")#
</cfquery>


<cfset 'attributes.product_name#i#'=getProductInfo.PRODUCT_NAME>
<cfset 'attributes.stock_id#i#'=getProductInfo.STOCK_ID>
<cfset 'attributes.product_id#i#'=getProductInfo.PRODUCT_ID>
<cfset 'attributes.amount#i#'=1>
<cfset 'attributes.unit#i#'=getProductInfo.MAIN_UNIT>
<cfset 'attributes.unit_id#i#'=getProductInfo.PRODUCT_UNIT_ID>
<cfset 'attributes.tax#i#'=0>
<cfset 'attributes.price#i#'=0>
<cfset 'attributes.row_lasttotal#i#'=0>
<cfset 'attributes.row_nettotal#i#'=0>
<cfset 'attributes.is_inventory#i#'=getProductInfo.IS_INVENTORY>
<cfset 'attributes.row_taxtotal#i#'=0>
<cfset 'attributes.lot_no#i#'="#evaluate('attributes.LOT_NO_#i#')#">
<cfset 'attributes.price_other#i#'=0>
<cfset 'attributes.spect_id#i#'="">
<CFSET 'attributes.wrk_row_relation_id#i#' ="#evaluate('attributes.WRK_ROW_ID_#i#')#">
<cfset 'attributes.awrk_row_id#i#'="PBS#round(rand()*65)##dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHmmssL')##session.ep.userid##round(rand()*100)#">
<cfset 'attributes.wrk_row_id#i#'="PBS#round(rand()*65)##dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHmmssL')##session.ep.userid##round(rand()*100)#">
<cfset 'attributes.to_shelf_number#i#'="#listGetAt(attributes.RAF,1,"-")#">
<cfset 'attributes.to_shelf_number_txt#i#'="#listGetAt(attributes.RAF,2,"-")#">
</cfloop>
<cfquery name="getper" datasource="#dsn#">
    SELECT * FROM SETUP_PERIOD WHERE PERIOD_YEAR=#attributes.IV_DATE# AND OUR_COMPANY_ID=1
</cfquery>
<CFSET import_invoice_id="#attributes.INVOICE_ID#;#getper.PERIOD_ID#">
<cfquery name="GETK" datasource="#DSN#">
    select DISTINCT MONEY,RATE1,RATE2 from #DSN#.MONEY_HISTORY where VALIDATE_DATE=(select max(VALIDATE_DATE) FROM #DSN#.MONEY_HISTORY )
UNION
SELECT 'TL' AS MONEY,1 AS RATE1,1 AS RATE2
</cfquery>
<CFSET attributes.kur_say=GETK.recordCount>
<CFSET K=1>
<cfloop query="GETK">
    <CFSET "attributes.txt_rate2_#K#"=RATE2>
    <CFSET "attributes.txt_rate1_#K#"=RATE1>
    <CFSET "attributes.hidden_rd_money_#K#"=MONEY>
    <CFSET K=K+1>
</cfloop>
<CFSET attributes.BASKET_MONEY ="TL">
<cfif isDefined("attributes.wodate")>
  
    <cfinclude template="/v16/stock/query/add_ship_fis_1_PBSWoDate.cfm">    
    <cfinclude template="/v16/stock/query/add_ship_fis_2_PBSWoDate.cfm">
  <cfelse>
    <cfinclude template="/v16/stock/query/add_ship_fis_1_PBS.cfm">    
    <cfinclude template="/v16/stock/query/add_ship_fis_2_PBS.cfm">
  </cfif>
  
  
  <cfif isdefined("attributes.rows_")>            
    BURAYA GİRDİ
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
<script>
   window.location.href="/index.cfm?fuseaction=invoice.emptypopup_ithal_mal_girisi";
</script>
<!------
<cfinclude template="/V16/stock/query/add_stock_in_from_customs_PBS.cfm">
<cfquery name="GETMAXID" datasource="#DSN2#">
    SELECT MAX(SHIP_ID) AS MXIDD FROM SHIP
</cfquery>

<cfset DELIVER_IN_DEPT=1>
<cfset DELIVER__IN_LOC=2>
<cfset PROCESS__IN_TYPE=811>
<cfquery name="GETSHIP_ROW" datasource="#DSN2#">
  SELECT * FROM SHIP_ROW WHERE SHIP_ID=#GETMAXID.MXIDD#
</cfquery>
<CFLOOP query="GETSHIP_ROW" >
<cfquery name="getProductInfo" datasource="#dsn3#">
SELECT TOP 10 s.PRODUCT_NAME,S.STOCK_ID,S.PRODUCT_ID,PU.MAIN_UNIT,PU.PRODUCT_UNIT_ID,PRODUCT_CODE_2 FROM STOCKS AS S INNER JOIN PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND IS_MAIN=1
WHERE S.PRODUCT_ID=#PRODUCT_ID#
</cfquery>
<cfquery name="INS3" datasource="#DSN2#">
INSERT INTO STOCKS_ROW (STOCK_ID,PRODUCT_ID,UPD_ID,PROCESS_TYPE,STOCK_IN,STORE,STORE_LOCATION,LOT_NO,PROCESS_DATE,PROCESS_TIME) VALUES(#getProductInfo.STOCK_ID#,#getProductInfo.PRODUCT_ID#,#SHIP_ID#,#PROCESS__IN_TYPE#,1,#DELIVER_IN_DEPT#,#DELIVER__IN_LOC#,'#LOT_NO#',CONVERT(DATE,GETDATE()),GETDATE())
</cfquery>

</CFLOOP> 

<cfquery name="UP" datasource="#DSN2#">
    UPDATE SHIP_ROW SET IMPORT_INVOICE_ID=#attributes.INVOICE_ID#,IMPORT_PERIOD_ID=#getper.PERIOD_ID#  WHERE SHIP_ID=#GETMAXID.MXIDD#
</cfquery>

        <cfquery name="UP" datasource="#DSN2#">
            UPDATE INVOICE_SHIPS SET IMPORT_INVOICE_ID=#attributes.INVOICE_ID#,IMPORT_PERIOD_ID=#getper.PERIOD_ID# WHERE SHIP_ID=#GETMAXID.MXIDD#
        </cfquery>
<script>
    window.location.href="/index.cfm?fuseaction=invoice.emptypopup_ithal_mal_girisi";
</script>----------->
</cfif>
<table>
    <tr>

    <td>
<div class="form-group">	
    <label><cf_get_lang dictionary_id='58133.Fatura No'> </label>
    <cfquery name="GETF" datasource="#DSN2#">
SELECT DISTINCT INVOICE_ID
	,INVOICE_NUMBER
	,PROCESS_STAGE
    ,REF_NO
	,AC
	,AMOUNT
FROM (
	SELECT I.INVOICE_NUMBER
		,I.INVOICE_ID
		,(SELECT SUM(AMOUNT) FROM INVOICE_ROW WHERE INVOICE_ID=I.INVOICE_ID) AS AMOUNT
		,I.PROCESS_STAGE
		,I.INVOICE_CAT
        ,I.REF_NO
		,I.PROCESS_CAT
		,(
			SELECT SUM(AMOUNT)
			FROM STOCK_FIS_ROW AS SR
			INNER JOIN STOCK_FIS AS S ON S.FIS_ID = SR.FIS_ID
			WHERE 1 = 1
				AND S.REF_NO=CONVERT(varchar,I.INVOICE_ID)
				AND S.FIS_TYPE = 113
			) AS AC
	FROM INVOICE AS I
--INNER JOIN catalyst_prod_2024_1. INVOICE_ROW AS IR ON IR.INVOICE_ID = I.INVOICE_ID
	WHERE INVOICE_CAT = 59 AND I.PROCESS_CAT=209
		AND ISNULL(I.PROCESS_STAGE, 0) <> 258
        AND I.PROCESS_STAGE<> 276
	) AS IRRS


WHERE ISNULL(AC, 0) < AMOUNT

    </cfquery>
    
    <SELECT name="FaturaNo" id="FaturaNo" onchange="getFatura(this,event)">
        <option value=""><cf_get_lang dictionary_id='58693.Seç'></option>
        <cfoutput query="GETF">
            <option value="#INVOICE_NUMBER#">#INVOICE_NUMBER# / #REF_NO#</option>
        </cfoutput>
    </SELECT>
    <!---<input type="text" name="FaturaNo" id="FaturaNo" onkeyup="getFatura(this,event)">---->
</div>
</td>
<td>
<div class="form-group">
    <label><cf_get_lang dictionary_id='57637.Seri No'>(Lot No)</label>
    <input type="text" name="LotNo" id="LotNo" onkeyup="getLot(this,event)">
</div>
</td>
<td>
    <div class="form-group">
    <label>Raf</label>
    <cfquery name="gets" datasource="#dsn3#">
        SELECT PRODUCT_PLACE_ID,SHELF_CODE,DETAIL FROM catalyst_prod_1.PRODUCT_PLACE WHERE STORE_ID=1 AND LOCATION_ID=0
    </cfquery>
    <SELECT name="shelf_p" onchange="$('#raf').val(this.value)">
        <option value="">Seçiniz</option>
        <cfoutput query="gets">
            <option value="#PRODUCT_PLACE_ID#-#SHELF_CODE#">#SHELF_CODE# #DETAIL#</option>
        </cfoutput>
    </SELECT>
</div>
</td>
<td>
    <input type="button" onclick="Kaydet()" value="<cf_get_lang dictionary_id='57461.Kaydet'>">
</td>
<td>
    <button type="button" onclick="Temizle()" class="ui-wrk-btn ui-wrk-btn-warning" value=""><cf_get_lang dictionary_id='66398.Yeni Fatura Kaydı'></button>
</td>
<td>
    <button id="lotumcu" type="button" onclick="AcCanim()" class="ui-wrk-btn ui-wrk-btn-busy" value=""><cf_get_lang dictionary_id='66395.Lot No Sorgula'></button>
</td>
<td>
    <button id="giri" type="button" onclick="Girdim()" class="ui-wrk-btn ui-wrk-btn-busy" value="" disabled>Mal Girişi Yapıldı</button>
    
</td>
</tr>
</table>

<cfform id="Form1" method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&islemciii=#attributes.islemciii#">
    <input type="hidden" name="raf" id="raf" required>
<cf_big_list>
    <thead>	
        <tr>		
            <th>#</th>
            <th><cf_get_lang dictionary_id='57637.Seri No'> (Lot No)</th>
            <th><cf_get_lang dictionary_id='58800.Ürün Kodu'> </th>
            <th><cf_get_lang dictionary_id='44019.Ürün'></th>
        </tr>
    </thead>
        
        <tbody id="SEPETIM">

        </tbody>
        <input type="hidden" name="is_submit">
        <input type="hidden" name="row_count" id="row_count">
        <input type="hidden" name="IV_DATE" id="IV_DATE">
        <input type="hidden" name="INVOICE_ID" id="INVOICE_ID">

    
</cf_big_list>
</cfform>
<script>
    var dsn2="<cfoutput>#dsn2#</cfoutput>";
var dsn3="<cfoutput>#dsn3#</cfoutput>";
var dsn="<cfoutput>#dsn#</cfoutput>";
</script>
<script src="/AddOns/Partner/ithalatFatura/ithalatFatura.js"></script>
