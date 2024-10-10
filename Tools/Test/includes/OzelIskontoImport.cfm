<cf_box title="Satış Koşulları Aktarım">
<style>
    .form-group input[type=text], .form-group input[type=date],.form-group input[type=tel], .form-group input[type=search], input[type=search], .form-group input[type=number], .form-group input[type=password], .form-group input[type=file], .form-group select {
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

<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&page=9" enctype="multipart/form-data">
<cf_big_list>
    <thead>
    <tr>
        <th colspan="2">
            Geçerlilik
        </th>
        <th>
            Ödeme Yöntemi
        </th>
        <th>
            Excell Belgesi
        </th>
        <th></th>
            
        
    </tr>
</thead>
<tbody>
    <tr>
        <td>
            <div class="form-group">
                <label>Başlangıç Tarihi</label>
                <br>
                <input type="date" style="width:100%" name="START_DATE" required>
            </div>
        </td>
        <td>
            <div class="form-group">
                <label>Bitiş Tarihi</label><br>
                <input type="date" style="width:100%" name="FINISH_DATE" required>
            </div>
        </td>
        <td>
            <cfquery name="getpm" datasource="#dsn#">
                SELECT PAYMETHOD_ID,PAYMETHOD FROM catalyst_prod.SETUP_PAYMETHOD
            </cfquery>
            <div class="form-group">
                <select name="PAYMETHOD_ID" id="PAYMETHOD_ID" required>
                    <option value="">Seç</option>
                    <cfoutput query="getpm">
                        <option value="#PAYMETHOD_ID#">#PAYMETHOD#</option>
                    </cfoutput>
                </select>
            </div>
        </td>
        <td>
            <input type="file" name="file_11" id="file_11">
            <input type="hidden"  name="FileName" id="FileName">
        </td>
        <td>
            <input type="submit">
            <input type="hidden" name="is_submit">
        </td>
    </tr>
</tbody>
</cf_big_list>
<div class="alert alert-warning">
    EXCELL 3 KOLONDAN OLUŞMALIDIR !
    <br> Diğer Verileri Formdan Alacaktır !
    <BR>1-SKU
    <BR>2-İNDİRİM 1
    <BR>3-İNDİRİM 2
</div>

</cfform>

<cfif isDefined("attributes.is_submit")>
    Submite Girdi

	<cfif isDefined("attributes.FileName") and len(attributes.FileName)>
    
Dosya Adı Var
		<cffile action = "upload" fileField = "file_11" destination = "#expandPath("./ExDosyalar")#"  nameConflict = "Overwrite" result="resul"> 	
       
        <cfspreadsheet  action="read" src = "#expandPath("./ExDosyalar/#attributes.fileName#")#" query = "res">	
	   
       <cfquery name = "get_invoice_no" dbtype = "query">
		    SELECT 
			    col_1 PRODUCT_CODE,
			    col_2 DISCOUNT_1, 
			    col_3 DISCOUNT_2
                      
		    FROM
			    res     
	    </cfquery>
        <cfdump var="#get_invoice_no#">
        <CFLOOP query="get_invoice_no">    
            <cfquery name="GETP" datasource="#DSN3#">
                SELECT * FROM STOCKS WHERE PRODUCT_CODE_2='#get_invoice_no.PRODUCT_CODE#'
            </cfquery>  
            <CFIF GETP.recordCount EQ 1>
        <cfquery name="INS" datasource="#DSN3#">
            DECLARE @PRODUCT_ID INT
            DECLARE @DISCOUNT1 FLOAT
            DECLARE @DISCOUNT2 FLOAT
            DECLARE @DISCOUNT3 FLOAT
            DECLARE @DISCOUNT4 FLOAT
            DECLARE @DISCOUNT5 FLOAT
            DECLARE @PAYMETHOD_ID INT
            DECLARE @START_DATE DATETIME
            DECLARE @FINISH_DATE DATETIME
            DECLARE @PROCESS_STAGE INT
            DECLARE @RECORD_EMP INT
            DECLARE @RECORD_DATE DATETIME
            DECLARE @RECORD_IP NVARCHAR(50)

            SET @PRODUCT_ID=#GETP.PRODUCT_ID#
            SET @DISCOUNT1=#DISCOUNT_1#
            SET @DISCOUNT2=#DISCOUNT_2#
            SET @DISCOUNT3=0
            SET @DISCOUNT4=0
            SET @DISCOUNT5=0
            SET @PAYMETHOD_ID=#attributes.PAYMETHOD_ID#
            SET @START_DATE=CONVERT(DATETIME,'#attributes.START_DATE#')
            SET @FINISH_DATE=CONVERT(DATETIME,'#attributes.FINISH_DATE#')
            SET @PROCESS_STAGE=275
            SET @RECORD_EMP=#session.ep.userid#
          --  SET @FINISH_DATE=GETDATE()
            SET @RECORD_IP='91.93.201.77'

            INSERT INTO catalyst_prod_1.CONTRACT_SALES_PROD_DISCOUNT (PRODUCT_ID,DISCOUNT1,DISCOUNT2,DISCOUNT3,DISCOUNT4,DISCOUNT5,PAYMETHOD_ID,START_DATE,FINISH_DATE,PROCESS_STAGE,RECORD_EMP,RECORD_DATE,RECORD_IP)
            VALUES (@PRODUCT_ID,@DISCOUNT1,@DISCOUNT2,@DISCOUNT3,@DISCOUNT4,@DISCOUNT5,@PAYMETHOD_ID,@START_DATE,@FINISH_DATE,@PROCESS_STAGE,@RECORD_EMP,@RECORD_DATE,@RECORD_IP)
        </cfquery>
        <CFELSEIF GETP.recordCount GT 1>
            <cfoutput>
                #PRODUCT_CODE# SKU ile Birden Fazla Ürün Var
            </cfoutput>
        <CFELSE>
            <cfoutput>
                #PRODUCT_CODE# SKU ile Ürün Bulunamadı
            </cfoutput>
        </CFIF>   
</CFLOOP>
<script>
    alert("Aktarım Tamamlandı");
    <cfoutput>window.location.href="#request.self#?fuseaction=#attributes.fuseaction#&page=9"</cfoutput>
</script>

</cfif>
</cfif>

<script>
    $('#file_11').change(function(e){
        var fileName = e. target. files[0]. name;
        $("#FileName").val(fileName)
    });
</script>
</cf_box>