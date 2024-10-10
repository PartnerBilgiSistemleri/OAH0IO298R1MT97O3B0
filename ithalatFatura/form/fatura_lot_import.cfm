
<cfparam name="attributes.AKSIYON" default="0">
<cfquery name="ishv" datasource="#dsn2#">
    SELECT * FROM INVOICE_LOT_NUMBER_PARTNER WHERE INVOICE_ID=#attributes.INVOICE_ID#
</cfquery>
<cfif attributes.AKSIYON eq 0>
    <cfset aTitle="Lot İşlemleri">
<cfelseif attributes.AKSIYON eq 1>
    <cfset aTitle="Lot İşlemleri - Lot Aktarım">
<cfelseif attributes.AKSIYON eq 2>
    <cfset aTitle="Lot İşlemleri - Lot Üret">
</cfif>

<cf_box title="#aTitle#">

<CFIF attributes.AKSIYON EQ 0>
    
    <cfoutput>
        <CFIF ishv.recordCount>
            <div class="alert alert-warning">Seri No(Lot) Aktarılmış / Üretilmiştir</div>
        <cfelse>
        
        <button class="ui-wrk-btn ui-wrk-btn-success"  onclick="window.location.href='#request.self#?fuseaction=#attributes.fuseaction#&sayfa=ex&AKSIYON=1&INVOICE_ID=#attributes.INVOICE_ID#'">Lot Aktar</button>
        <button class="ui-wrk-btn ui-wrk-btn-red"  onclick="window.location.href='#request.self#?fuseaction=#attributes.fuseaction#&sayfa=ex&AKSIYON=2&INVOICE_ID=#attributes.INVOICE_ID#'">Lot Üret</button>
    </CFIF>

        
        
    </cfoutput>
    <cfabort>
</CFIF>

<cfif attributes.AKSIYON EQ 1>
<cfform method="post"  enctype="multipart/form-data" action="#request.self#?fuseaction=#attributes.fuseaction#&sayfa=ex&AKSIYON=1">
    <input type="file" name="file_11" id="file_11">
    <input type="hidden"  name="FileName" id="FileName">
    <input type="hidden"  name="is_submitted" id="is_submitted">
    <input type="hidden"  name="INVOICE_ID" id="INVOICE_ID" value="<cfoutput>#attributes.INVOICE_ID#</cfoutput>">
    <input type="submit">
</cfform>

