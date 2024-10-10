
<cfinclude template="sayim_2.cfm">
<cfabort>
<cfparam name="attributes.is_rafsiz" default="0">
<cfparam name="attributes.is_default_depo" default="1">
<cfparam name="attributes.default_depo" default="1-3">

<cfif isDefined("attributes.is_submit")>
    <cfdump var="#attributes#">
    <cfset attributes.seperator_type = 59><!--- Noktali Virgul Chr --->
<cfset upload_folder = "#upload_folder#store#dir_seperator#">

<cfscript>
	CRLF=chr(13)&chr(10);
	barcode_list = ArrayNew(1);
	for(row_i=1;row_i lte attributes.row_count;row_i=row_i+1)
		if(attributes.is_rafsiz eq 0){
            ArrayAppend(barcode_list,"#evaluate('attributes.PRODUCT_CODE#row_i#')#;1;#evaluate('attributes.SHELF_CODE#row_i#')#;#evaluate('attributes.LOT_NO#row_i#')#");}else{
                ArrayAppend(barcode_list,"#evaluate('attributes.PRODUCT_CODE#row_i#')#;1;#evaluate('attributes.LOT_NO#row_i#')#");
            }
</cfscript>
<cfset file_name = "#createUUID()#.txt">
<cffile action="write" output="#ArrayToList(barcode_list,CRLF)#" file="#upload_folder##file_name#" addnewline="yes" charset="iso-8859-9">
<cfdirectory directory="#upload_folder#" name="folder_info" sort="datelastmodified" filter="#file_name#">
<cfset file_name = folder_info.name>
<cfset file_size = folder_info.size>
<cfset form.store = attributes.txt_department_in>
<cfset attributes.department_id = ListGetAt(attributes.txt_department_in,1,'-')>
<cfset attributes.location_id = ListGetAt(attributes.txt_department_in,2,'-')>
<cfset attributes.process_date = Dateformat(now(),'dd/mm/yyyy')>
<cfset attributes.stock_identity_type = 2><!--- Tip Barkod --->
<cfif attributes.is_rafsiz eq 0>
    <CFSET attributes.add_file_format_1="SHELF_CODE">
    <CFSET attributes.add_file_format_2="LOT_NO">
<cfelse>
    <CFSET attributes.add_file_format_1="LOT_NO">
    <CFSET attributes.add_file_format_2="">
</cfif>
<CFSET attributes.add_file_format_3="">
<CFSET attributes.add_file_format_4="">
<cf_date tarih='attributes.process_date'>
    <cfset get_stock_date = date_add("h",23,attributes.process_date)>
    <cfset get_stock_date = date_add("n",59,get_stock_date)>
    <cfset count_product_problem=0>    
<cfinclude template="import_stock_count_display.cfm">
<!----<cfinclude template="import_stock_count_display.cfm">
<script type="text/javascript">
	<cfif not isdefined('error_flag')>
		alert('Sayım dosyanız başarıyla oluşturulmuştur !');
	</cfif>
	window.location.href = '<cfoutput>#request.self#?fuseaction=epda.prtotm_raf_sayim</cfoutput>';
</script>----->
    <cfabort>
</cfif>
<cf_box title="Sayim">
    <table>
        <tr>
           <cfif attributes.is_default_depo eq 0>
            <td>
                <div class="form-group">
                    <label>Depo - Lokasyon</label>
                    <cfquery name="GETSL" datasource="#DSN#">
                        SELECT D.DEPARTMENT_ID,SL.LOCATION_ID,D.DEPARTMENT_HEAD,SL.COMMENT FROM STOCKS_LOCATION AS SL INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID ORDER BY D.DEPARTMENT_ID
                    </cfquery>
                    <select name="DEPOLAMA" id="DEPOLAMA" onchange="setDept(this)">
                        <cfoutput query="GETSL" group="DEPARTMENT_ID">
                            <optgroup label="#DEPARTMENT_HEAD#">
                             <cfoutput><option value="#DEPARTMENT_ID#-#LOCATION_ID#">#COMMENT#</option></cfoutput>
                                
                                
                              </optgroup>
                        </cfoutput>
                    </select>
            </div>
            </td>
            
        <cfelse>
            <td>
                <input type="hidden" id="DEPOLAMA" name="DEPOLAMA" value="<cfoutput>#attributes.default_depo#</cfoutput>">
            </td>
        </cfif>
            <td>
                <button onclick="$('#frm1').submit()">Kaydet</button>
            </td>
        </tr>
