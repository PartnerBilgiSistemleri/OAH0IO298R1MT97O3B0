<cfif not isDefined("attributes.RCS")>
   <script>
      alert("Ürün Seçili Değil")
      this.close();
      

   </script>
   <cfabort>
</cfif>

<cfinclude template="sevk_params.cfm">


<cfquery name="GETSEVK_TALEP" datasource="#DSN3#">
   SELECT * FROM LIST_SEVK_TALEP_#session.EP.PERIOD_YEAR# WHERE SVK_ID=#attributes.SVK_ID#
</cfquery>

SELECT SUM(STOCK_IN-STOCK_OUT),STORE,STORE_LOCATION FROM catalyst_prod_2024_1.STOCKS_ROW WHERE LOT_NO='503945568737' GROUP BY STORE,STORE_LOCATION HAVING SUM(STOCK_IN-STOCK_OUT)>0

<cfoutput>
   <CFSET ARR=arrayNew(1)>
<cfloop list="#attributes.RCS#" item="i" index="il">
   <cfset LOT_NO=evaluate("attributes.LOT_#i#")>
   <cfset PRODUCT_ID=evaluate("attributes.PRODUCT_ID_#i#")>
   <cfset STOCK_ID=evaluate("attributes.STOCK_ID_#i#")>
   <cfset SHELF_CODE=evaluate("attributes.SHELF_CODE_#i#")>
   <cfset SHELF_ID=evaluate("attributes.SHELF_ID_#i#")>
   <cfset WRK_ROW_ID=evaluate("attributes.WRK_ROW_ID_#i#")>
   <cfquery name="getProdcutLocation" datasource="#dsn2#">
      SELECT SUM(STOCK_IN-STOCK_OUT),STORE,STORE_LOCATION,B.BRANCH_ID FROM catalyst_prod_2024_1.STOCKS_ROW AS SR
INNER JOIN catalyst_prod.STOCKS_LOCATION AS SL ON SL.LOCATION_ID=SR.STORE_LOCATION AND SL.DEPARTMENT_ID=SR.STORE
INNER JOIN catalyst_prod.DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID
INNER JOIN catalyst_prod.BRANCH AS B ON B.BRANCH_ID=D.BRANCH_ID
WHERE LOT_NO='#LOT_NO#' GROUP BY STORE,STORE_LOCATION,B.BRANCH_ID HAVING SUM(STOCK_IN-STOCK_OUT)>0
   </cfquery>
   <cfif getProdcutLocation.recordCount eq 0>
      <div class="alert alert-danger">#LOT_NO# Seri Numaralı Ürün  Depoda Bulunmamaktadır !</div>
      <cfabort>
   </cfif>
      <div class="alert alert-danger">
         <p><b>PRODUCT_ID :</b>#PRODUCT_ID#</p>
         <p><b>STOCK_ID :</b>#STOCK_ID#</p>
         <p><b>LOT_NO :</b>#LOT_NO#</p>
         <p><b>SHELF_CODE :</b>#SHELF_CODE#</p>
         <p><b>SHELF_ID :</b>#SHELF_ID#</p>
         <p><b>WRK_ROW_ID :</b>#WRK_ROW_ID#</p>
         <p><b>DEPARTMENT_ID :</b>#getProdcutLocation.STORE#</p>
         <p><b>LOCATION_ID :</b>#getProdcutLocation.STORE_LOCATION#</p>
         <p><b>BRANCH_ID :</b>#getProdcutLocation.BRANCH_ID#</p>
         <p><b>DEPARTMENT_IN_ID :</b>#SEVK_DEPARTMAN#</p>
         <p><b>LOCATION_IN_ID :</b>#SEVK_LOKASYON#</p>
         <p><b>BRANCH_IN_ID :</b>#BRANCH_ID#</p>

         <p><b>BRANCH_IN_ID :</b>#BRANCH_ID#</p>
         <p><b>BRANCH_IN_ID :</b>#BRANCH_ID#</p>
      </div>
      <CFSET OBJ=structNew()>
      <CFSET OBJ.FROM_DEPARTMENT=getProdcutLocation.STORE>
      <CFSET OBJ.FROM_LOCATION=getProdcutLocation.STORE_LOCATION>
      <CFSET OBJ.TO_DEPARTMENT=SEVK_DEPARTMAN>
      <CFSET OBJ.TO_LOCATION=SEVK_LOKASYON>
      <CFSET OBJ.FROM_SHELF_CODE=SHELF_CODE>
      <CFSET OBJ.FROM_SHELF_ID=SHELF_ID>
      <CFSET OBJ.LOT_NO=LOT_NO>
      <CFSET OBJ.PRODUCT_ID=PRODUCT_ID>
      <CFSET OBJ.STOCK_ID=STOCK_ID>
      <CFSET OBJ.TO_SHELF_CODE="#SEVK_RAF_NO#">
      <CFSET OBJ.TO_SHELF_ID="#SEVK_RAF_ID#">
      <cfset OBJ.RELATION_ID="#WRK_ROW_ID#">
      <CFSET OBJ.REF_NO=GETSEVK_TALEP.SVK_NUMBER>
      <cfscript>
         arrayAppend(ARR,OBJ);
      </cfscript>
      <cfif attributes.IS_FROM_ORDER EQ 1>
         <cfquery name="UPDA" datasource="#DSN3#">
            UPDATE ORDER_ROW SET LOT_NO='#LOT_NO#',ORDER_ROW_CURRENCY=-6 WHERE WRK_ROW_ID='#WRK_ROW_ID#'
         </cfquery>
      <CFELSE>
         <cfquery name="UPDA" datasource="#DSN3#">
            UPDATE INTERNALDEMAND_ROW SET LOT_NO='#LOT_NO#' WHERE WRK_ROW_ID='#WRK_ROW_ID#'
         </cfquery>
      </cfif>
</cfloop>
<cfdump var="#ARR#">
</cfoutput>
<cfset SF_SERVICE = createObject("component","AddOns.Partner.StokFis.cfc.StokFis")>
<cfscript>
   Result=SF_SERVICE.SaveRafTasi((replace(serializeJSON(ARR),"//","")))
</cfscript>
<cfdump var="#Result#">

<script>

   window.opener.location.reload();
  this.close();
</script>
LOT_NO:it.LOT_NO,
PRODUCT_ID:it.PRODUCT_ID,
STOCK_ID:it.STOCK_ID,
TO_SHELF_CODE:it.TO_SHELF_CODE,
TO_SHELF_ID:it.TO_SHELF_ID