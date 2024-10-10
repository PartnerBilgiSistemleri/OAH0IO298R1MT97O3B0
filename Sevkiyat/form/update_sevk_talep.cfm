<cfquery name="GETSVK" datasource="#DSN3#">
    SELECT * FROM catalyst_prod_1.LIST_SEVK_TALEP_#session.ep.PERIOD_YEAR# WHERE SVK_ID=#attributes.SVK_ID# AND FROM_ORDER=#attributes.FROM_ORDER#
</cfquery>

<cf_box title="Sevk Emri - #getSvk.SVK_NUMBER#" scroll="1" collapsable="1" resize="1" popup_box="1">
<cfoutput>
    <cf_ajax_list>
            <tr>
                <th>
                    Müşteri / Departman
                </th>
                <td>
                    #GETSVK.MUSTERI#
                </td>
                <th>
                    Sevk Tarihi
                </th>
                <th>
                    #dateFormat(GETSVK.DELIVER_DATE,"dd/mm/yyyy")#
                </th>
            </tr>
            <tr>
                <th>
                    Teslim Departmanı
                </th>
                <td>
                    <cfquery name="GETD" datasource="#DSN#">
                        select D.DEPARTMENT_HEAD,SL.COMMENT from catalyst_prod.STOCKS_LOCATION AS SL
INNER JOIN catalyst_prod.DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID
WHERE SL.DEPARTMENT_ID=#GETSVK.DEPARTMENT_ID# AND SL.LOCATION_ID=#GETSVK.LOCATION_ID#
                    </cfquery>
                    #GETD.DEPARTMENT_HEAD#
                </td>
                <th>
                    Teslim Lokasyonu
                </th>
                <td>
                    #GETD.COMMENT#
                </td>
            </tr>
            <tr>
                <td style="font-weight:bold">
                    Kaydeden :
                </td>
                <td style="color:blue" colspan="3">#GETSVK.KAYIT_PERS# (#dateformat(GETSVK.RECORD_DATE,"dd/mm/yyyy")# #timeFormat(GETSVK.RECORD_DATE,"hh:mm")#)</td>
            </tr>
    </cf_ajax_list>
    <cfquery name="getRows" datasource="#dsn3#">
        <cfif attributes.from_order eq 1>
            SELECT S.PRODUCT_NAME,S.PRODUCT_CODE_2,ORR.QUANTITY,ORR.UNIT,ORR.WRK_ROW_ID,ISNULL(LS.AMOUNT,0) AS VERILEN,(ORR.QUANTITY-ISNULL(LS.AMOUNT,0)) AS KALAN FROM catalyst_prod_1.ORDER_ROW AS ORR 
    LEFT JOIN catalyst_prod_1.STOCKS AS S ON S.STOCK_ID=ORR.STOCK_ID
    LEFT JOIN catalyst_prod_1.LIST_SEVK_TALEP_ROWS_#session.ep.PERIOD_YEAR# AS LS ON LS.WRK_ROW_ID=ORR.WRK_ROW_ID AND FROM_ORDER=1
    WHERE LS.SVK_ID=#attributes.SVK_ID#
        </cfif>
        <cfif attributes.from_order eq 0>
            SELECT S.PRODUCT_NAME,S.PRODUCT_CODE_2,ORR.QUANTITY,ORR.UNIT,ORR.WRK_ROW_ID,ISNULL(LS.AMOUNT,0) AS VERILEN,(ORR.QUANTITY-ISNULL(LS.AMOUNT,0)) AS KALAN FROM catalyst_prod_1.INTERNALDEMAND_ROW AS ORR 
    LEFT JOIN catalyst_prod_1.STOCKS AS S ON S.STOCK_ID=ORR.STOCK_ID
    LEFT JOIN catalyst_prod_1.LIST_SEVK_TALEP_ROWS_#session.ep.PERIOD_YEAR# AS LS ON LS.WRK_ROW_ID=ORR.WRK_ROW_ID AND FROM_ORDER=0
    WHERE 
    LS.SVK_ID=#attributes.SVK_ID#
        </cfif>
    </cfquery>
<cf_ajax_list class="table">
   <thead>
    <tr>
        <th>
            SKU
        </th>
        <th>Ürün</th>
        <th>Miktar</th>
    </tr>
</thead>
<tbody>
    <cfloop query="getRows">
        <tr>
            <td>
                #PRODUCT_CODE_2#
            </td>
            <td>#PRODUCT_NAME#</td>
            <td>#VERILEN#</td>
        </tr>
    </cfloop>
</tbody>
</cf_ajax_list>
</cfoutput>
</cf_box>