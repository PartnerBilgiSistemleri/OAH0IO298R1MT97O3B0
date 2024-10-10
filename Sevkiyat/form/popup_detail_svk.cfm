<cfquery name="gets" datasource="#dsn3#">
<cfif attributes.IS_FROM_ORDER EQ 1>
   SELECT ORR.QUANTITY AS SIPARIS_MIKTARI
	,ISNULL(HR.AMOUNT, 0) AS HAZIRLANAN_MIKTAR
	,ISNULL(SR.AMOUNT, 0) AS IRSALIYE_MIKTARI
	,HR.ACTION_ID
	,HR.SVK_ID
	,ORR.LOT_NO
	,1 AS FROM_ORDER
	,S.STOCK_ID
	,S.PRODUCT_ID
	,S.PRODUCT_NAME
	,S.MANUFACT_CODE
	,S.PRODUCT_CODE	
	,PU.MAIN_UNIT
	,PU.PRODUCT_UNIT_ID
	,ORR.WRK_ROW_ID	
	,ORR.ORDER_ROW_ID AS ACTION_ROW_ID
	,O.ORDER_NUMBER AS PAPER_NO
FROM #dsn3#.ORDER_ROW AS ORR
INNER JOIN #dsn3#.ORDERS AS O ON O.ORDER_ID=ORR.ORDER_ID
LEFT JOIN #dsn3#.HAZIRLAMA_ROWS AS HR ON HR.WRK_ROW_ID = ORR.WRK_ROW_ID COLLATE Turkish_CI_AS
LEFT JOIN #dsn2#.SHIP_ROW AS SR ON SR.WRK_ROW_RELATION_ID = ORR.WRK_ROW_ID
LEFT JOIN #dsn3#.STOCKS AS S ON S.STOCK_ID=ORR.STOCK_ID
LEFT JOIN #dsn3#.PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND PU.IS_MAIN=1
WHERE ORR.ORDER_ID = #attributes.ACTION_ID#
<CFELSE>
SELECT ORR.QUANTITY AS SIPARIS_MIKTARI
	,ISNULL(HR.AMOUNT, 0) AS HAZIRLANAN_MIKTAR
	,ISNULL(SR.AMOUNT, 0) AS IRSALIYE_MIKTARI
	,HR.ACTION_ID
	,HR.SVK_ID
	,ORR.LOT_NO
	,0 AS FROM_ORDER
	,S.STOCK_ID
	,S.PRODUCT_ID
	,S.PRODUCT_NAME
	,S.PRODUCT_CODE	
	,S.MANUFACT_CODE
	,PU.MAIN_UNIT
	,PU.PRODUCT_UNIT_ID
	,ORR.WRK_ROW_ID	
	,ORR.I_ROW_ID AS ACTION_ROW_ID
	,IIID.DEPARTMENT_IN
	,IIID.LOCATION_IN
	,IIID.INTERNAL_NUMBER AS PAPER_NO
FROM #dsn3#.INTERNALDEMAND_ROW AS ORR
INNER JOIN #dsn3#.INTERNALDEMAND AS IIID ON IIID.INTERNAL_ID=ORR.I_ID
LEFT JOIN #dsn3#.HAZIRLAMA_ROWS AS HR ON HR.WRK_ROW_ID = ORR.WRK_ROW_ID COLLATE Turkish_CI_AS
LEFT JOIN #dsn2#.SHIP_ROW AS SR ON SR.WRK_ROW_RELATION_ID = ORR.WRK_ROW_ID
LEFT JOIN #dsn3#.STOCKS AS S ON S.STOCK_ID=ORR.STOCK_ID
LEFT JOIN #dsn3#.PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND PU.IS_MAIN=1
WHERE ORR.I_ID = #attributes.ACTION_ID# 
</cfif>
</cfquery>
<cF_big_list>
<cfform method="post" action="#request.self#?fuseaction=stock.emptypopup_add_irsaliye">
	<input type="hidden" name="IS_FROM_ORDER" value="<cfoutput>#attributes.IS_FROM_ORDER#</cfoutput>">
	<input type="hidden" name="ACTION_ID" value="<cfoutput>#attributes.ACTION_ID#</cfoutput>">
    <cfoutput query="gets">
        <tr>
			<td>
				<input type="hidden" name="STOCK_ID_#currentrow#" value="#STOCK_ID#">
				<input type="hidden" name="PRODUCT_ID_#currentrow#" value="#PRODUCT_ID#">
				<input type="hidden" name="WRK_ROW_ID_#currentrow#" value="#WRK_ROW_ID#">
				<input type="hidden" name="PRODUCT_UNIT_ID_#currentrow#" value="#PRODUCT_UNIT_ID#">
				<input type="hidden" name="PRODUCT_UNIT_#currentrow#" value="#MAIN_UNIT#">
				<input type="hidden" name="ACTION_ROW_ID_#currentrow#" value="#ACTION_ROW_ID#">
				
				#currentrow#
			</td>
			<td>
				#MANUFACT_CODE#
			</td>	
			<td>
				#PRODUCT_NAME#
			</td>
			<td>
				<input type="text" readonly name="FATURALAMA_MIKTAR_#currentrow#" value="#HAZIRLANAN_MIKTAR-IRSALIYE_MIKTARI#">
			</td>
			<td>
				<input type="checkbox" name="ROWCOUNT_" value="#currentrow#">
			</td>
		</tr>
    </cfoutput>
	<tr>
		<td>
			<input type="submit">
		</td>
	</tr>
</cfform>
</cF_big_list>