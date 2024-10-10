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
<cfset attributes.rows_=1>
<cfset 'attributes.deliver_date1'=now()>
<cfquery name="getProductInfo" datasource="#dsn3#">
    SELECT TOP 10 s.PRODUCT_NAME,S.STOCK_ID,PU.MAIN_UNIT,PU.PRODUCT_UNIT_ID,PRODUCT_CODE_2,S.PRODUCT_ID FROM STOCKS AS S INNER JOIN PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND IS_MAIN=1
 WHERE S.PRODUCT_ID=#attributes.PRODUCT_ID#
</cfquery>
<cfset i=1>
<cfset attributes.is_delivered=1>
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
<cfset 'attributes.lot_no#i#'=attributes.LBARKOD>
<cfset 'attributes.price_other#i#'=0>
<cfset 'attributes.spect_id#i#'="">
<CFSET 'attributes.wrk_row_relation_id#i#' ='#attributes.wwWRK_ROW_ID#'>

<cfset 'attributes.awrk_row_id#i#'="PBS#round(rand()*65)##dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHmmssL')##session.ep.userid##round(rand()*100)#">

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


 