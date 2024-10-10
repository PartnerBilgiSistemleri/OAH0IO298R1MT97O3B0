<cfif isDefined("attributes.is_submit")>
    <cfdump var="#attributes#">
    
    <cfquery name="GETMAXID" datasource="#DSN2#">
        SELECT MAX(SHIP_ID) AS MXIDD FROM SHIP
    </cfquery>
    <cfset attributes.rows_=attributes.ROW_COUNT>
    <cfset SHIP_NUMBER='IMG-#GETMAXID.MXIDD#'>
    <cfset attributes.ACTIVE_PERIOD=session.ep.period_id>
    
    <cfquery name="GETMAXID" datasource="#DSN2#">
        SELECT MAX(SHIP_ID) AS MXIDD FROM SHIP
    </cfquery>
    <cfquery name="getper" datasource="#dsn#">
        SELECT * FROM SETUP_PERIOD WHERE PERIOD_YEAR=#attributes.IV_DATE# AND OUR_COMPANY_ID=1
    </cfquery>
      <cfset DELIVER_IN_DEPT=1>
      <cfset DELIVER__IN_LOC=2>
      <cfset PROCESS__IN_TYPE=811>
      <cfquery name="GETSHIP_ROW" datasource="#DSN2#">
        SELECT * FROM SHIP_ROW WHERE SHIP_ID=#GETMAXID.MXIDD#
      </cfquery>
<cfset attributes.process_cat=198>
<cfset form.process_cat=198>
<cfset attributes.ship_date=now()>
<cfset attributes.deliver_date_frm=now()>

<cfset attributes.department_in_id=1> <!---- mal kabul----->
<cfset attributes.location_in_id=2> <!---- mal kabul----->

<cfset attributes.location_id =1>
<cfset attributes.DEPARTMENT_ID =20> 

<cfset attributes.DELIVER_DATE_H =0>
<cfset attributes.deliver_date_m =0>

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
    SELECT TOP 10 s.PRODUCT_NAME,S.STOCK_ID,PU.MAIN_UNIT,PU.PRODUCT_UNIT_ID,PRODUCT_CODE_2,S.PRODUCT_ID FROM STOCKS AS S INNER JOIN PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND IS_MAIN=1
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
<cfset 'attributes.row_taxtotal#i#'=0>
<cfset 'attributes.lot_no#i#'="#evaluate('attributes.LOT_NO_#i#')#">
<cfset 'attributes.price_other#i#'=0>
<cfset 'attributes.spect_id#i#'="">
<CFSET 'attributes.wrk_row_relation_id#i#' ="#evaluate('attributes.WRK_ROW_ID_#i#')#">
<cfset 'attributes.awrk_row_id#i#'="PBS#round(rand()*65)##dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHmmssL')##session.ep.userid##round(rand()*100)#">

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
        <cfquery name="UP1" datasource="#DSN2#">
            update  STOCKS_ROW set LOT_NO=NULL where UPD_ID=#PBS_IIID# and PROCESS_TYPE=811 and STOCK_OUT>0
        </cfquery>
<script>
    window.location.href="/index.cfm?fuseaction=invoice.emptypopup_ithal_mal_girisi";
</script>
</cfif>
<table>
    <tr>

    <td>
<div class="form-group">
    <label>Fatura No</label>
    <cfquery name="GETF" datasource="#DSN2#">
SELECT DISTINCT INVOICE_ID
	,INVOICE_NUMBER
	,PROCESS_STAGE
    ,REF_NO
	
FROM (
	SELECT INVOICE_NUMBER
		,I.INVOICE_ID
		,IR.AMOUNT
		,I.PROCESS_STAGE
        ,I.REF_NO
		,(
			SELECT SUM(AMOUNT)
			FROM #dsn2#.SHIP_ROW AS SR
			INNER JOIN #dsn2#.SHIP AS S ON S.SHIP_ID = SR.SHIP_ID
			WHERE 1 = 1
				AND WRK_ROW_RELATION_ID = IR.WRK_ROW_ID
				AND S.SHIP_TYPE = 811
			) AS AC
	FROM #dsn2#.INVOICE AS I
	INNER JOIN #dsn2#.INVOICE_ROW AS IR ON IR.INVOICE_ID = I.INVOICE_ID
	WHERE INVOICE_CAT = 591
		AND ISNULL(I.PROCESS_STAGE, 0) <> 258
        AND PROCESS_CAT=128
	) AS IRRS
WHERE ISNULL(AC, 0) < AMOUNT

    </cfquery>
    
    <SELECT name="FaturaNo" id="FaturaNo" onchange="getFatura(this,event)">
        <option value="">Seçiniz</option>
        <cfoutput query="GETF">
            <option value="#INVOICE_NUMBER#">#INVOICE_NUMBER# / #REF_NO#</option>
        </cfoutput>
    </SELECT>
    <!---<input type="text" name="FaturaNo" id="FaturaNo" onkeyup="getFatura(this,event)">---->
</div>
</td>
<td>
<div class="form-group">
    <label>Seri No(Lot No)</label>
    <input type="text" name="LotNo" id="LotNo" onkeyup="getLot(this,event)">
</div>
</td>
<td>
    <input type="button" onclick="Kaydet()" value="Kaydet">
</td>
<td>
    <button type="button" onclick="Temizle()" class="ui-wrk-btn ui-wrk-btn-warning" value="">Yeni Fatura Kaydı</button>
</td>
<td>
    <button id="lotumcu" type="button" onclick="AcCanim()" class="ui-wrk-btn ui-wrk-btn-busy" value="">Lot Durumu</button>
</td>
</tr>
</table>

<cfform id="Form1" method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
<cf_big_list>
    <thead>
        <tr>
            <th>#</th>
            <th>Seri No (Lot No)</th>
            <th>Ürün Kodu</th>
            <th>Ürün</th>
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
    var dsn="<cfoutput>#dsn#</cfoutput>";
    var dsn1="<cfoutput>#dsn1#</cfoutput>";
    var dsn2="<cfoutput>#dsn2#</cfoutput>";
    var dsn3="<cfoutput>#dsn3#</cfoutput>";
</script>
<script src="/AddOns/Partner/ithalatFatura/ithalatFatura_00.js"></script>
