<cf_box title="Sayım Fişi - Depo Karşılaştırma">
<style>
    .form-group input[type=text],.form-group input[type=date], .form-group input[type=search], input[type=search], .form-group input[type=number], .form-group input[type=password], .form-group input[type=file], .form-group select{
	width: 100%!important;
	min-height: 23px;
	font-family: 'Roboto';
	padding: 1px 25px 1px 5px;
	font-size: 12px;
	outline:none;
	-webkit-box-sizing:border-box;
	        box-sizing:border-box;
	line-height: 1.42857143;
	color: #555;
	background-color: #fff;
	background-image: none;
	-webkit-box-shadow:0;
	        box-shadow:0;
	border-radius: 0;
	border: 1px solid #ccc;
	-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
	-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
}
</style>
<cfparam name="attributes.islemci" default="0">
<cfif attributes.islemci eq 0>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&page=11&islemci=1">
<table>
    <tr>
        <td>
            <div class="form-group require" id="item-deliver_dept_name">
				<label>Depo</label>
				<div >
					

<link href="../../JS/temp/scroll/jquery.mCustomScrollbar.css" rel="stylesheet">
<script src="../../JS/temp/scroll/jquery.mCustomScrollbar.concat.min.js"></script>
<input name="branch_id" type="hidden" id="branch_id" value=""><input name="deliver_dept_id" type="hidden" id="deliver_dept_id" value=""><input name="deliver_loc_id" type="hidden" id="deliver_loc_id" value="">
<div class="ui-cfmodal" id="wrkDepartmentLocationDiv_deliver_dept_name"></div>
<div class="input-group">
	<input type="text" placeholder="Depo" name="deliver_dept_name" id="deliver_dept_name" autocomplete="off" onblur="compenentInputValueEmptyinglocation_1(this);" value="" onkeypress="if(event.keyCode==13) {compenentAutoCompletelocation_1(this,'wrkDepartmentLocationDiv_deliver_dept_name','&RETURNQUERYVALUE=LOCATION_ID,LOCATION_NAME,DEPARTMENT_ID,BRANCH_ID&FIELDID=deliver_loc_id&BOXHEIGHT=200&WIDTH=140&LISTPAGE=0&JS_PAGE=0&UPDPAGEURL=project.prodetail█id=&IS_DEPARTMENT=0&IS_STORE_MODULE=0&LINE_INFO=1&RETURNINPUTVALUE=deliver_loc_id,deliver_dept_name,deliver_dept_id,branch_id&STATUS=1&XML_ALL_DEPO=0&USER_LEVEL_CONTROL=1&DEPARTMENT_FLDID=deliver_dept_id&COMPENENT_NAME=get_department_location&FIELDNAME=deliver_dept_name&IS_SUBMIT=0&BRANCH_FLDID=branch_id&BOXWIDTH=250&CALL_FUNCTION=1&IS_STORE_KONTROL=1&RETURNQUERYVALUE2=DEPARTMENT_ID,DEPARTMENT_HEAD&ADDPAGEURL=project.addpro&USER_LOCATION=1&TITLE=Depo - Lokasyon&columnList=LOCATION_NAME@Lokasyon,'); return false;}"> 
	<span class="input-group-addon btnPointer icon-ellipsis" id="plus_this_department" name="plus_this_department" title="Depo - Lokasyon" onclick="if(1){compenentAutoCompletelocation_1('','wrkDepartmentLocationDiv_deliver_dept_name','&RETURNQUERYVALUE=LOCATION_ID,LOCATION_NAME,DEPARTMENT_ID,BRANCH_ID&FIELDID=deliver_loc_id&BOXHEIGHT=200&WIDTH=140&LISTPAGE=0&JS_PAGE=0&UPDPAGEURL=project.prodetail█id=&IS_DEPARTMENT=0&IS_STORE_MODULE=0&LINE_INFO=1&RETURNINPUTVALUE=deliver_loc_id,deliver_dept_name,deliver_dept_id,branch_id&STATUS=1&XML_ALL_DEPO=0&USER_LEVEL_CONTROL=1&DEPARTMENT_FLDID=deliver_dept_id&COMPENENT_NAME=get_department_location&FIELDNAME=deliver_dept_name&IS_SUBMIT=0&BRANCH_FLDID=branch_id&BOXWIDTH=250&CALL_FUNCTION=1&IS_STORE_KONTROL=1&RETURNQUERYVALUE2=DEPARTMENT_ID,DEPARTMENT_HEAD&ADDPAGEURL=project.addpro&USER_LOCATION=1&TITLE=Depo - Lokasyon&columnList=LOCATION_NAME@Lokasyon,')};"></span>
