<cf_box title="Talep Oluştur">
<cfquery name="getDepartments" datasource="#dsn#">
    SELECT
SL.DEPARTMENT_LOCATION,SL.COMMENT,D.DEPARTMENT_HEAD,D.DEPARTMENT_ID FROM #dsn#.STOCKS_LOCATION AS SL INNER JOIN #dsn#.DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID
 WHERE BRANCH_ID IN (
       SELECT D.BRANCH_ID AS B2
       FROM #dsn#.EMPLOYEE_POSITIONS
       INNER JOIN #dsn#.DEPARTMENT AS D ON D.DEPARTMENT_ID = EMPLOYEE_POSITIONS.DEPARTMENT_ID
       WHERE EMPLOYEE_ID = #session.ep.userid#
       )
       AND [STATUS]=1
</cfquery>
<SELECT name="DEPO" id="DEPO" onchange="setCikDepo(this)">
    <option value="">Seçiniz</option>
    <cfoutput query="getDepartments" group="DEPARTMENT_ID">
        <optgroup  label="#DEPARTMENT_HEAD#">
            <cfoutput>
            <option value="#DEPARTMENT_LOCATION#">
                #COMMENT#
            </option>
        </cfoutput>
        </optgroup>
    </cfoutput>
</SELECT>
<cfquery name="getOrderRow" datasource="#dsn3#">
    SELECT * FROM ORDER_ROW WHERE ORDER_ID=#attributes.ACTION_ID#
</cfquery>
<cfquery name="getorderim"  datasource="#dsn3#">
    SELECT * FROM ORDERS WHERE ORDER_ID=#attributes.ACTION_ID#
</cfquery>
<cfform  action="http://test.ashleyturkiye.com/index.cfm?fuseaction=purchase.list_internaldemand&event=add&type=convert" id="form_1">
   
    <button class="btn btn-succes" onclick="TalepEt()" type="button">İç Talep Oluştur</button>
    <input type="hidden" name="department_in_id" id="department_in_id">
    <input type="hidden" name="location_in_id" id="location_in_id">
    <input type="hidden" name="department_out" id="department_out" value="1">
    <input type="hidden" name="location_out" id="location_out" value="1">
    <input type="hidden" name="ref_no" id="ref_no" value="<CFOUTPUT>#getorderim.ORDER_NUMBER#</CFOUTPUT>">
<cf_big_list>
    <thead>
        <tr>
            <th>
                Ürün
            </th>
            <th>
                Miktar
            </th>
        </tr>
    </thead>
    <tbody>
    <cfoutput query="getOrderRow">
        <tr class="OrderRows" id="ORD_#ORDER_ROW_ID#">
            <td>
                #PRODUCT_NAME#
                <input type="hidden" name="CONVERT_STOCKS_ID" id="CONVERT_STOCKS_ID" value="#STOCK_ID#"><!----CONVERT_STOCKS_ID---->
                <input type="hidden" name="convert_products_id" id="convert_products_id" value="#PRODUCT_ID#"><!----convert_products_id---->
            </td>
            <td>
              <div class="form-group">
                <input type="text" name="CONVERT_AMOUNT_STOCKS_ID" id="CONVERT_AMOUNT_STOCKS_ID" value="#QUANTITY#"><!----CONVERT_AMOUNT_STOCKS_ID---->
            </div>
            </td>
            <td>
                <button type="button" onclick="$('##ORD_#ORDER_ROW_ID#').remove()">Sil</button>
            </td>
        </tr>
