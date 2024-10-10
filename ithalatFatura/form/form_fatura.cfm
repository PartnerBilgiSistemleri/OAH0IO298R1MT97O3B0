<style>
    .centerOFSc {
     /* border: 5px solid; */
     position: absolute;
    top: 30%;
    
}
</style>
<cfif not isDefined("attributes.islemciii")>
    <div class="centerOFSc" style="width: 100%;height: 27vh;">
<div style="display:flex">
    <div style="width:10%"></div>
    <div onclick="window.location.href='/index.cfm?fuseaction=<cfoutput>#attributes.fuseaction#</cfoutput>&islemciii=1'" class="ui-wrk-btn ui-wrk-btn-warning" style="width:35%;font-size: 30pt !important;height: 26vh;text-align: center;align-content: center;"><span><cf_get_lang dictionary_id='29588.İthal Mal Girişi'></span></div>
    <div style="width:10%"></div>
    <div onclick="window.location.href='/index.cfm?fuseaction=<cfoutput>#attributes.fuseaction#</cfoutput>&islemciii=2'" class="ui-wrk-btn ui-wrk-btn-red" style="width:35%;font-size: 30pt !important;height: 26vh;text-align: center;align-content: center;"><span>Yerli <cf_get_lang dictionary_id='66415.Mal Girişi'></span></div>
    <div style="width:10%"></div>
    </div>
</div>
</cfif>
<cfif isDefined("attributes.islemciii")>
    <cfif attributes.islemciii eq 1>
        <cfinclude template="ithal_mal_girisi.cfm">
    </cfif>
    <cfif attributes.islemciii eq 2>
        <cfinclude template="aksesuar_girisi.cfm">
    </cfif>
</cfif>

<cfabort>
<cf_box title="İthal Mal Girişi">
    <cfform method="post" action="#request.self#?fuseaction=invoice.emptypopup_pda_sf" id="form1">
        <div class="form-group">
            <input type="text" name="Barcode" id="Barcode" onkeyup="getInvoiceRows(event,this)" placeholder="Fatura No">
        </div>
        <div class="form-group">
            <input type="text" name="ProductNo" id="ProductNo" disabled onkeyup="sbmForm(event,this)" placeholder="Fatura No">
        </div>
</cfform>
</cf_box>

<script>
    getInvoiceRows()
</script>