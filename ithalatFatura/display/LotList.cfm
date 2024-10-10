<cf_box title="Lot Listesi" scroll="1" collapsable="1" resize="1" popup_box="1">

<cfparam name="attributes.INVOICE_NUMBER" default="">
<cfparam name="attributes.INVOICE_ID" default="">
<cfparam name="attributes.SERIAL_NO" default="">
<cfparam name="attributes.SERIAL_NO" default="">
<cfparam name="attributes.REF_NO" default="">
<cfif not isDefined("attributes.isAjax")>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">

<table>
    <tr>
        <td>
            <div class="form-group">
                <label><cf_get_lang dictionary_id='58133.Fatura No'></label>
                <input type="text" name="INVOICE_NUMBER" value="<cfoutput>#attributes.INVOICE_NUMBER#</cfoutput>" >
                <input type="hidden" name="INVOICE_ID" value="<cfoutput>#attributes.INVOICE_ID#</cfoutput>">
            </div>
        </td>
        <td>
            <div class="form-group">
<label><cf_get_lang dictionary_id='57637.Seri No'>(Lot No)</label>
            <input type="text" name="SERIAL_NO" value="<cfoutput>#attributes.SERIAL_NO#</cfoutput>">
            </div>
        </td>
        <td>
            <div class="form-group">
<label>Trip No</label>
            <input type="text" name="REF_NO" value="<cfoutput>#attributes.REF_NO#</cfoutput>">
            </div>
        </td>
    </tr>
    <input type="hidden" name="is_submit" value="1">
    <input type="submit">
</table>
</cfform>
</cfif>
<cfif isDefined("attributes.is_submit") and (attributes.is_submit eq 1)>
    <cfquery name="getLot" datasource="#dsn2#">
