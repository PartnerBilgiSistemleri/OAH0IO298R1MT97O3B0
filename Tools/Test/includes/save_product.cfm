
<cfif  1 eq 1>
    <cfquery name="get_barcode_no" datasource="#dsn1#">
        SELECT PRODUCT_NO AS BARCODE FROM PRODUCT_NO
    </cfquery>
    <cfset barcode_on_taki = '100000000000'>
    <cfset barcode = get_barcode_no.barcode>
    <cfset barcode_len = len(barcode)>
    <cfset barcode = left(barcode_on_taki,12-barcode_len)&barcode> 
<cfelse>
    <cfquery name="get_barcode_no" datasource="#dsn1#">
        SELECT LEFT(BARCODE, 12) AS BARCODE FROM PRODUCT_NO
    </cfquery>
    <cfset barcode = (get_barcode_no.barcode*1)+1>
    <cfquery name="upd_barcode_no" datasource="#dsn1#">
        UPDATE PRODUCT_NO SET BARCODE = '#barcode#X'
    </cfquery>
</cfif>
    <cfset barcode_tek = 0>
    <cfset barcode_cift =0>
    <cfif len(barcode) eq 12>
        <cfloop from="1" to="11" step="2" index="i">
            <cfset barcode_kontrol_1 = mid(barcode,i,1)>
            <cfset barcode_kontrol_2 = mid(barcode,i+1,1)>
            <cfset barcode_tek = (barcode_tek*1) + (barcode_kontrol_1*1)>
            <cfset barcode_cift = (barcode_cift*1) + (barcode_kontrol_2*1)>
        </cfloop>
        <cfset barcode_toplam = (barcode_cift*3)+(barcode_tek*1)>
        <cfset barcode_control_char = right(barcode_toplam,1)*1>
        <cfif barcode_control_char gt 0>
        <cfset barcode_control_char = 10-barcode_control_char>
    <cfelse>
        <cfset barcode_control_char = 0>
    </cfif>
    <cfset barcode_no = '#barcode##barcode_control_char#'>
<cfelse>
    <cfset barcode_no = ''>
</cfif>

<cfset UrunAdi="">
<cfloop array="#Urun.ITEMDESCRIPTIONS#" item="it">
    <cfif it.ITEMDESCRIPTIONQUALIFIER eq "SellerAssigned">
        <cfset UrunAdi="#it.DESCRIPTIONVALUE#">
    </cfif>
</cfloop>


<cfloop array="#Urun.ITEMIDENTIFIERS#" item="it">
    <cfif it.ITEMNUMBERQUALIFIER eq "SellerAssigned">
        <cfset PRODUCT_CODE_2_="#it.ITEMNUMBER#">
    </cfif>
</cfloop>
<cfloop array="#Urun.ITEMIDENTIFIERS#" item="it">
    <cfif it.ITEMNUMBERQUALIFIER eq "BuyerAssigned">
        <cfset MANUFACT_CODE_="#it.ITEMNUMBER#">
    </cfif>
</cfloop>

<CFSET CATID=PRODUCT_CAT_ID_PRT>
<cfset kategori_id=CATID>
<CFSET TAX_=18>
<CFSET TAX_PURCHASE_=18>
<CFSET IS_INVENTORY_=1>
<CFSET IS_PRODUCTION_=0>
<CFSET IS_SALES_=1>
<CFSET IS_PURCHASE_=1>
<CFSET IS_INTERNET_=1>
<CFSET IS_EXTRANET_=0>
<CFSET DIMENTION_="">
<cfset VOLUME_="">
<cfset WEIGHT_="">
<cfset surec_id=29>
<cfset PROD_COMPETITIVE_="">
<cfset MANUFACT_CODE_="">
<cfset BRAND_ID_="">
<cfset BRAND_ID_="">
<cfset short_code = ''>
<cfset short_code_id = "">
<cfset IS_LIMITED_STOCK_="">
<cfset MIN_MARGIN_="">
<cfset MAX_MARGIN_="">
<cfset SHELF_LIFE_="">
<cfset SEGMENT_ID_="">
<cfset BSMV_="">
<cfset OIV_="">
<cfset IS_ZERO_STOCK_="0">
<cfset IS_QUALITY_="">
<cfset alis_fiyat_kdvsiz = 0>
<cfset satis_fiyat_kdvli = 0>
<cfset alis_fiyat_kdvli = 0>
<cfset sales_money = "TL">
<cfset cesit_adi=''>
<cfset purchase_money = "TL">
<cfset Birim="Adet">
<cfset fiyat_yetkisi="">

<cfquery name="get_cat" datasource="#dsn1#">
    SELECT HIERARCHY FROM PRODUCT_CAT WHERE PRODUCT_CATID = #CATID#
</cfquery>
<cfset attributes.HIERARCHY = get_cat.HIERARCHY>

<cfinclude template="add_import_product.cfm">
