<cfquery name="getRows" datasource="#dsn2#">
    SELECT WRK_ROW_ID,AMOUNT,NAME_PRODUCT,UNIT,ISNULL((SELECT SUM(AMOUNT) FROM SHIP_ROW
    INNER JOIN #DSN2#.SHIP ON SHIP_ROW.SHIP_ID=SHIP.SHIP_ID AND SHIP.SHIP_TYPE=811
     WHERE WRK_ROW_RELATION_ID=INVOICE_ROW.WRK_ROW_ID),0)  AS READED_AMOUNT
    ,ISNULL((SELECT TOP 1 SHIP.SHIP_ID FROM SHIP_ROW
    INNER JOIN #DSN2#.SHIP ON SHIP_ROW.SHIP_ID=SHIP.SHIP_ID AND SHIP.SHIP_TYPE=811
     WHERE WRK_ROW_RELATION_ID=INVOICE_ROW.WRK_ROW_ID),0) SHIP_ID
      FROM INVOICE_ROW WHERE INVOICE_ID=#attributes.INVOICE_ID#
</cfquery>
<table>
<cfoutput query="getRows">
    <tr>
        <td>
           <a href="/index.cfm?fuseaction=invoice.emptypopup_pda_sf&INVOICE_ID=#attributes.INVOICE_ID#&WRK_ROW_ID=#WRK_ROW_ID#&SHIP_ID=#SHIP_ID#"> #NAME_PRODUCT#</a>
        </td>
        <td>
            #AMOUNT# #UNIT#

        </td>
        <td>
            #READED_AMOUNT# #UNIT#
        </td>
        <td>
            #AMOUNT-READED_AMOUNT# #UNIT#
        </td>
        
    </tr>
</cfoutput>

</table>