SELECT ILP.*,ISNULL(TS.LOT_NO
	,TS2.LOT_NO) LOT_NO,S.PRODUCT_CODE_2,S.PRODUCT_NAME,S.PRODUCT_ID AS PIIID,(SELECT COUNT(*) FROM #dsn2#.INVOICE_LOT_NUMBER_PARTNER WHERE STOCK_ID=ILP.STOCK_ID AND INVOICE_ID=
<cfif (isDefined("attributes.INVOICE_NUMBER") and  len(attributes.INVOICE_NUMBER)) OR (isDefined("attributes.REF_NO") and  len(attributes.REF_NO)) >
(SELECT TOP 1 INVOICE_ID FROM #dsn2#.INVOICE WHERE 
<cfif (isDefined("attributes.INVOICE_NUMBER") and  len(attributes.INVOICE_NUMBER))> INVOICE_NUMBER='#attributes.INVOICE_NUMBER#'</cfif>
<cfif (isDefined("attributes.REF_NO") and  len(attributes.REF_NO))> REF_NO='#attributes.REF_NO#'</cfif>
)
    <cfelseif len(attributes.INVOICE_ID)>
#attributes.INVOICE_ID#
    <cfelse>
        INVOICE_ID
</cfif>


) AS MIKKKK
,(
	SELECT SUM(CC) FROM (
SELECT COUNT(*) CC
		FROM catalyst_prod_2024_1.SHIP_ROW
		INNER JOIN catalyst_prod_2024_1.SHIP
			ON SHIP.SHIP_ID = SHIP_ROW.SHIP_ID
		WHERE IMPORT_INVOICE_ID = <cfif (isDefined("attributes.INVOICE_NUMBER") and  len(attributes.INVOICE_NUMBER)) OR (isDefined("attributes.REF_NO") and  len(attributes.REF_NO)) >
    (SELECT INVOICE_ID FROM #dsn2#.INVOICE WHERE INVOICE_NUMBER='#attributes.INVOICE_NUMBER#')
<cfelseif len(attributes.INVOICE_ID)>
    #attributes.INVOICE_ID#
    <cfelse>
        INVOICE_ID
    </cfif> AND SHIP_TYPE = 811 AND STOCK_ID = S.STOCK_ID
		
		UNION ALL
		SELECT COUNT(*) CC
		FROM catalyst_prod_2024_1.STOCK_FIS_ROW
		INNER JOIN catalyst_prod_2024_1.STOCK_FIS
			ON STOCK_FIS.FIS_ID = STOCK_FIS_ROW.FIS_ID
		WHERE REF_NO = <cfif (isDefined("attributes.INVOICE_NUMBER") and  len(attributes.INVOICE_NUMBER)) OR (isDefined("attributes.REF_NO") and  len(attributes.REF_NO)) >
    (SELECT INVOICE_ID FROM #dsn2#.INVOICE WHERE INVOICE_NUMBER='#attributes.INVOICE_NUMBER#')
<cfelseif len(attributes.INVOICE_ID)>
    #attributes.INVOICE_ID#
    <cfelse>
        INVOICE_ID
    </cfif> AND PROCESS_CAT = 1209 AND STOCK_ID = S.STOCK_ID
		) AS T
	
	) AS READ_COUNT

FROM #dsn2#.INVOICE_LOT_NUMBER_PARTNER ILP
LEFT JOIN (
SELECT SR.LOT_NO FROM #dsn2#.SHIP AS S 
INNER JOIN #dsn2#.SHIP_ROW AS SR ON SR.SHIP_ID=S.SHIP_ID
WHERE S.PROCESS_CAT=113) AS TS ON TS.LOT_NO=ILP.LOT_NUMBER COLLATE Turkish_CI_AS 
LEFT JOIN (
	SELECT SR.LOT_NO
	FROM #DSN2#.STOCK_FIS AS S
	INNER JOIN #DSN2#.STOCK_FIS_ROW AS SR
		ON SR.FIS_ID = S.FIS_ID
	WHERE S.PROCESS_CAT = 1209
	) AS TS2
	ON TS2.LOT_NO = ILP.LOT_NUMBER COLLATE Turkish_CI_AS
INNER JOIN #dsn3#.STOCKS AS S ON S.PRODUCT_ID=ILP.STOCK_ID  WHERE INVOICE_ID=<cfif (isDefined("attributes.INVOICE_NUMBER") and  len(attributes.INVOICE_NUMBER)) OR (isDefined("attributes.REF_NO") and  len(attributes.REF_NO)) >
    (SELECT TOP 1 INVOICE_ID FROM #dsn2#.INVOICE WHERE 
<cfif (isDefined("attributes.INVOICE_NUMBER") and  len(attributes.INVOICE_NUMBER))> INVOICE_NUMBER='#attributes.INVOICE_NUMBER#'</cfif>
<cfif (isDefined("attributes.REF_NO") and  len(attributes.REF_NO))> REF_NO='#attributes.REF_NO#'</cfif>
)
<cfelseif len(attributes.INVOICE_ID)>
#attributes.INVOICE_ID#
<cfelse>
    INVOICE_ID
</cfif>
<CFIF LEN(attributes.SERIAL_NO)>
    AND ILP.LOT_NUMBER='#attributes.SERIAL_NO#'
</CFIF>
ORDER BY S.PRODUCT_ID
    </cfquery> 
   
    <cfif isDefined("attributes.group") >
        <cf_grid_list>
            <cfset ToplamMik=0>
            <cfset ToplamMik2=0>
        <cfoutput query="getLot" group="PIIID">
        <tr>
            <td>
                <a href="javascript://" onclick="$('##TRE_#PIIID#').toggle()">Detay</a>
            </td>
            <td>
                #PRODUCT_CODE_2#
            </td>
            <td>
                #PRODUCT_NAME#
            </td>    
            <td>
             #READ_COUNT#/#MIKKKK#
             <cfset ToplamMik=ToplamMik+MIKKKK>
             <cfset ToplamMik2=ToplamMik2+READ_COUNT>
             <cfif READ_COUNT eq MIKKKK>
                <span style="color:green;float: right;" class="icn-md icon-check"></span>
             <cfelse>
                <span style="color:red;float: right;" class="icn-md icon-times"></span>
             </cfif>
            </td>        
        </tr>
    
            <tr id="TRE_#PIIID#" style="display:none">
                <td colspan="3">                
                    <cf_big_list>
                    
                        <tr>
                            <td>
                                <cf_get_lang dictionary_id='58800.Ürün Kodu'>
                            </td>
                            <td>
                                <cf_get_lang dictionary_id='44019.Ürün'>
                            </td>
                            <td>
                                <cf_get_lang dictionary_id='57637.Seri No'>(Lot No)
                            </td>
                        </tr>
                        <cfoutput>
                            <tr <cfif LOT_NO eq LOT_NUMBER>style="background:##00800054"<cfelse>style="background:##ff00006b"</cfif>>
                                <td>
                                    #PRODUCT_CODE_2#
                                </td>
                                <td>
                                    #PRODUCT_NAME#
                                </td>
                                <td>
                                    #LOT_NUMBER#
                                </td>
                                <td>
                                    <button type="button">G</button>
                                    <button type="button">S</button>
                                </td>
                            </tr>
                        </cfoutput>
                    </cf_big_list>
                </td>
            </tr>
        
        </cfoutput>
        <tfoot>
            <tr>
                <td colspan="3"><cf_get_lang dictionary_id='57492.Toplam'></td>
                <td><cfoutput>
                    
                    #ToplamMik2#/#ToplamMik#
                    <cfif ToplamMik2 eq ToplamMik>
                        <span style="color:green;float: right;" class="icn-md icon-check"></span>
                     <cfelse>
                        <span style="color:red;float: right;" class="icn-md icon-times"></span>
                     </cfif>
                </cfoutput></td>
            </tr>
        </tfoot>
    </cf_grid_list>
    <cfelse>
        
<cf_big_list>
    <tr>
        <td>
            <cf_get_lang dictionary_id='58800.Ürün Kodu'>
        </td>
        <td>
            <cf_get_lang dictionary_id='44019.Ürün'>
        </td>
        <td>
            <cf_get_lang dictionary_id='57637.Seri No'>(Lot No)
        </td>
    </tr>
    <cfoutput query="getLot">
        <tr <cfif LOT_NO eq LOT_NUMBER>style="background:##00800054"<cfelse>style="background:##ff00006b"</cfif>>
            <td>
                #PRODUCT_CODE_2#
            </td>
            <td>
                #PRODUCT_NAME#
            </td>
            <td>
                #LOT_NUMBER#
            </td>
            <td>
                <button type="button">G</button>
                <button type="button">S</button>
            </td>
        </tr>
    </cfoutput>
</cf_big_list>
</cfif>
</cfif>


</cf_box>