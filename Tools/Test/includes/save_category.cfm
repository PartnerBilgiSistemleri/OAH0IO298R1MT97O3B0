
<cfquery name="getCompanies" datasource="#dsn#">
    select COMP_ID from OUR_COMPANY
</cfquery>

<cfquery name="ishv1" datasource="#dsn1#">
      SELECT * FROM PRODUCT_CAT WHERE HIERARCHY='80.#Urun.retailSalesCategory#'
</cfquery>

<cfif ishv1.recordCount>
<cfelse>
    <cfset hierarchy=""> <cfset DETAIL="">
    <cfset attributes.is_public=1>
<cfset attributes.product_cat="80.#Urun.retailSalesCategory#">
<cfset form.product_cat_code="80.#Urun.retailSalesCategory#">
<cfset attributes.detail="">
<cfset attributes.list_order_no="">
<cfset attributes.profit_margin_min="">
<cfset attributes.profit_margin_max="">
<cfset attributes.our_company_ids=valueList(getCompanies.COMP_ID)>
<cfinclude template="add_product_cat_partner.cfm">
</cfif>


<cfquery name="ishv2" datasource="#dsn1#">
    SELECT * FROM PRODUCT_CAT WHERE HIERARCHY='80.#Urun.retailSalesCategory#.#Urun.itemClass#'
</cfquery>

<cfif ishv2.recordCount>
<cfelse>
  <cfset hierarchy=""> <cfset DETAIL="">
  <cfset attributes.is_public=1>
<cfset attributes.product_cat="#Urun.retailSalesCategory#.#Urun.itemClass#">
<cfset form.product_cat_code="#Urun.retailSalesCategory#.#Urun.itemClass#">
<cfset attributes.detail="">
<cfset attributes.list_order_no="">
<cfset attributes.profit_margin_min="">
<cfset attributes.profit_margin_max="">
<cfset attributes.our_company_ids=valueList(getCompanies.COMP_ID)>
<cfinclude template="add_product_cat_partner.cfm">
</cfif>





<cfquery name="IsHaveCat" datasource="#dsn1#">
    SELECT * FROM PRODUCT_CAT WHERE HIERARCHY='#attributes.HIERARCHY#'
</cfquery>


<cfif IsHaveCat.recordCount>
    <!---Urun Eklemesi için Kategori id falan Kullanılacak işte----->
    <cfset PRODUCT_CAT_ID_PRT=IsHaveCat.PRODUCT_CATID>
<cfelse>
    <cfset hierarchy=""> <cfset DETAIL="">
    <cfset attributes.is_public=1>
<cfset attributes.product_cat=attributes.HIERARCHY>
<cfset form.product_cat_code=attributes.HIERARCHY>
<cfset attributes.detail="">
<cfset attributes.list_order_no="">
<cfset attributes.profit_margin_min="">
<cfset attributes.profit_margin_max="">
<cfset attributes.our_company_ids=valueList(getCompanies.COMP_ID)>
<cfinclude template="add_product_cat_partner.cfm">
<cfquery name="IsHaveCat" datasource="#dsn1#">
    SELECT * FROM PRODUCT_CAT WHERE HIERARCHY='#attributes.HIERARCHY#'
</cfquery>
<cfset PRODUCT_CAT_ID_PRT=IsHaveCat.PRODUCT_CATID>
</cfif>