<tr>
    <td>
        <div class="form-group">
            <label>Lot No</label>
            <input type="text" name="LotNo" id="LotNo" value="" onkeyup="GetLot(this,event)">
        </div>  
    </td>
    <cfif attributes.is_rafsiz eq 0>
    <td>
        <div class="form-group">
            <label>Raf No/label>
            <input type="text" name="ShelfNumber" id="ShelfNumber" value="" onkeyup="GetShelf(this,event)" readonly>
        </div>  
    </td>
<cfelse>
    <td></td>
</cfif>
    <td>
        <div class="form-group">
            <label>Miktar</label>
            <input type="text" name="AMOUNT" id="AMOUNT" value="1" readonly>
            
        </div>  
    </td>
</tr>
        

</table>
<cfform id="frm1" method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
<cf_big_list >
    <tr>
        <th>
            Lot No
        </th>
        <th>
            Ürün
        </th>
        <cfif attributes.is_rafsiz eq 0>
        <th>
            Raf
        </th>
    </cfif>
        <th>
            Miktar
        </th>
    </tr>
<tbody id="SayimTable">

</tbody>
</cf_big_list>
<input type="hidden" name="is_submit" value="1">
<input type="hidden" name="row_count" id="RC" value="">
<input type="hidden" name="TXT_DEPARTMENT_IN" id="TXT_DEPARTMENT_IN" value="<cfoutput>#attributes.default_depo#</cfoutput>">
<input type="hidden" name="is_default_depo" id="is_default_depo" value="<cfoutput>#attributes.is_default_depo#</cfoutput>">
<input type="hidden" name="is_rafsiz" id="is_rafsiz" value="<cfoutput>#attributes.is_rafsiz#</cfoutput>">
</cfform>
</cf_box>
<script>
    var dsn="<cfoutput>#dsn#</cfoutput>";
    var dsn1="<cfoutput>#dsn1#</cfoutput>";
    var dsn2="<cfoutput>#dsn2#</cfoutput>";
    var dsn3="<cfoutput>#dsn3#</cfoutput>";
