<cfdump var="#attributes#">
<cfquery name="getRows" datasource="#dsn3#">
<cfif attributes.IS_FROM_ORDER eq 1>
    SELECT ORR.ORDER_ROW_CURRENCY,LSL.AMOUNT AS QUANTITY,ORR.WRK_ROW_ID,S.STOCK_ID,S.PRODUCT_ID,S.PRODUCT_NAME,S.PRODUCT_CODE_2,S.PRODUCT_CODE,S.PRODUCT_CODE_2,ISNULL(ORR.LOT_NO,'') LOT_NO,ISNULL((SELECT SUM(AMOUNT) FROM #DSN2#.STOCK_FIS_ROW WHERE WRK_ROW_RELATION_ID=LSL.WRK_ROW_ID),0) AS HAZD  FROM #DSN3#.ORDER_ROW AS ORR  
INNER JOIN #DSN3#.STOCKS AS S ON S.STOCK_ID=ORR.STOCK_ID
INNER JOIN #DSN3#.LIST_SEVK_TALEP_ROWS_2024 AS LSL ON LSL.SVK_ID=#attributes.SVK_ID# AND LSL.WRK_ROW_ID=ORR.WRK_ROW_ID
WHERE ORDER_ID=#attributes.ACTION_ID#
<cfelse>
    SELECT -6 AS ORDER_ROW_CURRENCY, LSL.AMOUNT AS QUANTITY,ORR.WRK_ROW_ID,S.STOCK_ID,S.PRODUCT_ID,S.PRODUCT_NAME,S.PRODUCT_CODE_2,S.PRODUCT_CODE,S.PRODUCT_CODE_2,ISNULL(ORR.LOT_NO,'') LOT_NO,ISNULL((SELECT SUM(AMOUNT) FROM #DSN2#.STOCK_FIS_ROW WHERE WRK_ROW_RELATION_ID=LSL.WRK_ROW_ID),0) AS HAZD
FROM #DSN3#.INTERNALDEMAND_ROW AS ORR  
INNER JOIN #DSN3#.STOCKS AS S ON S.STOCK_ID=ORR.STOCK_ID
INNER JOIN #DSN3#.LIST_SEVK_TALEP_ROWS_2024 AS LSL ON LSL.SVK_ID=#attributes.SVK_ID# AND LSL.WRK_ROW_ID=ORR.WRK_ROW_ID
WHERE I_ID=#attributes.ACTION_ID#
</cfif>
</cfquery>
<cfdump var="#getRows#">
<cf_big_list>
    <tr>
        <th>
            Ürün K
        </th>
        <th>
            Üretici Kodu
        </th>
        <th>
            Ürün
        </th>
        <th>
            Ürün Rafı
        </th>
        <th>
            Miktar
        </th>
        
        <th>
            Lot 
        </th>
        <th>
           Lot Rafı
        </th>
     

    </tr>
    <cfform method="post" id="frm1" action="#request.self#?fuseaction=sales.emptypopup_add_hazirlama_query" onsubmit="event.preventDefault();">
        <input type="hidden" name="RC" value="<cfoutput>#getRows.recordCount#</cfoutput>">
        <input type="hidden" name="ACTION_ID" value="<cfoutput>#attributes.ACTION_ID#</cfoutput>">
        <input type="hidden" name="SVK_ID" value="<cfoutput>#attributes.SVK_ID#</cfoutput>">
        <input type="hidden" name="IS_FROM_ORDER" value="<cfoutput>#attributes.IS_FROM_ORDER#</cfoutput>">
    <cfoutput query="getRows">
    
        <tr class="SEPET_ROW" id="SEPET_ROW_#currentrow#">
            <td>
                #PRODUCT_CODE#
            </td>
            <td>
                #PRODUCT_CODE_2#
            </td>
            <td>
                #PRODUCT_NAME#
            </td>
            <td>
                <cfquery name="getShelfes" datasource="#dsn3#">
                    SELECT  DISTINCT SHELF_CODE,STORE,STORE_LOCATION,SHELF_NUMBER FROM (
                    SELECT SUM(STOCK_IN - STOCK_OUT) AS B
                        ,SR.STOCK_ID
                        ,SR.STORE
                        ,SR.STORE_LOCATION
                        ,SR.SHELF_NUMBER
                        ,SR.LOT_NO
                        ,PP.SHELF_CODE
                    FROM #dsn2#.STOCKS_ROW AS SR
                    INNER JOIN #dsn3#.PRODUCT_PLACE AS PP ON PP.PRODUCT_PLACE_ID = SR.SHELF_NUMBER
                    WHERE SHELF_NUMBER IS NOT NULL
                        AND STOCK_ID = #STOCK_ID#
                    GROUP BY STOCK_ID
                        ,STORE
                        ,STORE_LOCATION
                        ,SHELF_NUMBER
                        ,LOT_NO
                        ,PP.SHELF_CODE
                    ) AS T WHERE B>0                    
                </cfquery>
                <cfloop query="getShelfes">
                    #SHELF_CODE# <br>
                </cfloop>
            </td>           
            <td>
                #QUANTITY#
            </td>
            
            
            <td>
                <div class="form-group">
                <input type="text" data-row="#currentrow#" onkeyup="save(this,event)" required name="LOT_#currentrow#" id="LOT_#currentrow#" value="#LOT_NO#">
                <input type="hidden" name="PRODUCT_ID_#currentrow#" id="PRODUCT_ID_#currentrow#"  value="#PRODUCT_ID#">
                <input type="hidden" name="STOCK_ID_#currentrow#" id="STOCK_ID_#currentrow#" value="#STOCK_ID#">
                <input type="hidden" name="WRK_ROW_ID_#currentrow#" id="WRK_ROW_ID_#currentrow#" value="#WRK_ROW_ID#">
            </div>
            </td>
            <td style="width:10%">
                <cfquery name="getShelfes1" datasource="#dsn3#">
                    SELECT  DISTINCT SHELF_CODE,STORE,STORE_LOCATION,SHELF_NUMBER FROM (
                    SELECT SUM(STOCK_IN - STOCK_OUT) AS B
                        ,SR.STOCK_ID
                        ,SR.STORE
                        ,SR.STORE_LOCATION
                        ,SR.SHELF_NUMBER
                        ,SR.LOT_NO
                        ,PP.SHELF_CODE
                    FROM #dsn2#.STOCKS_ROW AS SR
                    INNER JOIN #dsn3#.PRODUCT_PLACE AS PP ON PP.PRODUCT_PLACE_ID = SR.SHELF_NUMBER
                    WHERE SHELF_NUMBER IS NOT NULL
                        AND STOCK_ID = #STOCK_ID#
                        AND SR.LOT_NO='#LOT_NO#'
                    GROUP BY STOCK_ID
                        ,STORE
                        ,STORE_LOCATION
                        ,SHELF_NUMBER
                        ,LOT_NO
                        ,PP.SHELF_CODE
                    ) AS T WHERE B>0                    
                </cfquery>
            <div class="form-group">
                <input type="text" readonly name="SHELF_CODE_#currentrow#" id="SHELF_CODE_#currentrow#" required value="#getShelfes1.SHELF_CODE#">
                <input type="hidden" name="SHELF_ID_#currentrow#" id="SHELF_ID_#currentrow#" value="#getShelfes1.SHELF_NUMBER#">
            </div>
            </td>
         <td>
            <CFIF HAZD LT QUANTITY>
            <input type="checkbox" name="RCS" value="#currentrow#">
            <cfelse>
                <span style="color:green">Ok</span>
        </CFIF>
         </td>
        </tr>
    </cfoutput>
    <button type="button" onclick="Gonder()" >Kaydet</button>
</cfform>
</cf_big_list>
<script>
    var dsn="<cfoutput>#dsn#</cfoutput>";
    var dsn1="<cfoutput>#dsn1#</cfoutput>";
    var dsn2="<cfoutput>#dsn2#</cfoutput>";
    var dsn3="<cfoutput>#dsn3#</cfoutput>";
</script>
<script>
    function save(el,ev) {

        if(ev.keyCode==13){
            ev.preventDefault();
            var rw=el.getAttribute("data-row");
            rw=parseInt(rw);
            var q=rafGetir(el.value);
            if(q ==false){
                alert("Ürün Herhangi Bir Rafta Kayıtlı Değildir")
                el.value="";
                return false;
                
            }else{
                $("#SHELF_CODE_"+rw).val(q.SHELF_CODE)
                $("#SHELF_ID_"+rw).val(q.SHELF_NUMBER)
            }
            
            var rwNext=rw+1;
            $("#LOT_"+rwNext).focus();
            el.parentElement.parentElement.setAttribute("style","background-color:#85ff0045")
        }
    }
    function formSbm(el,ev) {
        ev.preventDefault();
    }
    function Gonder(params) {
        var SEPET=document.getElementsByClassName("SEPET_ROW")
var aaaa=[];
var hata=false;
for(let i=1;i<=SEPET.length;i++){
    var Lot=document.getElementById("LOT_"+i).value;
    console.log(Lot)
    var ix=aaaa.findIndex(p=>p==Lot)
    if(ix==-1){
     aaaa.push(Lot)    
    }else{
     document.getElementById("SEPET_ROW_"+i).setAttribute("style","background:#ff00007a")
     hata=true;
    }
    
}
if(hata==true) {
    alert("Aynı Lotlu Ürünler Var ")
    return false;
}
        $("#frm1").submit();
    }

    function rafGetir(lot) {
        var str="  SELECT  DISTINCT SHELF_CODE,STORE,STORE_LOCATION,SHELF_NUMBER FROM ( SELECT SUM(STOCK_IN - STOCK_OUT) AS B,SR.STOCK_ID"
            str+=",SR.STORE,SR.STORE_LOCATION,SR.SHELF_NUMBER,SR.LOT_NO,PP.SHELF_CODE FROM "+dsn2+".STOCKS_ROW AS SR"
            str+=" INNER JOIN "+dsn3+".PRODUCT_PLACE AS PP ON PP.PRODUCT_PLACE_ID = SR.SHELF_NUMBER WHERE SHELF_NUMBER IS NOT NULL"
            str+=" AND SR.LOT_NO='"+lot+"' GROUP BY STOCK_ID,STORE,STORE_LOCATION,SHELF_NUMBER,LOT_NO,PP.SHELF_CODE) AS T WHERE B>0    "
        var res=wrk_query(str,"dsn");
        if(res.recordcount>0){
    return {
        SHELF_CODE:res.SHELF_CODE[0],
        SHELF_NUMBER:res.SHELF_NUMBER[0]
    }}else{
        return false;
    }
    }
</script>