</cfoutput>
</tbody>
<input type="hidden" name="CONVERT_STOCKS_ID" value=" ">
<input type="hidden" name="convert_products_id" value=" ">
<input type="hidden" name="CONVERT_AMOUNT_STOCKS_ID" value=" ">
</cf_big_list>
</cfform>
<script>
    function setCikDepo(el) {
        var dep=list_getat(el.value,1,"-")
        var loc=list_getat(el.value,2,"-")
    $("#department_in_id").val(dep)
    $("#location_in_id").val(loc)
    }
    function TalepEt() {
        var CONVERT_STOCK_IDS="";
var CONVERT_AMOUNT_STOCK_IDS="";
var CONVERT_PRODUCT_IDS="";
var Rows=document.getElementsByClassName("OrderRows")
for (let index = 0; index < Rows.length; index++) {
    var Arow=Rows[index]
    console.log(Arow)
    var SID=$(Arow).find("#CONVERT_STOCKS_ID").val()
    var PID=$(Arow).find("#convert_products_id").val()
    var Amount=$(Arow).find("#CONVERT_AMOUNT_STOCKS_ID").val()
    console.log(SID)
    CONVERT_STOCK_IDS+=SID+","
    CONVERT_AMOUNT_STOCK_IDS+=Amount+","
    CONVERT_PRODUCT_IDS+=PID+","


}
console.log(CONVERT_STOCK_IDS)
console.log(CONVERT_AMOUNT_STOCK_IDS)
console.log(CONVERT_PRODUCT_IDS)

/*
CONVERT_AMOUNT_STOCK_IDS=CONVERT_AMOUNT_STOCK_IDS.substring(0, CONVERT_AMOUNT_STOCK_IDS.length-1)
CONVERT_STOCK_IDS=CONVERT_STOCK_IDS.substring(0, CONVERT_STOCK_IDS.length-1)
CONVERT_PRODUCT_IDS=CONVERT_PRODUCT_IDS.substring(0, CONVERT_PRODUCT_IDS.length-1)*/

console.log(CONVERT_STOCK_IDS)
console.log(CONVERT_AMOUNT_STOCK_IDS)
console.log(CONVERT_PRODUCT_IDS)
var department_in_id=document.getElementById("department_in_id").value;
var location_in_id=document.getElementById("location_in_id").value;
var department_out=document.getElementById("department_out").value;
var location_out=document.getElementById("location_out").value;
var ref_no=document.getElementById("ref_no").value;
var Frm=document.createElement("form")
var input=document.createElement("input")
input.setAttribute("name","CONVERT_STOCKS_ID");
input.setAttribute("value",CONVERT_STOCK_IDS)
Frm.appendChild(input)
var input=document.createElement("input")
input.setAttribute("name","CONVERT_AMOUNT_STOCKS_ID");
input.setAttribute("value",CONVERT_AMOUNT_STOCK_IDS)
Frm.appendChild(input)

var input=document.createElement("input")
input.setAttribute("name","convert_products_id");
input.setAttribute("value",CONVERT_PRODUCT_IDS)
Frm.appendChild(input)
//aa
var input=document.createElement("input")
input.setAttribute("name","department_in_id");
input.setAttribute("value",department_in_id)
Frm.appendChild(input)

var input=document.createElement("input")
input.setAttribute("name","location_in_id");
input.setAttribute("value",location_in_id)
Frm.appendChild(input)

var input=document.createElement("input")
input.setAttribute("name","department_out");
input.setAttribute("value",department_out)
Frm.appendChild(input)

var input=document.createElement("input")
input.setAttribute("name","location_out");
input.setAttribute("value",location_out)
Frm.appendChild(input)

var input=document.createElement("input")
input.setAttribute("name","ref_no");
input.setAttribute("value",ref_no)
Frm.appendChild(input)

//aa

Frm.setAttribute("method","post")
Frm.setAttribute("action","http://portal.ashleyturkiye.com/index.cfm?fuseaction=purchase.list_internaldemand&event=add&type=convert")
console.log(Frm)
document.body.appendChild(Frm)
Frm.submit()
    }
</script>
<!----
<cfquery name="getOrder" datasource="#dsn3#"></cfquery>
<cfquery name="getOrderRow" datasource="#dsn3#"></cfquery>
----->
department_in_txt
department_in_id
location_in_id


txt_departman_
department_id
location_id
</cf_box>