</div>
<script type="text/javascript">
	function compenentAutoCompletelocation_1(object_,div_id,comp_url){
		other_parameters = 'is_delivery§/location_type§/sistem_company_id§/is_ingroup§/user_level_control§1/is_store_module§0/xml_all_depo§0/status§1';//alt+789=§ ve alt+987=█ 
	
		 var keyword_ =(!object_)?'':object_.value;
		 if(keyword_.length < 3 && object_ != ""){
			alert("En az 3 karakter giriniz.");
			return false;}
		 else{
			document.getElementById(div_id).style.display='';
			if(keyword_ == '')
			keyword_ = "0";
			openBoxDraggable('index.cfm?fuseaction=objects.popup_wrk_list_comp&keyword='+keyword_+comp_url+'&comp_div_id=wrkDepartmentLocationDiv_deliver_dept_name&other_parameters='+other_parameters);
			return false;	
		 }
		 return false;	
	}
	function compenentInputValueEmptyinglocation_1(object_)
	{
		var keyword_ = object_.value;
		if(keyword_.length == 0)
		{
			
				document.getElementById('deliver_loc_id').value ='';
			
				document.getElementById('deliver_dept_name').value ='';
			
				document.getElementById('deliver_dept_id').value ='';
			
				document.getElementById('branch_id').value ='';
				
		}
	}
</script>
				</div>                
			</div>
        </td>
        <td>
            <div class="form-group">
                <label>Tarih</label>
                <input type="date" name="start_date">
        </div>
        </td>
        <td>
            <input type="submit">
        </td>
    </tr>
</table>

</cfform>

<cfelseif attributes.islemci eq 1>
    <cfquery name="getps" datasource="#dsn2#">
SELECT TBL.*,STOCKS.PRODUCT_CODE FROM (
SELECT SUM(STOCK_IN-STOCK_OUT) AS BK,LOT_NO,STORE,STORE_LOCATION,STOCK_ID,SHELF_NUMBER,(
    SELECT TOP 1 AMOUNT FROM FILE_IMPORTS_ROW  WHERE FILE_IMPORT_ID IN(
    SELECT I_ID FROM FILE_IMPORTS WHERE DEPARTMENT_ID=#attributes.deliver_dept_id# AND DEPARTMENT_LOCATION=#attributes.deliver_loc_id# AND CONVERT(DATE,STARTDATE)='#attributes.start_date#' AND SHELF_NUMBER=STOCKS_ROW.SHELF_NUMBER
) AND LOT_NO=STOCKS_ROW.LOT_NO
) AS FSK FROM  STOCKS_ROW 
WHERE STORE=#attributes.deliver_dept_id# AND STORE_LOCATION=#attributes.deliver_loc_id#
GROUP BY LOT_NO,STORE,STORE_LOCATION,STOCK_ID,SHELF_NUMBER
HAVING SUM(STOCK_IN-STOCK_OUT)>0
) AS TBL 
LEFT JOIN #DSN3#.STOCKS ON STOCKS.STOCK_ID=TBL.STOCK_ID 

WHERE FSK IS NULL AND TBL.LOT_NO IS NOT NULL  AND TBL.SHELF_NUMBER IS NOT NULL  
    </cfquery>
    

    
    <cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&page=11&islemci=2">
        <cfoutput>
           <b> #attributes.deliver_dept_name# Lokasyonu Sayım Fişi Karşılaştırma Sonucu </b> <br>
                Sayım Fişinde Olup Depoda Olmayan Kayıt Sayısı = #getps.recordCount#; 
                <input type="hidden" name="deliver_dept_id" value="<cfoutput>#attributes.deliver_dept_id#</cfoutput>">
                <input type="hidden" name="deliver_dept_name" value="<cfoutput>#attributes.deliver_dept_name#</cfoutput>">
                <input type="hidden" name="deliver_loc_id" value="<cfoutput>#attributes.deliver_loc_id#</cfoutput>">
                <input type="hidden" name="start_date" value="<cfoutput>#attributes.start_date#</cfoutput>">            
            <input type="submit" value="Devam Et">
        </cfoutput>
    </cfform>
