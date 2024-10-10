
<cfif attributes.tip eq 3>
    <cfinclude template="../Form/add_sevktalep_from_orders.cfm">
    <cfabort>
</cfif>




<cfif isDefined("attributes.is_submit")>
    <cfinclude template="/AddOns/Partner/Sevkiyat/query/QueryAddSvkTalep.cfm">
</cfif>



<style>

    .form-group input[type=text], .form-group input[type=tel],.form-group input[type=date], .form-group input[type=search], input[type=search], .form-group input[type=number], .form-group input[type=password], .form-group input[type=file], .form-group select {
    width: 100% !important;
    min-height: 23px;
    font-family: 'Roboto';
    padding: 1px 25px 1px 5px;
    font-size: 12px;
    outline: none;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    -webkit-box-shadow: 0;
    box-shadow: 0;
    border-radius: 0;
    border: 1px solid #ccc;
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
}
</style>

<cfquery name="getOrderSvk" datasource="#dsn3#">
    select * from catalyst_prod_1.LIST_SEVK_TALEP_#session.ep.PERIOD_YEAR# WHERE ACTION_ID=#attributes.ACTION_ID# and FROM_ORDER=#attributes.FROM_ORDER#
</cfquery>







<cf_box title="Sevk Emri -Kayıt " scroll="0" collapsable="0" resize="0" popup_box="0">

    <cf_box title="Sevk Emirleri" scroll="0" collapsable="0" resize="0" popup_box="0">
    <div class="list-group">
        <cfoutput query="getOrderSvk">
     <a href="javascript://" onclick="openBoxDraggable('index.cfm?fuseaction=sales.emptypopup_detail_sevk_talep&SVK_ID=#getOrderSvk.SVK_ID#&from_order=#attributes.FROM_ORDER#')" class="list-group-item">#SVK_NUMBER#</a>   
    </cfoutput>
</div>
</cf_box>

    <cfquery name="getrde" datasource="#DSN#">

    SELECT D.DEPARTMENT_HEAD,SL.COMMENT,SL.DEPARTMENT_LOCATION,D.DEPARTMENT_ID
FROM #dsn#.DEPARTMENT AS D
INNER JOIN STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=D.DEPARTMENT_ID
WHERE BRANCH_ID IN (
       SELECT D.BRANCH_ID AS B2
       FROM #dsn#.EMPLOYEE_POSITIONS
       INNER JOIN #dsn#.DEPARTMENT AS D2 ON D2.DEPARTMENT_ID = EMPLOYEE_POSITIONS.DEPARTMENT_ID
       WHERE EMPLOYEE_ID = #session.ep.userid#
       ) ORDER BY D.DEPARTMENT_ID
</cfquery>

<cfquery name="getRows" datasource="#dsn3#">
    <cfif attributes.from_order eq 1>
        SELECT S.PRODUCT_NAME,S.PRODUCT_CODE_2,ORR.QUANTITY,ORR.UNIT,ORR.WRK_ROW_ID,ISNULL(LS.AMOUNT,0) AS VERILEN,
       ISNULL((SELECT SUM(AMOUNT) FROM catalyst_prod_1.LIST_SEVK_TALEP_ROWS_2024 WHERE WRK_ROW_ID=ORR.WRK_ROW_ID),0) AS TV,
        (ORR.QUANTITY-ISNULL((SELECT SUM(AMOUNT) FROM catalyst_prod_1.LIST_SEVK_TALEP_ROWS_2024 WHERE WRK_ROW_ID=ORR.WRK_ROW_ID),0)) AS KALAN FROM catalyst_prod_1.ORDER_ROW AS ORR 
