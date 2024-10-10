



<cfif session.ep.userid eq 2>
    









    

</cfif>



<cfif not isDefined("attributes.modal_id")>
    <cfset attributes.modal_id=1>
</cfif>
   <cfif attributes.tip eq 5>
    <cfdump var="#attributes#">
   <cfquery name="del" datasource="#dsn3#">
    DELETE FROM SVK_TALEP  WHERE ACTION_ID=#attributes.ACTION_ID# AND FROM_ORDER=#attributes.FROM_ORDER#
</cfquery>
<cfquery name="del" datasource="#dsn3#">
    DELETE FROM LIST_SEVK_TALEP_ROWS_#session.ep.PERIOD_YEAR# WHERE ACTION_ID=#attributes.ACTION_ID# AND FROM_ORDER=#attributes.FROM_ORDER#
</cfquery>
</cfif>
<cfif attributes.tip eq 4>
    <cfquery name="getSvk" datasource="#dsn3#">
        select * from  #DSN3#.LIST_SEVK_TALEP_#session.EP.PERIOD_YEAR#
          WHERE 1=1 AND ACTION_ID=#attributes.ACTION_ID# AND FROM_ORDER=#attributes.FROM_ORDER#
      </cfquery>
    
    
    <cfloop list="#attributes.CBSS#" item="li">
        <cfset WRK_ROW_ID=evaluate("attributes.WRK_ROW_ID_#li#")>
        <cfset AMOUNT=evaluate("attributes.AMOUNT_#li#")>
        <cfdump var="#WRK_ROW_ID#">
        <cfdump var="#AMOUNT#">
        ACTION_ID INT ,FROM_ORDER BIT
        <cfquery name="ins" datasource="#dsn3#">
            INSERT INTO LIST_SEVK_TALEP_ROWS_#session.ep.PERIOD_YEAR#  (WRK_ROW_ID,AMOUNT,SVK_ID,ACTION_ID,FROM_ORDER) VALUES('#WRK_ROW_ID#',#AMOUNT#,#getSvk.SVK_ID#,#attributes.ACTION_ID#,#attributes.FROM_ORDER#)
        </cfquery>
    </cfloop>
    <script>
        closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')
      </script>
    <cfabort>
</cfif>
<cfparam name="attributes.from_order" default="1">
<cfif attributes.tip eq 3>
    <cfinclude template="../Form/add_sevktalep_from_orders.cfm">
    <cfabort>
<cfelseif attributes.tip eq 2>
    <cfquery name="getSvk" datasource="#dsn3#">
        select * from  #DSN3#.LIST_SEVK_TALEP_#session.EP.PERIOD_YEAR#
          WHERE 1=1 AND ACTION_ID=#attributes.ACTION_ID# AND FROM_ORDER=#attributes.FROM_ORDER#
      </cfquery>
      
      <cf_box title="Sevk Emri - #getSvk.SVK_NUMBER#" scroll="1" collapsable="1" resize="1" popup_box="1">
      <cfoutput>
          <cf_grid_list>
              <tr>
                  <th>
                      Belge No
                  </th>
                  <th>
                      #getSvk.SVK_NUMBER#
                  </th>
                  <th>
                      Alıcı
                  </th>
                  <td>
                      #getSvk.MUSTERI#
                  </td>
                  
              </tr>
              <tr>
                  <th>
                      Kayıt Tarihi
                  </th>
                  <td>
                      #dateFormat(getSvk.RECORD_DATE,"dd/mm/yyyy")#
                  </td>
                  <th>
                      Kaydeden
                  </th>
                  <td>
                      #getSvk.KAYIT_PERS#
                  </td>
              </tr>
              <td>
                <button class="btn btn-danger" onclick="silCanim(#attributes.ACTION_ID#,#attributes.from_order#)">Sil</button>
              </td>
          </cf_grid_list>
      </cfoutput>
        <hr>
      <div id="header_box_7956964" class="portHeadLight ui-draggable-handle" style="">	
        <!-- del -->
        <div class="portHeadLightTitle">
            <span id="handle_box_7956964"><a>Ürünler</a></span> 
        </div>
    	                 
    </div>
       
            <cfif attributes.from_order eq 1>
                <cfquery name="getP" datasource="#dsn3#">
                    SELECT S.PRODUCT_NAME,S.PRODUCT_CODE_2,ORR.QUANTITY,ORR.WRK_ROW_ID FROM ORDER_ROW AS ORR LEFT JOIN STOCKS AS S ON S.STOCK_ID=ORR.STOCK_ID WHERE ORR.ORDER_ID=#attributes.ACTION_ID#
                </cfquery>
                INTERNALDEMAND
            
            <cfelse>
                <cfquery name="getP" datasource="#dsn3#">
                    SELECT S.PRODUCT_NAME,S.PRODUCT_CODE_2,ORR.QUANTITY,ORR.WRK_ROW_ID FROM INTERNALDEMAND_ROW AS ORR LEFT JOIN STOCKS AS S ON S.STOCK_ID=ORR.STOCK_ID WHERE ORR.I_ID=#attributes.ACTION_ID#
                </cfquery>
            </cfif>
          <!---  --->
