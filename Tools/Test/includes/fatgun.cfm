<cfdump var="#attributes#">

<cfquery name="up" datasource="#dsn2#">
    UPDATE INVOICE SET PROCESS_STAGE=276 where INVOICE_ID=#attributes.INVOICE_ID#
</cfquery>

<script>
    alert("Fatura Kapatılmıştır");
   window.opener.location.reload();
    this.close();

</script>