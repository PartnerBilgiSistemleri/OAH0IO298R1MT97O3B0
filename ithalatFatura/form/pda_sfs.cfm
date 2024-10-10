<cfparam name="attributes.PRODUCTNO" default="">
<cfparam name="attributes.PRODUCT_ID" default="">
<cfparam name="attributes.STOCK_ID" default="">
<cfparam name="attributes.IV_DATE" default="">
<cf_box title="İthal Mal Girişi">
<cfform method="post" id="rform" action="#request.self#?fuseaction=#attributes.fuseaction#" onsubmit="event.preventDefault();">
    <cfoutput>
        <input type="hidden" name="is_submit" value="1">
        <input type="hidden" name="WRK_ROW_ID" value="#attributes.WRK_ROW_ID#">
        <input type="hidden" name="wwWRK_ROW_ID" value="#attributes.WRK_ROW_ID#">
        <input type="hidden" name="SHIP_ID" value="#attributes.SHIP_ID#">
        <input type="hidden" name="INVOICE_ID" id="INVOICE_ID" value="#attributes.INVOICE_ID#">
        <input type="hidden" name="PRODUCT_ID" id="PRODUCT_ID" value="#attributes.PRODUCT_ID#">
        <input type="hidden" name="STOCK_ID" id="STOCK_ID" value="#attributes.STOCK_ID#">
        <input type="hidden" name="PRODUCTNO" id="PRODUCTNO" value="#attributes.PRODUCTNO#">
        <input type="hidden" name="IV_DATE" id="IV_DATE" value="#attributes.IV_DATE#">
     <div class="form-group">
        <label>Ürün</label>
        <input type="text" name="PBarkod" id="PBarkod" value="#attributes.PRODUCTNO#" readonly style="font-size:20pt !important;color:red">
    </div>
    <div class="form-group">
<label>
    Lot No
</label>
        <input type="text" name="LBarkod" id="LBarkod" onkeyup="saveBelge(this,event)" style="font-size:20pt !important">
    </div>
    </cfoutput>
</cfform>
</cf_box>
<script>
var dsn2="<cfoutput>#dsn2#</cfoutput>";
var dsn3="<cfoutput>#dsn3#</cfoutput>";
var dsn="<cfoutput>#dsn#</cfoutput>";
var dsn1="<cfoutput>#dsn1#</cfoutput>";
    function getProduct(el,ev) {
        
        if(ev.keyCode==13){
            ev.preventDefault();
            var qr=wrk_query("SELECT S.STOCK_ID,P.PRODUCT_ID FROM "+dsn1+".PRODUCT AS P INNER JOIN "+dsn1+".STOCKS AS S ON S.PRODUCT_ID=P.PRODUCT_ID WHERE P.INSTRUCTION='"+el.value+"'");
            if(qr.recordcount>0){
                $("#PRODUCT_ID").val(qr.PRODUCT_ID[0])
                $("#STOCK_ID").val(qr.STOCK_ID[0])
                $("#LBarkod").focus();
            }else{
                alert("Ürün Bulunamadı");
            }
        }
    }
    function saveBelge(el,ev) {
        console.log(ev.keyCode);
        if(ev.keyCode==13){
            var PB=document.getElementById("PBarkod").value;
            var INVOICE_ID=document.getElementById("INVOICE_ID").value;
            var Res=wrk_query("SELECT * FROM INVOICE_LOT_NUMBER_PARTNER WHERE LOT_NUMBER='"+el.value+"' AND MANUFACT_CODE='"+PB+"' AND INVOICE_ID="+INVOICE_ID,"DSN2")
            var q="select COUNT(*) AS SCK from STOCKS_ROW WHERE LOT_NO='"+el.value+"'"
            var qr=wrk_query(q,"dsn2") 
            var sck=parseInt(qr.SCK[0])
            if(sck == 0){
                if(Res.recordcount==1 ){
                    $("#rform").submit();
                }else if(Res.recordcount>1 ){
                    alert("Aynı Seri Numarasından Birden Fazla Giriş Var")
                }else{
                    alert("Seri Numarası Faturaya Tanımlı Seri Numaraları Arasında Bulunamadı")
                }
            }else{
                alert("Bu Seri Numarasının Daha Önce Girişi Yapılmış")
            }
        }
    }
</script>