</script>
<script>
var PRODUCT_ID="";
var STOCK_ID="";
var PRODUCT_CODE="";
var PRODUCT_CODE_2="";
var LOT_NO="";
var RC=1;
    function GetLot(el,ev) {
        if(ev.keyCode==13){
            var LotNumarasi=el.value;
            var Urun=wrk_query("SELECT TOP 1 S.PRODUCT_NAME,S.PRODUCT_ID,S.STOCK_ID,SR.LOT_NO,S.PRODUCT_CODE_2,S.PRODUCT_CODE FROM STOCKS_ROW AS SR LEFT JOIN "+dsn3+".STOCKS AS S ON S.STOCK_ID=SR.STOCK_ID WHERE LOT_NO='"+LotNumarasi+"'","DSN2")
            if(Urun.recordcount>0){
                PRODUCT_ID=Urun.PRODUCT_ID[0];
                STOCK_ID=Urun.STOCK_ID[0];
                PRODUCT_CODE=Urun.PRODUCT_CODE[0];
                LOT_NO=Urun.LOT_NO[0];
                PRODUCT_CODE_2=Urun.PRODUCT_CODE_2[0];
               <cfif attributes.is_rafsiz eq 0> document.getElementById("ShelfNumber").removeAttribute("readonly");
                $("#ShelfNumber").focus(); <cfelse>
                satirEkle()
                </cfif>          
            }
        }
    }
    function GetShelf(el,ev) {
        if(ev.keyCode==13){
            var str=document.getElementById("DEPOLAMA").value;
            var STORE_ID=list_getat(str,1,"-")
            var LOCATION_ID=list_getat(str,2,"-")
            var SHELF_CODE=list_getat(el.value,3,"-")
            var w=wrk_query("SELECT * FROM PRODUCT_PLACE WHERE STORE_ID="+STORE_ID+" AND LOCATION_ID="+LOCATION_ID+" AND SHELF_CODE='"+SHELF_CODE+"'","DSN3")
            console.log(w)
            if(w.recordcount>0){
                var tr=document.createElement("tr");
                var td=document.createElement("td");
                td.innerText=LOT_NO;
                var input=document.createElement("input");
                input.setAttribute("type","hidden");
                input.setAttribute("name","PRODUCT_ID_"+RC)
                input.setAttribute("value",PRODUCT_ID);
                td.appendChild(input);
                var input=document.createElement("input");
                input.setAttribute("type","hidden");
                input.setAttribute("name","STOCK_ID_"+RC)
                input.setAttribute("value",STOCK_ID);
                td.appendChild(input);
                var input=document.createElement("input");
                input.setAttribute("type","hidden");
                input.setAttribute("name","PRODUCT_CODE"+RC)
                input.setAttribute("value",PRODUCT_CODE);
                td.appendChild(input);
                var input=document.createElement("input");
                input.setAttribute("type","hidden");
                input.setAttribute("name","PRODUCT_CODE_2"+RC)
                input.setAttribute("value",PRODUCT_CODE_2);
                td.appendChild(input);
                var input=document.createElement("input");
                input.setAttribute("type","hidden");
                input.setAttribute("name","LOT_NO"+RC)
                input.setAttribute("value",LOT_NO);
                td.appendChild(input);
               
                var input=document.createElement("input");
                input.setAttribute("type","hidden");
                input.setAttribute("name","SHELF_CODE"+RC)
                input.setAttribute("value",SHELF_CODE);
                td.appendChild(input);


                tr.appendChild(td);

                var td=document.createElement("td");
                td.innerText=PRODUCT_CODE_2;
                tr.appendChild(td);

                var td=document.createElement("td");
                td.innerText=el.value;
                tr.appendChild(td);

                var td=document.createElement("td");
                td.innerText=1;
                tr.appendChild(td);
                document.getElementById("SayimTable").appendChild(tr);
                el.value='';
                el.setAttribute("readonly","true")
                $("#LotNo").val("");
                $("#LotNo").focus();
                PRODUCT_ID="";
                STOCK_ID="";
                PRODUCT_CODE="";
                PRODUCT_CODE_2="";
                LOT_NO="";
                $("#RC").val(RC);
                RC++;

            }
        }
    }
    function satirEkle(params) {
        var str=document.getElementById("DEPOLAMA").value;
            var STORE_ID=list_getat(str,1,"-")
            var LOCATION_ID=list_getat(str,2,"-")
            var tr=document.createElement("tr");
                var td=document.createElement("td");
                td.innerText=LOT_NO;
                var input=document.createElement("input");
                input.setAttribute("type","hidden");
                input.setAttribute("name","PRODUCT_ID_"+RC)
                input.setAttribute("value",PRODUCT_ID);
                td.appendChild(input);
                var input=document.createElement("input");
                input.setAttribute("type","hidden");
                input.setAttribute("name","STOCK_ID_"+RC)
                input.setAttribute("value",STOCK_ID);
                td.appendChild(input);
                var input=document.createElement("input");
                input.setAttribute("type","hidden");
                input.setAttribute("name","PRODUCT_CODE"+RC)
                input.setAttribute("value",PRODUCT_CODE);
                td.appendChild(input);
                var input=document.createElement("input");
                input.setAttribute("type","hidden");
                input.setAttribute("name","PRODUCT_CODE_2"+RC)
                input.setAttribute("value",PRODUCT_CODE_2);
                td.appendChild(input);
                var input=document.createElement("input");
                input.setAttribute("type","hidden");
                input.setAttribute("name","LOT_NO"+RC)
                input.setAttribute("value",LOT_NO);
                td.appendChild(input);                             
                tr.appendChild(td);
                var td=document.createElement("td");
                td.innerText=PRODUCT_CODE_2;
                tr.appendChild(td);

               

                var td=document.createElement("td");
                td.innerText=1;
                tr.appendChild(td);
                document.getElementById("SayimTable").appendChild(tr);             
                $("#LotNo").val("");
                $("#LotNo").focus();
                PRODUCT_ID="";
                STOCK_ID="";
                PRODUCT_CODE="";
                PRODUCT_CODE_2="";
                LOT_NO="";
                $("#RC").val(RC);
                RC++;
            
    }
    function setDept(el) {
        el.setAttribute("readonly","true");
        $("#TXT_DEPARTMENT_IN").val(el.value);
        $("#LotNo").focus();
    }
</script>