<cfelseif attributes.islemci eq 2>
<cfquery name="GETPS2" datasource="#DSN2#">
SELECT TBL.*,STOCKS.STOCK_CODE,PRODUCT_PLACE.SHELF_CODE FROM (
SELECT SUM(STOCK_IN-STOCK_OUT) AS BK,LOT_NO,STORE,STORE_LOCATION,STOCK_ID,SHELF_NUMBER,(
    SELECT TOP 1 AMOUNT FROM FILE_IMPORTS_ROW  WHERE FILE_IMPORT_ID IN(
    SELECT I_ID FROM FILE_IMPORTS WHERE DEPARTMENT_ID=#attributes.deliver_dept_id# AND DEPARTMENT_LOCATION=#attributes.deliver_loc_id# AND CONVERT(DATE,STARTDATE)='#attributes.start_date#' AND SHELF_NUMBER=STOCKS_ROW.SHELF_NUMBER
) AND LOT_NO=STOCKS_ROW.LOT_NO
) AS FSK FROM  STOCKS_ROW 
WHERE STORE=#attributes.deliver_dept_id# AND STORE_LOCATION=#attributes.deliver_loc_id#
GROUP BY LOT_NO,STORE,STORE_LOCATION,STOCK_ID,SHELF_NUMBER
HAVING SUM(STOCK_IN-STOCK_OUT)>0
) AS TBL 
LEFT JOIN #DSN3#.STOCKS ON STOCKS.STOCK_ID=TBL.STOCK_ID
LEFT JOIN #DSN3#.PRODUCT_PLACE ON PRODUCT_PLACE_ID=SHELF_NUMBER
WHERE FSK IS NULL AND TBL.LOT_NO IS NOT NULL  AND TBL.SHELF_NUMBER IS NOT NULL  
</cfquery>
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


    
    <cfset attributes.seperator_type = 59><!--- Noktali Virgul Chr --->
<cfset upload_folder = "#upload_folder#store#dir_seperator#">

<cfscript>
	CRLF=chr(13)&chr(10);
	barcode_list = ArrayNew(1);
	for(row_i=1;row_i lte GETPS2.recordCount;row_i=row_i+1)
		if(attributes.is_rafli eq 1){
            ArrayAppend(barcode_list,"#evaluate('GETPS2.STOCK_CODE[#row_i#]')#;0;#evaluate('GETPS2.SHELF_CODE[#row_i#]')#;#evaluate('GETPS2.LOT_NO[#row_i#]')#");}else{
                ArrayAppend(barcode_list,"#evaluate('GETPS2.STOCK_CODE[#row_i#]')#;0;#evaluate('GETPS2.LOT_NO[#row_i#]')#");
            }
</cfscript>
<cfset file_name = "#createUUID()#.txt">
<cffile action="write" output="#ArrayToList(barcode_list,CRLF)#" file="#upload_folder##file_name#" addnewline="yes" charset="iso-8859-9">
<cfdirectory directory="#upload_folder#" name="folder_info" sort="datelastmodified" filter="#file_name#">
<cfset file_name = folder_info.name>
<cfset file_size = folder_info.size>
<cfset form.store = attributes.deliver_dept_name>
<cfset attributes.department_id = attributes.deliver_dept_id>
<cfset attributes.location_id =  attributes.deliver_dept_id>
<cfset attributes.process_date = Dateformat(attributes.start_date,'dd/mm/yyyy')>
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

 <div class="alert alert-success">
    <cfoutput>Belge Oluşturuldu <a download="" href="/documents/store/#file_name#">İndir</a></cfoutput>
 </div>   

<!-----
    <cfinclude template="/AddOns/Partner/Sayim/Form/import_stock_count_display.cfm">
----->



    
</cfif>


</cf_box>