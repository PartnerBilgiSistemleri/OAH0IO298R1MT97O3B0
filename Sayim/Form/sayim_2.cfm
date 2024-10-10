<cfparam name="attributes.is_rafli" default="1">                        <!--------  //BILGI RAFLI KAYITMI YAPILACAK   ------------->
<cfparam name="attributes.is_default_depo" default="0">                 <!--------  //BILGI DEFAULT DEPO VARMI        ------------->
<cfparam name="attributes.default_depo" default="">                  <!--------  //BILGI DEFAULT DEPOLAR           ------------->
<cfparam name="attributes.is_product_code" default="0">                 <!--------  //BILGI ÜRÜN KODU SORULACAKMI     ------------->
<cfparam name="attributes.product_code_area" default="PRODUCT_CODE_2">  <!--------  //BILGI ÜRÜN KODU ARAMA ALANI     ------------->
<cfparam name="attributes.is_lot_no" default="1">                       <!--------  //BILGI LOT NO SORULACAKMI        ------------->
<!--------  
    //BILGI YUKARIDAKİ PARAMETRELERE GÖRE AŞAĞIDAKİ FORM ŞEKİLLENİR ÜRÜN KODU VE LOT  SORGUSU AYNI ANDA 0 OLAMAZ
    //BILGI ÜRÜN BARKODUNDA YER ALAN ALANIN ÜRÜN KARTINDAKİ HANGİ ALANLA EŞLŞECEĞİNİ BİLMEK İÇİN PRODUCT_CODE_AREA VERİSİ KULLANILIR BU ALAN YOKSA ÜRÜN KODUYLA SAYIM YAPAMAZSINIZ
    //BILGI RAFLI SAYIM YADA RAFSIZ SAYIM YAPILABİLİR
    //BILGI BU SAYFA SADECE SAYIM BELGESİNİ OLUŞTURUR BELGEYİ OLUŞTURDUKTAN SONRA SAYIM İŞLEMLERİNDEN BİRLEŞTİRME  VE STOK FİŞLERİNİN OLUŞTURULMASI AŞAMASI MANUEL YAPILACAKTIR
    //BILGI SAYIM TARİHİ BU GÜNÜN TARİHİ OLARAK DEFAULT OLARAK GELECEKTİR
    //BILGI EĞER DEFAULT DEPO TANIMLANMADIYSA SAYIM DEPOSU SEÇİLEN DEPO OLACAKTIR
    ------------->
<cfoutput>
<script>
var SayimSettings={
    is_rafli:#attributes.is_rafli#,
    is_default_depo:#attributes.is_default_depo#,
    default_depo:'#attributes.default_depo#',
    product_code_area:'#attributes.product_code_area#',
    is_lot_no:#attributes.is_lot_no#,
    is_product_code:#attributes.is_product_code#
}    
</script>
</cfoutput>
<cfif isDefined("attributes.is_submit")>
    <cfdump var="#attributes#">
    <cfset attributes.seperator_type = 59><!--- Noktali Virgul Chr --->
<cfset upload_folder = "#upload_folder#store#dir_seperator#">
<cfif len(attributes.txt_department_in)>
<cfelse>
    DEPO SEÇMEDİNİZ ! <CFABORT>
</cfif>

