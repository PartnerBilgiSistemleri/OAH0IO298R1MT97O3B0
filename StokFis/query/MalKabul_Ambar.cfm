<cfdump var="#attributes#">
<cfset FormData=deserializeJSON(attributes.data)>

<cfdump var="#FormData#">

<cfset attributes.LOCATION_IN=    FormData.TO_LOCATION_DATA.LOCATION_ID>
<cfset attributes.department_in = FormData.TO_LOCATION_DATA.DEPARTMENT_ID>

<cfset attributes.LOCATION_OUT=   FormData.FROM_LOCATION_DATA.LOCATION_ID>
<cfset attributes.department_out= FormData.FROM_LOCATION_DATA.DEPARTMENT_ID>
<cfset form.process_cat=87>
<cfset attributes.process_cat = form.process_cat>
<cfset PROJECT_HEAD="">
<cfset PROJECT_HEAD_IN="">
<cfset PROJECT_ID="">
<cfset PROJECT_ID_IN="">
<cfset amount_other="">
<cfset unit_other="">
<cfset ROWC=0>
<cfloop array="#FormData.ROWS#" item="it" index="i">
    <CFSET ROWC++>
  <cfset attributes.RAF_KODU_GIRIS=FormData.SHELFDATA.SHELF_CODE>
  <cfset attributes.RAF_ID_GIRIS=FormData.SHELFDATA.SHELF_ID>
  <CFSET "attributes.STOCK_ID#i#"=it.STOCK_ID>
  <CFSET "attributes.PRODUCT_ID#i#"=it.PRODUCT_ID>
  <cfset "attributes.lot_no#i#"=it.LOT_NO>
  <cfset "attributes.QUANTITY#i#"=it.AMOUNT>
  <cfset "attributes.shelf_number#i#"=it.SHELF_NUMBER>
</cfloop>
<cfset attributes.ROWW=" ,">
<cfset ROW_COUNT=ROWC>
<cfinclude template="StokFisQuery_3.cfm">
<script>
  window.opener.location.reload();
  this.close();
</script>
<cfabort>




<cfset attributes.LOCATION_IN=FormData.DEPOLAR.Ambar.LOCATION_ID>
    <cfset attributes.LOCATION_OUT=FormData.DEPOLAR.MalKabul.LOCATION_ID>
    <cfset attributes.department_out=FormData.DEPOLAR.MalKabul.DEPARTMENT_ID>
    <cfset attributes.department_in =FormData.DEPOLAR.Ambar.DEPARTMENT_ID>
    <cfset attributes.stock_id=FormData.STOCK_ID>
    <cfset attributes.PRODUCT_ID=FormData.PRODUCT_ID>
    <cfset attributes.SHELFCODE=FormData.SHELF_CODE>
    <cfset attributes.PRODUCT_PLACE_ID=FormData.PRODUCT_PLACE_ID>
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
   <cfset lot_no=FormData.LOT_NO>
   <cfset attributes.LOT=FormData.LOT_NO>
 <cfset arguments.LOT_NUMARASI=attributes.LOT>
<cfset attributes.ROWW=" ,">
<cfdump var="#listLen(attributes.ROWW)#">
<cfinclude template="StokFisQuery.cfm">