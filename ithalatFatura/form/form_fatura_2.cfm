<cf_box title="İthal Mal Girişi">
    <cfform method="post" action="#request.self#?fuseaction=invoice.emptypopup_pda_sf" id="form1">
        <input type="hidden" name="WRK_ROW_ID" id="WRK_ROW_ID ">
        <input type="hidden" name="INVOICE_ID" id="INVOICE_ID">
        <input type="hidden" name="PRODUCT_ID" id="PRODUCT_ID">        
        <input type="hidden" name="STOCK_ID" id="STOCK_ID">
        <input type="hidden" name="IV_DATE" id="IV_DATE">
        <input type="hidden" name="SHIP_ID" id="SHIP_ID" value="0">
        <div class="form-group">
        <label>Fatura No</label>
            <input type="text" name="Barcode" id="Barcode" onkeyup="getInvoiceRows(event,this)" placeholder="Fatura No" style="font-size:20pt !important">
        </div>
        <div class="form-group">
            <label>Ürün Barkodu</label>
            <input type="text" name="ProductNo" id="ProductNo" disabled onkeyup="sbmForm(event,this)" placeholder="Ürün Barkodu" style="font-size:20pt !important">
        </div>
</cfform>
</cf_box>

<script>
var dsn2="<cfoutput>#dsn2#</cfoutput>";
var dsn3="<cfoutput>#dsn3#</cfoutput>";
var dsn="<cfoutput>#dsn#</cfoutput>";
    function getInvoiceRows(ev,el){
    if(ev.keyCode==13){
        el.setAttribute("disabled","true")
        ev.preventDefault();    
        var InvoiceResult=wrk_query("SELECT *,YEAR(INVOICE_DATE) AS IV_DATE FROM INVOICE WHERE INVOICE_NUMBER='"+el.value+"'","dsn2")
        if(InvoiceResult.recordcount >0){
            $("#INVOICE_ID").val(InvoiceResult.INVOICE_ID[0])
            $("#IV_DATE").val(InvoiceResult.IV_DATE[0])
            var pnoElem=document.getElementById("ProductNo");
            pnoElem.removeAttribute("disabled");
            pnoElem.focus();
            
        }else{
            el.removeAttribute("disabled")
            document.getElementById("ProductNo").setAttribute("disabled","true");
            alert("Fatura Bulunamadı")
        }
    }

    }
    function sbmForm(ev,el) {
    if(ev.keyCode==13){
        ev.preventDefault();
        var invId=document.getElementById("INVOICE_ID").value;
        var str="SELECT IR.WRK_ROW_ID,IR.AMOUNT,ISNULL(SH.SHIP_ID,0) AS SHIP_ID,S.STOCK_ID,S.PRODUCT_ID  FROM INVOICE_ROW AS IR INNER JOIN "+dsn3+".STOCKS AS S ON S.STOCK_ID=IR.STOCK_ID"
        str+=" LEFT JOIN SHIP_ROW AS SR ON SR.WRK_ROW_RELATION_ID=IR.WRK_ROW_ID LEFT JOIN SHIP AS SH ON SH.SHIP_ID=SR.SHIP_ID AND SH.SHIP_TYPE=811 WHERE 1=1 AND S.PRODUCT_CODE_2='"+el.value+"' AND IR.INVOICE_ID="+invId;
        var Qr=wrk_query(str,"DSN2") 
        if(Qr.recordcount>0){
            document.getElementById("WRK_ROW_ID ").value=Qr.WRK_ROW_ID[0];
            document.getElementById("SHIP_ID").value=Qr.SHIP_ID[0];
            document.getElementById("PRODUCT_ID").value=Qr.PRODUCT_ID[0];
            document.getElementById("STOCK_ID").value=Qr.STOCK_ID[0];
            $("#form1").submit();
        }else{
            alert("Ürün Bulunamadı");
        }
    }
    }
</script>


<!-----
    &INVOICE_ID=#attributes.INVOICE_ID#&WRK_ROW_ID=#WRK_ROW_ID#&SHIP_ID=#SHIP_ID#"----->