<cfscript>
	CRLF=chr(13)&chr(10);
	barcode_list = ArrayNew(1);
	for(row_i=1;row_i lte attributes.row_count;row_i=row_i+1)
		if(attributes.is_rafli eq 1){
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
<cfif attributes.is_rafli eq 1>
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

<script>
    window.location.href="/index.cfm?fuseaction=stock.emptypopup_add_list_stock_count_pbs&is_rafsiz=0";
</script>

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
            <cfif attributes.is_default_depo eq 1> <!---//BILGI EĞER SAYIM DEPOSU DEFAULTSA---->
                <td>
                    <div class="form-group">
                        <input type="hidden" id="DEPOLAMA" name="DEPOLAMA" value="<cfoutput>#attributes.default_depo#</cfoutput>"> 
                    </div>
                </td>
            <cfelse>
                <td>	
                    <div class="form-group">
                        <label><cf_get_lang dictionary_id='38485.Depo-Lokasyon'></label>
                        <cfquery name="GETSL" datasource="#DSN#">
                            SELECT D.DEPARTMENT_ID,SL.LOCATION_ID,D.DEPARTMENT_HEAD,SL.COMMENT FROM STOCKS_LOCATION AS SL INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID
                            WHERE BRANCH_ID IN (
SELECT D.BRANCH_ID AS B2 FROM #dsn#.EMPLOYEE_POSITIONS INNER JOIN DEPARTMENT AS D ON D.DEPARTMENT_ID=EMPLOYEE_POSITIONS.DEPARTMENT_ID WHERE EMPLOYEE_ID =#session.ep.userid#)
                             ORDER BY D.DEPARTMENT_ID
                        </cfquery>
                        <select name="DEPOLAMA" id="DEPOLAMA" onchange="setDept(this)">
                            <option value="">Seçiniz</option>
                            <cfoutput query="GETSL" group="DEPARTMENT_ID">
                                <optgroup label="#DEPARTMENT_HEAD#">
                                 <cfoutput><option value="#DEPARTMENT_ID#-#LOCATION_ID#">#COMMENT#</option></cfoutput>                                                                        
                                  </optgroup>
                            </cfoutput>
                        </select>                             
                </td>
            </cfif>
            <cfif attributes.is_rafli eq 1> <!---//BILGI EĞER RAFSIZ KAYIT YAPILACAKSA---->
            <td>
                <div class="form-group">
                    <label><cf_get_lang dictionary_id='37540.Raf Kodu'></label>
                    <input type="text" name="SHELF_CODE" id="SHELF_CODE"   onkeyup="GetShelf(this,event)">
                </div>
            </td>
            </cfif>
            <cfif attributes.is_product_code eq 1> <!---//BILGI EĞER ÜRÜN KODU KAYIT YAPILACAKSA---->
                <td>
                    <div class="form-group">
                        <label><cf_get_lang dictionary_id='58800.Ürün Kodu'></label>
                        <input type="text" name="PRODUCT_CODE" id="PRODUCT_CODE"    onkeyup="getProduct(this,event,'<cfoutput>#attributes.product_code_area#</cfoutput>')">
                    </div>
                </td>
            </cfif>
            <cfif attributes.is_lot_no eq 1> <!---//BILGI LOTLU KAYIT YAPILACAKSA---->
                <td>
                    <div class="form-group">
                        <label><cf_get_lang dictionary_id='57637.Seri No'>(Lot No)</label>
                        <input type="text" name="LOT_NO" id="LOT_NO"   onkeyup="getLotNo(this,event,'<cfoutput>#attributes.product_code_area#</cfoutput>')">
                    </div>
                </td>
            </cfif>
            <td>
                <input type="button" class="btn" onclick="$('#frm1').submit()" value="<cf_get_lang dictionary_id='57461.Kaydet'>">
            </td>
        </tr>
    </table>


<cfform id="frm1" method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
<cf_big_list >
    <tr>
        <th>
            <cf_get_lang dictionary_id='57637.Seri No'>(Lot No)
        </th>
        <th>
            <cf_get_lang dictionary_id='44019.Ürün'>
        </th>
        <cfif attributes.is_rafli eq 1>
        <th>
            <cf_get_lang dictionary_id='37540.Raf Kodu'>
        </th>
    </cfif>	
        <th>
            <cf_get_lang dictionary_id='57635.Miktar'>
        </th>
    </tr>
<tbody id="SayimTable">

</tbody>
</cf_big_list>
<input type="hidden" name="is_submit" value="1">
<input type="hidden" name="row_count" id="RC" value="">
<input type="hidden" name="TXT_DEPARTMENT_IN" id="TXT_DEPARTMENT_IN" value="<cfoutput>#attributes.default_depo#</cfoutput>">
<input type="hidden" name="is_default_depo" id="is_default_depo" value="<cfoutput>#attributes.is_default_depo#</cfoutput>">
<input type="hidden" name="is_rafli" id="is_rafli" value="<cfoutput>#attributes.is_rafli#</cfoutput>">
</cfform>
</cf_box>
	
<script>
    var dsn="<cfoutput>#dsn#</cfoutput>";
    var dsn1="<cfoutput>#dsn1#</cfoutput>";
    var dsn2="<cfoutput>#dsn2#</cfoutput>";
    var dsn3="<cfoutput>#dsn3#</cfoutput>";

    var Kelime_1="<cf_get_lang dictionary_id='64185.Aradığınız kriterlerde ürün bulunamadı'>"
        var Kelime_2="<cf_get_lang dictionary_id='66399.Raf Bulunamadı'>"
            var Kelime_3="<cf_get_lang dictionary_id='66412.Seri (Lot) Nolu Ürün Bulunamadı'>"	
</script>
<script src="/AddOns/Partner/sayim/sayim.js"></script>