<cf_box title="Lot Detayları">
<cfquery name="getData" datasource="#dsn2#">
    SELECT TB.*,D.DEPARTMENT_HEAD,SL.COMMENT,PP.SHELF_CODE,SL.DEPARTMENT_LOCATION FROM (
SELECT SUM(STOCK_IN-STOCK_OUT) AS B ,ISNULL(LOT_NO,'') LOT_NO,SHELF_NUMBER,STORE,STORE_LOCATION FROM STOCKS_ROW 
WHERE STOCK_ID=#attributes.stock_id# GROUP BY ISNULL(LOT_NO,''),SHELF_NUMBER,STORE,STORE_LOCATION
) AS TB 
LEFT JOIN #dsn#.DEPARTMENT AS D ON D.DEPARTMENT_ID=TB.STORE
LEFT JOIN #dsn#.STOCKS_LOCATION AS SL ON SL.LOCATION_ID=TB.STORE_LOCATION AND SL.DEPARTMENT_ID=TB.STORE
LEFT JOIN #dsn3#.PRODUCT_PLACE AS PP ON PP.PRODUCT_PLACE_ID=TB.SHELF_NUMBER
WHERE B>0
ORDER BY STORE,STORE_LOCATION
</cfquery>
<CFSET GENTOP=0>
<cfoutput query="getData">
    <cfif isDefined("stok_miktar_#STORE#_#STORE_LOCATION#")>
        <CFSET "stok_miktar_#STORE#_#STORE_LOCATION#"=evaluate("stok_miktar_#STORE#_#STORE_LOCATION#")+B>        
    <CFELSE>
        <CFSET "stok_miktar_#STORE#_#STORE_LOCATION#"=B>        
    </cfif>
    <CFSET GENTOP=GENTOP+B>
</cfoutput>



<cf_ajax_list>
    <thead>
    <tr>
        <th>Depo</th>
        <th>Raf</th>
        <th>Seri (Lot No)</th>
        <th>Miktar</th>
    </tr>
</thead>
<tbody>
    <cfset dx=0>
<cfoutput query="getData" group="DEPARTMENT_HEAD">
<tr>
    <td colspan="4" onclick="$('.dte_#dx#').toggle()">
       <a href="javascript://"> #DEPARTMENT_HEAD#</a> 
       
       <span class="badge" style="float: right;">
       #tlformat(evaluate("stok_miktar_#STORE#_#STORE_LOCATION#"))#
    </td>

</tr>
<cfoutput>
    <tr style="display:none" class="dte_#dx#">
        <td>
            #DEPARTMENT_HEAD#-#COMMENT#
        </td>
        <td>
            <cfif len(SHELF_CODE)>
           #DEPARTMENT_LOCATION#-#SHELF_CODE# 
        </cfif>
        </td>
        <td>
            #LOT_NO# 
        </td>
        <td>
            #B# 
        </td>
    </tr>
</cfoutput>
    <cfset dx=dx+1>
</cfoutput>
</tbody>
<tfoot>
    <tr>
        <td colspan="4">
            <cfoutput>
                <a href="javascript://"> TOPLAM</a> 
       
       <span class="badge" style="float: right;">
       #tlformat(GENTOP)#
            </cfoutput>
        </td>
    </tr>
</tfoot>
</cf_ajax_list>
</cf_box>