<cfif isdefined("attributes.is_submitted")> 
	<cfif isDefined("attributes.FileName") and len(attributes.FileName)>
		<cffile action = "upload" fileField = "file_11" destination = "#expandPath("./ExDosyalar")#"  nameConflict = "Overwrite" result="resul"> 	
       
        <cfspreadsheet  action="read" src = "#expandPath("./ExDosyalar/#attributes.fileName#")#" query = "res">	
	   
       <cfquery name = "get_invoice_no" dbtype = "query">
		    SELECT 
			    col_1 MANUFACT_CODE,
			    col_2, 
			    col_3,
                col_4 LOT_NO,
                col_5,
                col_6,
                col_7,
                col_8,
                col_9          
		    FROM
			    res     
	    </cfquery>
        <cfloop query="get_invoice_no">
            Merhabaaaaa <cfoutput>#currentrow#</cfoutput>
        <cfquery name="getMainProduct" datasource="#dsn3#">
            SELECT PRODUCT_ID FROM STOCKS WHERE PRODUCT_CODE_2='#MANUFACT_CODE#'
        </cfquery>
        <cfif getMainProduct.recordCount eq 0>
            Ürün Bulunamadı <cfoutput>#MANUFACT_CODE#</cfoutput> <br>
        <cfelse>
           <cfquery name="ins" datasource="#dsn2#">
            INSERT INTO #dsn2#.INVOICE_LOT_NUMBER_PARTNER(INVOICE_ID,LOT_NUMBER,STOCK_ID,MANUFACT_CODE,AMOUNT)
            VALUES
            (#attributes.INVOICE_ID#,'#LOT_NO#',#getMainProduct.PRODUCT_ID#,'#MANUFACT_CODE#',1)
           </cfquery>
        <!-----
            SELECT * FROM #dsn2#.INVOICE_LOT_NUMBER_PARTNER

            Kolonlar
IIV_ID	int	
INVOICE_ID	int	
LOT_NUMBER	nvarchar	150
STOCK_ID	int	
MANUFACT_CODE	nvarchar	150
AMOUNT	float	----->
            
        
    </cfif>
    </cfloop>
    </cfif>
    
</cfif>

<script>
    $('#file_11').change(function(e){
        var fileName = e. target. files[0]. name;
        $("#FileName").val(fileName)
    });
</script>

</cfif>

<CFIF attributes.AKSIYON EQ 2>
  <cfquery name="getRows" datasource="#dsn2#">
        SELECT S.STOCK_ID,S.PRODUCT_CODE_2,S.PRODUCT_ID,AMOUNT FROM INVOICE_ROW AS IR LEFT JOIN #dsn3#.STOCKS AS S ON S.STOCK_ID=IR.STOCK_ID WHERE IR.INVOICE_ID=#attributes.INVOICE_ID#        
    </cfquery>
<cfoutput query="getRows">
<cfloop from="1" to="#AMOUNT#" index="i">
    <cfquery name="GETLOT" datasource="#DSN3#">
        SELECT * FROM #dsn3#.LOT_NO_PARTNER
    </cfquery>
    <CFSET SIFIRLAR="">
    <CFIF LEN(GETLOT.LOT_NUMBER) EQ 1>
        <CFSET SIFIRLAR="000000000">
    <cfelseif LEN(GETLOT.LOT_NUMBER) EQ 2>
        <CFSET SIFIRLAR="00000000">
    <cfelseif LEN(GETLOT.LOT_NUMBER) EQ 3>
        <CFSET SIFIRLAR="0000000">
    <cfelseif LEN(GETLOT.LOT_NUMBER) EQ 4>
        <CFSET SIFIRLAR="000000">
    <cfelseif LEN(GETLOT.LOT_NUMBER) EQ 5>
        <CFSET SIFIRLAR="00000">
    <cfelseif LEN(GETLOT.LOT_NUMBER) EQ 6>
        <CFSET SIFIRLAR="0000">
    <cfelseif LEN(GETLOT.LOT_NUMBER) EQ 7>
        <CFSET SIFIRLAR="000">
    <cfelseif LEN(GETLOT.LOT_NUMBER) EQ 8>
        <CFSET SIFIRLAR="00">
    <cfelseif LEN(GETLOT.LOT_NUMBER) EQ 9>
        <CFSET SIFIRLAR="0">
    <cfelseif LEN(GETLOT.LOT_NUMBER) EQ 10>
        <CFSET SIFIRLAR="">
    </CFIF>
       <CFSET YENI_LOT="#SIFIRLAR##GETLOT.LOT_NUMBER#">
       <cfquery name="ins" datasource="#dsn2#">
        INSERT INTO #dsn2#.INVOICE_LOT_NUMBER_PARTNER(INVOICE_ID,LOT_NUMBER,STOCK_ID,MANUFACT_CODE,AMOUNT)
        VALUES
        (#attributes.INVOICE_ID#,'#YENI_LOT#',#getRows.PRODUCT_ID#,'#getRows.PRODUCT_CODE_2#',1)
       </cfquery>
       <cfquery name="UP" datasource="#DSN3#">
            UPDATE #dsn3#.LOT_NO_PARTNER SET LOT_NUMBER=LOT_NUMBER+1
       </cfquery>
    #i#
</cfloop>

 <!-----<  
    <style>
    .ui-wrk-btn-addon-right i{margin-left:5px;color:#fff;}
.ui-wrk-btn-addon-left i{margin-right:5px;color:#fff;}
.ui-wrk-btn-success{background-color: #44b6ae!important;color:#fff!important;}
.ui-wrk-btn:hover{background-color:#36918b!important;transition:.4s;}
.ui-wrk-btn-red{background-color:#e43a45!important;color:#fff!important;}
.ui-wrk-btn-red:hover{background-color:#cf1c28!important;transition:.4s;}
.ui-wrk-btn-extra{background-color: #3598dc!important;color:#fff!important;transition:.4s;}
.ui-wrk-btn-extra:hover{background-color:#217ebd!important;transition:.4s;}
.ui-wrk-btn-warning{background-color: #d58512!important;color:#fff!important;}
.ui-wrk-btn-warning:hover{background-color:#985f0d!important;transition:.4s;}
.ui-wrk-btn-info{background-color: #269abc!important;color:#fff!important;}
.ui-wrk-btn-info:hover{background-color:#1b6d85!important;transition:.4s;}
.ui-wrk-btn-busy{background-color: #c0c0c0!important}
.ui-wrk-btn-busy:hover{background-color: #c0c0c0!important;transition:.4s}
.ui-wrk-btn-busy:focus{background-color: #c0c0c0!important;transition:.4s}
.ui-wrk-btn-busy label{float:right;margin-top: 8px;margin-right: 8px;display: inline-block;color:#e43a45!important;font-weight:bold}
.ui-wrk-btn-busy img{float:left;margin-top: 3px;margin-right: 8px;height: 25px;width: 25px;display: inline-block;caret-color: transparent;}
    </style>
    >---->
</cfoutput>
</CFIF>
</cf_box>