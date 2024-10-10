<cfif isDefined("attributes.yazdirdim")>
    <cfquery name="up" datasource="#dsn3#">
        INSERT INTO LOT_PRINT_PBS (LOT_NO,PRINT_DATE) VALUES ('#attributes.lotno#',GETDATE())
    </cfquery>
<cfabort>
</cfif>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
    <cf_box title="Etiket Yazdır">      
        <div class="form-group">
            <label><cf_get_lang dictionary_id='57637.Seri No'>(Lot No)</label>
            <input type="text" name="LOT_NO">        
        </div>
        <div class="form-group">
            <label>SKU No</label>
            <input type="text" name="sku_no">        
        </div>
        <input type="hidden" name="is_submit">
        <input type="submit">
    </cf_box>
</cfform>

<cfif isDefined("attributes.is_submit")>
    <script>
    <cfif len(attributes.LOT_NO)>
        
            <CFOUTPUT>windowopen("/index.cfm?fuseaction=objects.popup_print_files&iid=#attributes.LOT_NO#&action_id=8&action_type=#attributes.LOT_NO#|&print_type=10","page")</CFOUTPUT>
        </script>   
    </cfif>
    <cfif len(attributes.sku_no)>

        <cfquery name="GETDEPOLAR" datasource="#DSN#">
            select * from catalyst_prod.STOCKS_LOCATION AS SL INNER JOIN catalyst_prod.DEPARTMENT AS D ON D.DEPARTMENT_ID=SL.DEPARTMENT_ID WHERE D.BRANCH_ID IN (
            SELECT DD.BRANCH_ID FROM catalyst_prod.EMPLOYEE_POSITIONS
        INNER JOIN catalyst_prod.DEPARTMENT AS DD ON DD.DEPARTMENT_ID=EMPLOYEE_POSITIONS.DEPARTMENT_ID WHERE EMPLOYEE_ID=#session.ep.userid#
        )
        </cfquery>
        
        <CFTRY>
        
            <cfset iiiiisx=1>
            <cfquery name="getIR" datasource="#dsn2#">
               <cfloop query="GETDEPOLAR">
                        SELECT SUM(STOCK_IN - STOCK_OUT)
                    ,LOT_NO AS LOT_NUMBER 
                    ,S.PRODUCT_ID
                    ,S.PRODUCT_CODE_2
                    ,S.PRODUCT_NAME 
                    ,C.MEMBER_CODE
                    ,'#GETDEPOLAR.DEPARTMENT_ID#-#GETDEPOLAR.LOCATION_ID#' AS SFFFF
                FROM STOCKS_ROW
                LEFT JOIN #DSN3#.STOCKS AS S ON S.STOCK_ID=STOCKS_ROW.STOCK_ID
                LEFT JOIN #DSN#.COMPANY AS C ON C.COMPANY_ID=S.COMPANY_ID
                WHERE STOCKS_ROW. STOCK_ID IN (
                        SELECT STOCK_ID
                        FROM #DSN3#.STOCKS
                        WHERE PRODUCT_CODE_2 = '#attributes.sku_no#'
                        )
                    AND STORE IN (#GETDEPOLAR.DEPARTMENT_ID#)
                    AND STORE_LOCATION IN (#GETDEPOLAR.LOCATION_ID#)
                GROUP BY S.STOCK_ID
                    ,LOT_NO
                    ,S.PRODUCT_ID
                    ,PRODUCT_CODE_2
                    ,S.PRODUCT_NAME 
                    ,C.MEMBER_CODE
                HAVING SUM(STOCK_IN - STOCK_OUT) > 0
                <cfset iiiiisx=iiiiisx+1>
                <cfif iiiiisx lt GETDEPOLAR.recordCount>
                    UNION ALL
                </cfif>
            </cfloop>
            </cfquery> 
            
             <cfset ii=0>
             <cf_box>
             <cf_big_list style="width:100%">
                <thead>
                    <tr>
                        <th>
                            SKU
                        </th>
                        <th>
                            <cf_get_lang dictionary_id='44019.Ürün'>
                        </th>
                        <th>
                            <cf_get_lang dictionary_id='58084.Fiyat'>
                        </th>
                        <th>
                            <cf_get_lang dictionary_id='58873.Satıcı'>
                        </th>
                        <th>
                            <cf_get_lang dictionary_id='57637.Seri No'>(Lot No)
                        </th>
                        <th></th>
                    </tr>
                </thead>
             <cfoutput query="getIR">
                 <cfset ii=ii+1>
                 
                     
                         <tr>
                             <td  >#PRODUCT_CODE_2#</td>
                        
                             <td >#PRODUCT_NAME#</td>
                        
                             <td >
                                 <cfquery name="getP" datasource="#dsn3#">
                                     select * from catalyst_prod_1.PRICE WHERE PRICE_CATID=PRICE_CATID AND STARTDATE<=GETDATE() AND (FINISHDATE IS NULL OR FINISHDATE>=GETDATE()) AND PRODUCT_ID=#PRODUCT_ID#
                                 </cfquery>
                                 #TLFORMAT(getP.PRICE)#
                             </td>
                      
                             <td >
                                 #MEMBER_CODE# 
                             </td>
                       
                             <td >
                                 
                                     
                                     #LOT_NUMBER#
                             </td>
                             <td>
                                <cfif len(LOT_NUMBER)>
                                <a href="##" onclick='YazdirBeni("#LOT_NUMBER#")'><cf_get_lang dictionary_id='57474.Yazdir'></a>
                                    <br>
                                    <span style="color:blue">
                                        <cfquery name="getprd" datasource="#dsn3#">
                                            SELECT TOP 1 * FROM     LOT_PRINT_PBS WHERE LOT_NO='#LOT_NUMBER#' ORDER BY PRINT_DATE DESC
                                        </cfquery>
                                        <cfif getprd.recordCount>
                                            #dateFormat(getprd.PRINT_DATE,"dd/mm/yyyy")#  #timeFormat(getprd.PRINT_DATE,"HH:mm")# 
                                        </cfif>
                                </span>
                                <cfelse>
                                    <span style="color:red"><cf_get_lang dictionary_id='57637.Seri No'>(Lot No) <cf_get_lang dictionary_id='58981.Kayıtlı Değil'></span>
                            </cfif>
                             </td>
                         </tr>
                         
                                                       
                 
               
             </cfoutput>
            </cf_big_list>  
        </cf_box>
        <cfcatch>
            <cfdump var="#cfcatch#">
        </cfcatch>
        </CFTRY>

       <!---<CFOUTPUT>windowopen("/index.cfm?fuseaction=objects.popup_print_files&iid=#attributes.sku_no#&action_id=3&action_type=#attributes.sku_no#|&print_type=10","page")</CFOUTPUT>---->

    </cfif>

</cfif>


<script>
    function YazdirBeni(LOT_NUMBER) {
        $.get("/index.cfm?fuseaction=sales.emptypopup_print_lot_etiket_2&yazdirdim=1&lotno="+LOT_NUMBER).done(function (params) {
            window.location.reload();
            windowopen("/index.cfm?fuseaction=objects.popup_print_files&iid="+LOT_NUMBER+"&action_id=8&action_type="+LOT_NUMBER+"|&print_type=10","page")
        })

        
    }
</script>