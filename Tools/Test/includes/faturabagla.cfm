<cfquery name="sorgu1" datasource="#dsn2#">
    SELECT * FROM SHIP_ROW_PBS WHERE IMPORT_INVOICE_ID=#attributes.INVOICE_ID#
</cfquery>
<cfloop query="sorgu1">
    <cfquery name="up1" datasource="#dsn2#">
        UPDATE SHIP_ROW SET WRK_ROW_RELATION_ID='#sorgu1.WRK_ROW_RELATION_ID#' ,IMPORT_PERIOD_ID=#sorgu1.IMPORT_PERIOD_ID#,IMPORT_INVOICE_ID=#sorgu1.IMPORT_INVOICE_ID# WHERE WRK_ROW_ID='#sorgu1.WRK_ROW_ID#'
    </cfquery>
</cfloop>
<cfdump var="#sorgu1#">


<cfquery name="sorgu2" datasource="#dsn2#">
    SELECT DISTINCT INVOICE_ID,INVOICE_NUMBER,SHIP_ID,SHIP_NUMBER,IS_WITH_SHIP,SHIP_PERIOD_ID,IMPORT_INVOICE_ID,IMPORT_PERIOD_ID  FROM INVOICE_SHIPS_PBS WHERE IMPORT_INVOICE_ID=#attributes.INVOICE_ID#
</cfquery>

<cfloop query="sorgu2">
    <cfquery name="up2" datasource="#dsn2#">
        	INSERT INTO catalyst_prod_2024_1.INVOICE_SHIPS (
    INVOICE_ID,INVOICE_NUMBER,SHIP_ID,SHIP_NUMBER,IS_WITH_SHIP,SHIP_PERIOD_ID,IMPORT_INVOICE_ID,IMPORT_PERIOD_ID 
)
values (
<cfif len(INVOICE_ID)>#INVOICE_ID#<cfelse>NULL</cfif>,
<cfif len(INVOICE_NUMBER)>'#INVOICE_NUMBER#'<cfelse>NULL</cfif>,
<cfif len(SHIP_ID)>#SHIP_ID#<cfelse>NULL</cfif>,
<cfif len(SHIP_NUMBER)>'#SHIP_NUMBER#'<cfelse>NULL</cfif>,
<cfif len(IS_WITH_SHIP)>#IS_WITH_SHIP#<cfelse>NULL</cfif>,
<cfif len(SHIP_PERIOD_ID)>#SHIP_PERIOD_ID#<cfelse>NULL</cfif>,
<cfif len(IMPORT_INVOICE_ID)>#IMPORT_INVOICE_ID#<cfelse>NULL</cfif>,
<cfif len(IMPORT_PERIOD_ID)>#IMPORT_PERIOD_ID#<cfelse>NULL</cfif>
)
    </cfquery>
</cfloop>
<cfdump var="#sorgu2#">