<form name="frm1" id="frm1" action="<cfoutput>#request.self#?fuseaction=#attributes.fuseaction#</cfoutput>">
    <input type="hidden" name="from_order" value="<cfoutput>#attributes.from_order#</cfoutput>">
    <input type="hidden" name="ACTION_ID" value="<cfoutput>#attributes.ACTION_ID#</cfoutput>">
    <input type="hidden" name="modal_id" value="<cfoutput>#attributes.modal_id#</cfoutput>">
   
          <cf_big_list>
                <thead>
                    <tr>
                        <th>
                            SKU
                        </th>
                        <th>
                            Ürün
                        </th>
                        <th>
                            Miktar
                        </th>
                     
                        <th>

                        </th>
                    </tr>
                </thead>
                <cfoutput query="getP">
                    <cfquery name="getms" datasource="#dsn3#">
                        SELECT * FROM LIST_SEVK_TALEP_ROWS_#session.EP.PERIOD_YEAR# WHERE WRK_ROW_ID='#WRK_ROW_ID#'
                    </cfquery>
                    <tr>
                        <td>
                            #PRODUCT_CODE_2#
                        </td>
                        <td>
                            #PRODUCT_NAME#
                        </td>
                        <td>
                            <div class="form-group">
                           <input type="text" value="#QUANTITY#" readonly name="AMOUNT_#currentrow#">
                           <input type="hidden" value="#WRK_ROW_ID#" name="WRK_ROW_ID_#currentrow#">
                        </div>
                        </td>
                       
                        <td>
                            <CFIF getms.recordCount>
                                <a href="javascript://"><span  class="icn-md icon-check"></span></a>
                            <CFELSE>
                            <input type="checkbox" value="#currentrow#" name="CBSS">
                        </CFIF>
                        </td>
                    </tr>
                </cfoutput>
            
            </cf_big_list>
        </form>
            <button class=" ui-wrk-btn ui-wrk-btn-success" onclick="addProducts()">
                Ürünleri Ekle
            </button>
        
      
      
      </cf_box>
      <script>
       function silCanim(SEVK_ID,fo){
        var frm=$("#frm1")
            $.ajax({
                url:"/index.cfm?fuseaction=sales.emptypopup_add_sevk_talep&tip=5",
                type:"POST",
                data:frm.serialize(),
                success:function (params) {
                    alert("Başarılı");
                    closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')
                }
            }) 

        }
        function addProducts() {
            var frm=$("#frm1")
            $.ajax({
                url:"/index.cfm?fuseaction=sales.emptypopup_add_sevk_talep&tip=4",
                type:"POST",
                data:frm.serialize(),
                success:function (params) {
                    alert("Başarılı");
                    closeBoxDraggable('<cfoutput>#attributes.modal_id#</cfoutput>')
                }
            })
        }
      </script>
    <cfelseif attributes.tip eq 1>


<cfquery name="GETPP" datasource="#DSN3#">
    SELECT SHIP_INTERNAL_NO,SHIP_INTERNAL_NUMBER FROM GENERAL_PAPERS WHERE SHIP_INTERNAL_NO='PSVK'
</cfquery>
<CFSET SIFIRIM="">
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 1><CFSET SIFIRIM="000000"></CFIF>
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 2><CFSET SIFIRIM="00000"></CFIF>
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 3><CFSET SIFIRIM="0000"></CFIF>
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 4><CFSET SIFIRIM="000"></CFIF>
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 5><CFSET SIFIRIM="00"></CFIF>
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 6><CFSET SIFIRIM="0"></CFIF>
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 7><CFSET SIFIRIM=""></CFIF>
<CFSET PAPER_NO="#GETPP.SHIP_INTERNAL_NO#-#SIFIRIM##GETPP.SHIP_INTERNAL_NUMBER#">
<cfquery name="ins" datasource="#dsn3#" result="resa">
    INSERT INTO SVK_TALEP (SVK_NUMBER,ACTION_ID,FROM_ORDER,RECORD_DATE,RECORD_EMP) VALUES ('#PAPER_NO#',#attributes.ACTION_ID#,#attributes.from_order#,GETDATE(),#session.EP.userid#)
</cfquery>
<cfquery name="getrows" datasource="#dsn3#">
    SELECT * FROM catalyst_prod_1.INTERNALDEMAND_ROW WHERE I_ID=#attributes.ACTION_ID#
</cfquery>
<CFLOOP query="getrows">
    <cfquery name="ins" datasource="#dsn3#">
        INSERT INTO LIST_SEVK_TALEP_ROWS_#session.ep.PERIOD_YEAR#  (WRK_ROW_ID,AMOUNT,SVK_ID,ACTION_ID,FROM_ORDER) VALUES('#WRK_ROW_ID#',#QUANTITY#,#resa.generatedkey#,#attributes.ACTION_ID#,#attributes.FROM_ORDER#)
    </cfquery>
</CFLOOP>

<cfquery name="UPD" datasource="#DSN3#">
   UPDATE  GENERAL_PAPERS SET SHIP_INTERNAL_NUMBER=SHIP_INTERNAL_NUMBER+1 WHERE SHIP_INTERNAL_NO='PSVK'
</cfquery>

<script>
    window.opener.location.reload();
    this.close();    
</script>
<cfelseif attributes.tip eq 3>
 
<script>
    window.opener.location.reload();
    this.close();    
</script>
</cfif>


