<cftry>
<cfdump var="#attributes#">

<cfif attributes.action_type neq 591>
    <cfset STOCK_ID=listGetAt(attributes.action_type,"1","|")>
    <cfset INVOICE_ID=listGetAt(attributes.action_type,"2","|")>
    <cfset INVOICE_ROW_ID=listGetAt(attributes.action_type,"3","|")>
    <cfset AMOUNT=listGetAt(attributes.action_type,"4","|")>
    <cfquery name="getIR" datasource="#dsn2#">
        SELECT * FROM INVOICE_LOT_NUMBER_PARTNER AS ILP
        INNER JOIN #dsn3#.STOCKS AS S ON S.STOCK_ID=ILP.STOCK_ID
         WHERE INVOICE_ID=#INVOICE_ID# AND ILP.STOCK_ID=#STOCK_ID#
    </cfquery>
    <cfoutput query="">
        <div style="display:block;width:100mm;height:70mm;border:solid 1px black;">
            <cf_workcube_barcode type="code128" value="#PRODUCT_CODE_2#"  show="1"  height="50">
            #PRODUCT_CODE_2#
            <BR>
            #PRODUCT_NAME#
            <cf_workcube_barcode type="code128" value="#LOT_NUMBER#"  show="1"  height="50">
                #LOT_NUMBER#
                <BR>
        </div>
    </cfoutput>
<cfelse>

</cfif>



<cfcatch>
    <cfdump var="#cfcatch#">
</cfcatch>
<cftry>