<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 1>
    <cfif len(attributes.SHIP_ID) and attributes.ship_id neq 0>
       <span style="color:red;font-weight:bold">Birinci </span>
        <cfset DELIVER_DEPT=20>
        <cfset DELIVER_LOC=1>
        <cfset PROCESS_TYPE=811>

        <cfset DELIVER_IN_DEPT=1>
        <cfset DELIVER__IN_LOC=2>
        <cfset PROCESS__IN_TYPE=811>

        <cfinclude template="../query/add_row.cfm">
        <cfoutput><script> window.location.href="/index.cfm?fuseaction=invoice.emptypopup_pda_sf&WRK_ROW_ID=#attributes.WRK_ROW_ID#&SHIP_ID=#attributes.ship_id#&INVOICE_ID=#attributes.INVOICE_ID#&PRODUCT_ID=#attributes.PRODUCT_ID#&STOCK_ID=#attributes.STOCK_ID#&PRODUCTNO=#attributes.PRODUCTNO#"</script></cfoutput>
    <cfelse>
        <span style="color:red;font-weight:bold">İkinci </span>
        <cfquery name="GETMAXID" datasource="#DSN2#">
            SELECT MAX(SHIP_ID) AS MXIDD FROM SHIP
        </cfquery>
        <cfset attributes.rows_=1>
        <cfset SHIP_NUMBER='IMG-#GETMAXID.MXIDD#'>
        <cfset attributes.ACTIVE_PERIOD=session.ep.period_id>
        <cfinclude template="../query/add_belge.cfm">
        <cfquery name="GETMAXID" datasource="#DSN2#">
            SELECT MAX(SHIP_ID) AS MXIDD FROM SHIP
        </cfquery>
        <cfquery name="getper" datasource="#dsn#">
            SELECT * FROM SETUP_PERIOD WHERE PERIOD_YEAR=#attributes.IV_DATE# AND OUR_COMPANY_ID=1
        </cfquery>
          <cfset DELIVER_IN_DEPT=1>
          <cfset DELIVER__IN_LOC=2>
          <cfset PROCESS__IN_TYPE=811>
          <cfquery name="GETSHIP_ROW" datasource="#DSN2#">
            SELECT * FROM SHIP_ROW WHERE SHIP_ID=#GETMAXID.MXIDD#
          </cfquery>
<CFLOOP query="GETSHIP_ROW" >
    <cfquery name="getProductInfo" datasource="#dsn3#">
        SELECT TOP 10 s.PRODUCT_NAME,S.STOCK_ID,S.PRODUCT_ID,PU.MAIN_UNIT,PU.PRODUCT_UNIT_ID,PRODUCT_CODE_2 FROM STOCKS AS S INNER JOIN PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND IS_MAIN=1
     WHERE S.PRODUCT_ID=#PRODUCT_ID#
    </cfquery>
<cfquery name="INS3" datasource="#DSN2#">
    INSERT INTO STOCKS_ROW (STOCK_ID,PRODUCT_ID,UPD_ID,PROCESS_TYPE,STOCK_IN,STORE,STORE_LOCATION,LOT_NO,PROCESS_DATE,PROCESS_TIME) VALUES(#getProductInfo.STOCK_ID#,#getProductInfo.PRODUCT_ID#,#SHIP_ID#,#PROCESS__IN_TYPE#,1,#DELIVER_IN_DEPT#,#DELIVER__IN_LOC#,'#LOT_NO#',CONVERT(DATE,GETDATE()),GETDATE())
</cfquery>

</CFLOOP>         
        <cfquery name="UP" datasource="#DSN2#">
            UPDATE SHIP_ROW SET IMPORT_INVOICE_ID=#attributes.INVOICE_ID#,IMPORT_PERIOD_ID=#getper.PERIOD_ID#,WRK_ROW_RELATION_ID='#attributes.wwWRK_ROW_ID#' WHERE SHIP_ID=#GETMAXID.MXIDD#
        </cfquery>
                <cfquery name="UP" datasource="#DSN2#">
                    UPDATE INVOICE_SHIPS SET IMPORT_INVOICE_ID=#attributes.INVOICE_ID#,IMPORT_PERIOD_ID=#getper.PERIOD_ID# WHERE SHIP_ID=#GETMAXID.MXIDD#
                </cfquery>
        <cfoutput><script> window.location.href="/index.cfm?fuseaction=invoice.emptypopup_pda_sf&WRK_ROW_ID=#attributes.wwWRK_ROW_ID#&SHIP_ID=#GETMAXID.MXIDD#&INVOICE_ID=#attributes.INVOICE_ID#&PRODUCT_ID=#attributes.PRODUCT_ID#&STOCK_ID=#attributes.STOCK_ID#&PRODUCTNO=#attributes.PRODUCTNO#"</script></cfoutput>
    </cfif>
</cfif>