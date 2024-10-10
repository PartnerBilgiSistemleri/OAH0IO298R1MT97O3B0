<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
<cf_box title="Giriş Etiket Yazdır">
    <div class="form-group">
        <label><cf_get_lang dictionary_id='58133.Fatura No'> / Trip No</label>
        <input type="text" name="INVOICE_NUMBER">        
    </div>
    <div class="form-group">
        <label><cf_get_lang dictionary_id='57637.Seri No'>(Lot No)</label>
        <input type="text" name="LOT_NO">        
    </div>
    <input type="hidden" name="is_submit">
    <input type="submit">
</cf_box>
</cfform>

<cfif isDefined("attributes.is_submit")>
    
    <cfif len(attributes.LOT_NO)>
        <script>
            <CFOUTPUT>windowopen("/index.cfm?fuseaction=objects.popup_print_files&iid=#attributes.LOT_NO#&action_id=8&action_type=#attributes.LOT_NO#|&print_type=10","page")</CFOUTPUT>
        </script>
    <cfelse>
        <cfquery name="getInvRow" datasource="#dsn2#">
            SELECT I.INVOICE_ID,IR.AMOUNT,IR.INVOICE_ROW_ID,IR.STOCK_ID,S.PRODUCT_CODE_2,S.PRODUCT_NAME,S.PRODUCT_ID  FROM INVOICE AS I INNER JOIN INVOICE_ROW AS IR ON IR.INVOICE_ID=I.INVOICE_ID
            INNER JOIN #dsn3#.STOCKS AS S ON S.STOCK_ID=IR.STOCK_ID
             WHERE 1=1 AND ( I.INVOICE_NUMBER='#attributes.INVOICE_NUMBER#' OR I.REF_NO='#attributes.INVOICE_NUMBER#')
        </cfquery>
        <cf_big_list>
            <thead>
                <tr>
                    <th>
                        <cf_get_lang dictionary_id='58800.Ürün Kodu'>
                    </th>
                    <th>
                        <cf_get_lang dictionary_id='44019.Ürün'>
                    </th>
                    <th>
                        <cf_get_lang dictionary_id='57635.Miktar'>
                    </th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
        <cfoutput query="getInvRow">
            <tr>
                <td>
                    #PRODUCT_CODE_2#
                </td>
                <td>
                    #PRODUCT_NAME#
                </td>
                <td>
                    #AMOUNT#
                </td>
                <td><button class="ui-wrk-btn ui-wrk-btn-success" onclick='windowopen("/index.cfm?fuseaction=objects.popup_print_files&iid=#PRODUCT_ID#|#INVOICE_ID#|#INVOICE_ROW_ID#|#AMOUNT#&action_id=1&action_type=#PRODUCT_ID#|#INVOICE_ID#|#INVOICE_ROW_ID#|#AMOUNT#&print_type=10","page")'><cf_get_lang dictionary_id='57474.Yazdir'></button></td>
            </tr>
        </cfoutput>
    </tbody>
    </cf_big_list>
    </cfif>
</cfif>