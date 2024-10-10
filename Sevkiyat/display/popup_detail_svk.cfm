<cfquery name="gets" datasource="#dsn3#">
<cfif attributes.IS_FROM_ORDER EQ 1>
   SELECT ORR.QUANTITY AS SIPARIS_MIKTARI
   ,ISNULL((SELECT SUM(AMOUNT) FROM #DSN2#.STOCK_FIS_ROW WHERE WRK_ROW_RELATION_ID=ORR.WRK_ROW_ID ), 0) AS HAZIRLANAN_MIKTAR
	,ISNULL(SR.AMOUNT, 0) AS IRSALIYE_MIKTARI
	,HR.ACTION_ID
	,HR.SVK_ID
	,ORR.LOT_NO
	,1 AS FROM_ORDER
	,S.STOCK_ID
	,S.PRODUCT_ID
	,S.PRODUCT_NAME
	,S.PRODUCT_CODE_2
	,S.PRODUCT_CODE	
	,PU.MAIN_UNIT
	,PU.PRODUCT_UNIT_ID
	,ORR.WRK_ROW_ID	
	,ORR.ORDER_ROW_ID AS ACTION_ROW_ID
	,O.ORDER_NUMBER AS PAPER_NO
FROM #DSN3#.ORDER_ROW AS ORR
INNER JOIN #DSN3#.ORDERS AS O ON O.ORDER_ID=ORR.ORDER_ID
LEFT JOIN #DSN3#.HAZIRLAMA_ROWS AS HR ON HR.WRK_ROW_ID = ORR.WRK_ROW_ID COLLATE Turkish_CI_AS
LEFT JOIN #DSN2#.SHIP_ROW AS SR ON SR.WRK_ROW_RELATION_ID = ORR.WRK_ROW_ID
LEFT JOIN #DSN3#.STOCKS AS S ON S.STOCK_ID=ORR.STOCK_ID
LEFT JOIN #DSN3#.PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND PU.IS_MAIN=1
WHERE ORR.ORDER_ID = #attributes.ACTION_ID#
<CFELSE>
SELECT ORR.QUANTITY AS SIPARIS_MIKTARI
,ISNULL((SELECT SUM(AMOUNT) FROM #DSN2#.STOCK_FIS_ROW WHERE WRK_ROW_RELATION_ID=ORR.WRK_ROW_ID ), 0) AS HAZIRLANAN_MIKTAR
	,ISNULL(SR.AMOUNT, 0) AS IRSALIYE_MIKTARI
	,HR.ACTION_ID
	,HR.SVK_ID
	,ORR.LOT_NO
	,0 AS FROM_ORDER
	,S.STOCK_ID
	,S.PRODUCT_ID
	,S.PRODUCT_NAME
	,S.PRODUCT_CODE	
	,S.PRODUCT_CODE_2
	,PU.MAIN_UNIT
	,PU.PRODUCT_UNIT_ID
	,ORR.WRK_ROW_ID	
	,ORR.I_ROW_ID AS ACTION_ROW_ID
	,IIID.DEPARTMENT_IN
	,IIID.LOCATION_IN
	,IIID.INTERNAL_NUMBER AS PAPER_NO
FROM #DSN3#.INTERNALDEMAND_ROW AS ORR
INNER JOIN #DSN3#.INTERNALDEMAND AS IIID ON IIID.INTERNAL_ID=ORR.I_ID
LEFT JOIN #DSN3#.HAZIRLAMA_ROWS AS HR ON HR.WRK_ROW_ID = ORR.WRK_ROW_ID COLLATE Turkish_CI_AS
LEFT JOIN #DSN2#.SHIP_ROW AS SR ON SR.WRK_ROW_RELATION_ID = ORR.WRK_ROW_ID
LEFT JOIN #DSN3#.STOCKS AS S ON S.STOCK_ID=ORR.STOCK_ID
LEFT JOIN #DSN3#.PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=S.PRODUCT_ID AND PU.IS_MAIN=1
WHERE ORR.I_ID = #attributes.ACTION_ID# 
</cfif>
</cfquery>
<cfform method="post" action="#request.self#?fuseaction=stock.emptypopup_add_irsaliye">
<cF_big_list>
<tr>
	<th>##</th>
	<th>Üretici Kodu</th>
	<th>Ürün</th>
	<th>Miktar</th>
	<th></th>
</tr>
	<input type="hidden" name="IS_FROM_ORDER" value="<cfoutput>#attributes.IS_FROM_ORDER#</cfoutput>">
	<input type="hidden" name="FACTION_ID" value="<cfoutput>#attributes.ACTION_ID#</cfoutput>">
	<input type="hidden" name="ORDER_ID" value="<cfoutput>#attributes.ACTION_ID#</cfoutput>">
    <cfoutput query="gets">
        <tr>
			<td>
				<input type="hidden" name="FSTOCK_ID_#ACTION_ROW_ID#" value="#STOCK_ID#">
				<input type="hidden" name="FPRODUCT_ID_#ACTION_ROW_ID#" value="#PRODUCT_ID#">
				<input type="hidden" name="FWRK_ROW_ID_#ACTION_ROW_ID#" value="#WRK_ROW_ID#">
				<input type="hidden" name="FPRODUCT_UNIT_ID_#ACTION_ROW_ID#" value="#PRODUCT_UNIT_ID#">
				<input type="hidden" name="FPRODUCT_UNIT_#ACTION_ROW_ID#" value="#MAIN_UNIT#">
				<input type="hidden" name="FACTION_ROW_ID_#ACTION_ROW_ID#" value="#ACTION_ROW_ID#">
				
				#currentrow#
			</td>
			<td>
				#PRODUCT_CODE_2#
			</td>	
			<td>
				#PRODUCT_NAME#
			</td>
			<td>
				<input type="text" readonly name="FFATURALAMA_MIKTAR_#ACTION_ROW_ID#" value="#HAZIRLANAN_MIKTAR-IRSALIYE_MIKTARI#">
			</td>
			<td>
				<cfif IRSALIYE_MIKTARI eq HAZIRLANAN_MIKTAR><cfelse>
				<input type="checkbox" name="order_row_id" value="#ACTION_ROW_ID#">
				</cfif>
			</td>
		</tr>
    </cfoutput>
	<tr>
		<td>
			<input type="submit">
		</td>
	</tr>

</cF_big_list>
</cfform>