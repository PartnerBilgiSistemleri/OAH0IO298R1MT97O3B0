dsadas
<cfif isDefined("attributes.is_submit")>
    
<cfdump var="#attributes#">
<cfquery name="getLastLocation" datasource="#dsn2#">
SELECT top 1 LOT_NO,PROCESS_DATE,PROCESS_TIME,SHELF_NUMBER,PROCESS_TYPE,UPD_ID,STOCK_IN,STOCK_OUT,STORE,STORE_LOCATION,STOCK_ID,PRODUCT_ID
,CASE WHEN STOCK_OUT >0 AND PROCESS_TYPE=113 THEN 0 WHEN PROCESS_TYPE <> 113  THEN -1 ELSE 1 END AS AMBAR_SIRALAMA
 FROM #dsn2#.STOCKS_ROW WHERE LOT_NO IS NOT NULL AND LOT_NO='#attributes.LOT_NO#' 
ORDER BY PROCESS_DATE DESC ,AMBAR_SIRALAMA DESC

<!----
  SELECT TOP 1 LOT_NO,PROCESS_DATE,PROCESS_TIME,SHELF_NUMBER,PROCESS_TYPE,UPD_ID,STOCK_IN,STOCK_OUT,STORE,STORE_LOCATION,STOCK_ID,PRODUCT_ID
,CASE WHEN STOCK_OUT >0 AND PROCESS_TYPE=113 THEN 0 WHEN PROCESS_TYPE <> 113  THEN -1 ELSE 1 END AS AMBAR_SIRALAMA
 FROM #dsn2#.STOCKS_ROW WHERE LOT_NO IS NOT NULL AND LOT_NO='#attributes.LOT_NO#' 
ORDER BY PROCESS_DATE DESC ,AMBAR_SIRALAMA DESC---->
</cfquery>
<cfdump var="#getLastLocation#">
<cfquery name="getOldShelf" datasource="#dsn3#">
  select SHELF_CODE,PRODUCT_PLACE_ID from #dsn3#.PRODUCT_PLACE WHERE PRODUCT_PLACE_ID=#getLastLocation.SHELF_NUMBER#
</cfquery>
1-03-02

<cfquery name="getLastShelf" datasource="#dsn3#">
select  LOCATION_ID,STORE_ID,SHELF_CODE,PRODUCT_PLACE_ID from catalyst_prod_1.PRODUCT_PLACE
  WHERE  1=1 
AND SHELF_CODE='#attributes.SHELF_CODE#'
</cfquery>

<cfdump var="#attributes#">


    <cfset attributes.LOCATION_IN=getLastLocation.STORE_LOCATION>
    <cfset attributes.LOCATION_OUT=getLastLocation.STORE_LOCATION>
    <cfset attributes.department_out=getLastLocation.STORE>
    <cfset attributes.department_in =getLastLocation.STORE>

    <cfset attributes.stock_id=getLastLocation.STOCK_ID>
    <cfset attributes.PRODUCT_ID=getLastLocation.PRODUCT_ID>

    
    <cfset attributes.RAF_KODU_GIRIS=getLastShelf.SHELF_CODE>
    <cfset attributes.RAF_ID_GIRIS=getLastShelf.PRODUCT_PLACE_ID>


    <cfset attributes.RAF_KODU_CIKIS=getOldShelf.SHELF_CODE>
    <cfset attributes.RAF_ID_CIKIS=getOldShelf.PRODUCT_PLACE_ID>


    <cfset form.process_cat=87>
    <cfset attributes.process_cat = form.process_cat>

   <cfset PROJECT_HEAD="">
   <cfset PROJECT_HEAD_IN="">
   <cfset PROJECT_ID="">
   <cfset PROJECT_ID_IN="">
   <cfset attributes.QUANTITY=1>
   <cfset attributes.uniq_relation_id_="">
   <cfset amount_other="">
   <cfset unit_other="">
   <cfset attributes.clot=1>
   <cfset lot_no=attributes.LOT_NO>
   <cfset attributes.LOT=attributes.LOT_NO>
 <cfset arguments.LOT_NUMARASI=attributes.LOT_NO>
<cfset attributes.ROWW=" ,">
<cfdump var="#listLen(attributes.ROWW)#">


attributes.shelf_number
attributes.to_shelf_number
attributes.to_shelf_number_txt


66413
<cfinclude template="../query/StokFisQuery_2.cfm">

<script>
this.close();
  window.location.href="http://test.ashleyturkiye.com/index.cfm?fuseaction=stock.emptypopup_raf_to_raf&shelf=<cfoutput>#attributes.RAF_KODU_GIRIS#</cfoutput>"
</script>
<cflocation url="/index.cfm?fuseaction=#attributes.fuseaction#&shelf=#attributes.RAF_KODU_GIRIS#">

<cfabort>
</cfif>


<cf_box title="Raf Taşıma">
<div class="form-group">
  <label>
    <cf_get_lang dictionary_id='66413.Giriş Rafı'>
  </label>
    <input type="text" name="SHELF_CODE" id="SHELF_CODE" onkeyup="fklan(this,event)" value="<cfif isdefined('attributes.shelf')><cfoutput>#attributes.shelf#</cfoutput></cfif>" placeholder="<cf_get_lang dictionary_id='66413.Giriş Rafı'>">
</div>
<div class="form-group">
  <label><cf_get_lang dictionary_id='57637.Seri No'>(Lot No)o</label>
    <input type="text" name="LOT_NO" id="LOT_NO" placeholder="<cf_get_lang dictionary_id='57637.Seri No'>(Lot No)">
</div>
<button class="btn btn-success" onclick="Tasi()"><cf_get_lang dictionary_id='59906.Taşı'></button>
</cf_box>
	

<script>
$(document).ready(function () {
  //document.getElementById("SHELF_CODE").value="";
  document.getElementById("LOT_NO").value="";
  $("#LOT_NO").focus();
  <cfif isDefined("attributes.shelf")>fklaan()</cfif>
})
function Tasi(params) {
  var SHELF_CODE = document.getElementById("SHELF_CODE").value;
  var LOT_NO = document.getElementById("LOT_NO").value;
  var str = "/index.cfm?fuseaction=stock.emptypopup_raf_to_raf&is_submit=1";
  var formy = document.createElement("form");
  formy.setAttribute("action", str);
  formy.setAttribute("method", "post");
  var input = document.createElement("input");
  input.setAttribute("name", "SHELF_CODE");
  input.setAttribute("value", SHELF_CODE);
  formy.appendChild(input);

  var input = document.createElement("input");
  input.setAttribute("name", "LOT_NO");
  input.setAttribute("value", LOT_NO);
  formy.appendChild(input);
  //document.body.appendChild(formy);
  //formy.submit();
 $.post("/index.cfm?fuseaction=stock.emptypopup_raf_to_raf&is_submit=1&SHELF_CODE="+SHELF_CODE+"&LOT_NO="+LOT_NO).done( function (){
  alert("<cf_get_lang dictionary_id='66414.Movement completed successfully'>")
 //window.location.reload();
 window.location.href="/index.cfm?fuseaction=stock.emptypopup_raf_to_raf&shelf="+SHELF_CODE
 $("#LOT_NO").val("");
 $("#LOT_NO").focus();
}
 )

}
function fklan(el,ev){
  if(ev.keyCode==13){
  $("#LOT_NO").focus();}
}
function fklaan(el,ev){
  
  $("#LOT_NO").focus();
}
</script>