LEFT JOIN catalyst_prod_1.STOCKS AS S ON S.STOCK_ID=ORR.STOCK_ID
LEFT JOIN catalyst_prod_1.LIST_SEVK_TALEP_ROWS_2024 AS LS ON LS.WRK_ROW_ID=ORR.WRK_ROW_ID AND FROM_ORDER=1
WHERE ORDER_ID=#attributes.ACTION_ID#
    </cfif>
    <cfif attributes.from_order eq 0>
        SELECT S.PRODUCT_NAME,S.PRODUCT_CODE_2,ORR.QUANTITY,ORR.UNIT,ORR.WRK_ROW_ID,ISNULL(LS.AMOUNT,0) AS VERILEN,
        ISNULL((SELECT SUM(AMOUNT) FROM catalyst_prod_1.LIST_SEVK_TALEP_ROWS_2024 WHERE WRK_ROW_ID=ORR.WRK_ROW_ID),0) AS TV,
        (ORR.QUANTITY-ISNULL((SELECT SUM(AMOUNT) FROM catalyst_prod_1.LIST_SEVK_TALEP_ROWS_2024 WHERE WRK_ROW_ID=ORR.WRK_ROW_ID),0) ) AS KALAN FROM catalyst_prod_1.INTERNALDEMAND_ROW AS ORR 
LEFT JOIN catalyst_prod_1.STOCKS AS S ON S.STOCK_ID=ORR.STOCK_ID
LEFT JOIN catalyst_prod_1.LIST_SEVK_TALEP_ROWS_2024 AS LS ON LS.WRK_ROW_ID=ORR.WRK_ROW_ID AND FROM_ORDER=0
WHERE 
 I_ID=#attributes.ACTION_ID#
    </cfif>
</cfquery>

<cf_box>
<cfform name="FORM1" id="FORM1">
    <input type="hidden" name="FROM_ORDER" value="<CFOUTPUT>#attributes.FROM_ORDER#</CFOUTPUT>">
    <input type="hidden" name="ACTION_ID" value="<CFOUTPUT>#attributes.ACTION_ID#</CFOUTPUT>">
    <input type="hidden" name="is_submit">
    <div class="form-group">
        <label>Teslim Tarihi</label>
        <input type="date" name="DELIVER_DATE">
    </div>
    <div class="form-group">
        <label>Teslim Depo</label>
        <select name="deliver_dept">
        <cfoutput query="getrde" group="DEPARTMENT_ID">
            <optgroup label="#DEPARTMENT_HEAD#">
                <cfoutput>
                    <option value="#DEPARTMENT_LOCATION#">#COMMENT#</option>
                </cfoutput>
            </optgroup>
        </cfoutput>
    </select>
    </div>
<cf_grid_list>
    <tr>
        <th>
            SKU
        </th>
        <th>
            Ürün
        </th>
        <th>
            Belge Miktarı
        </th>
        <th>
            Verilen
        </th>
        <th>
            Kalan
        </th>
        <th>Birim</th>
        <th></th>
    </tr>
    <cfset SONKALAN=0>
    <cfoutput query="getRows">
        <tr>
            <td>
                #PRODUCT_CODE_2#
            </td>
            <td>
                #PRODUCT_NAME#
            </td>
            <td>
                #QUANTITY#
            </td>
            <td>
                #TV#
            </td>
            <td>
                <input type="text" name="KALAN_#WRK_ROW_ID#" value="#KALAN#">
            </td>
            <td>#UNIT#</td>
            <TD style="text-align:center">
                <cfif KALAN NEQ 0>
                <input type="checkbox" name="SatirCim" value="#WRK_ROW_ID#">
                <CFELSE>
                    <i class="fa fa-check" style="font-size:12pt;color:green"></i>
            </cfif>
            </TD>
        </tr>
        <cfset SONKALAN=SONKALAN+KALAN>
    </cfoutput>
</cf_grid_list>

</cfform>




    <div class="form-group">
       <cfif SONKALAN NEQ 0> <a id="ui-otherFileBtn_box_search_stock_list_purchase" onclick="Kaydet()" href="javascript://" class="ui-btn ui-btn-blue ui-btn-addon-right">Kaydet<i class="fa fa-save"></i></a>
       <cfelse>
        <a class="ui-btn ui-btn-gray ui-btn-addon-right">Tamamına Emir Verildi</a>
    </cfif>
      </div>
</cf_box>


</cf_box>


<script>
    function Kaydet(params) {
        $("#FORM1").submit();
    }
</script>