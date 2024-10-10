<cfparam name="attributes.consumer_id" default="">
<cfparam name="attributes.company_id" default="">
<cfparam name="attributes.member_type" default="">
<cfparam name="attributes.member_name" default="">
<cfparam name="attributes.Branch" default="">
<cfparam name="attributes.SvkDurum" default="">
<cfparam name="attributes.IrsDurum" default="">
<cfparam name="attributes.FromOrders" default="">
<cfparam name="attributes.deliver_dept" default="">
<cf_box title="Sevkiyat Emirleri">
<cfform name="order_form">
   <div style="display: flex;align-content: stretch;justify-content: flex-start;align-items: flex-end;">
    <div class="form-group" id="item-company_id">	
        <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='57457.Müşteri'> </label>							
        <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
            <div class="input-group">
                <input type="hidden" name="consumer_id" id="consumer_id" value="<cfoutput>#attributes.consumer_id#</cfoutput>">
                <input type="hidden" name="company_id" id="company_id" value="<cfoutput>#attributes.company_id#</cfoutput>">
                <input type="hidden" name="member_type" id="member_type" value="<cfoutput>#attributes.member_type#</cfoutput>">
                <input name="member_name" type="text" id="member_name" placeholder="Cari Hesap" onfocus="AutoComplete_Create('member_name','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','MEMBER_NAME,MEMBER_PARTNER_NAME,MEMBER_CODE','get_member_autocomplete','\'1,2\'','CONSUMER_ID,COMPANY_ID,MEMBER_TYPE','consumer_id,company_id,member_type','','3','250');" value="<cfoutput>#attributes.member_name#</cfoutput>" autocomplete="off"><div id="member_name_div_2" name="member_name_div_2" class="completeListbox" autocomplete="on" style="width: 428px; max-height: 150px; overflow: auto; position: absolute; left: 467.5px; top: 209px; z-index: 159; display: none;"></div>
                
                <span class="input-group-addon btnPointer icon-ellipsis" onclick="openBoxDraggable('index.cfm?fuseaction=objects.popup_list_all_pars&field_consumer=order_form.consumer_id&field_comp_id=order_form.company_id&field_member_name=order_form.member_name&field_type=order_form.member_type&select_list=7,8&keyword='+encodeURIComponent(document.order_form.member_name.value));"></span>
            </div>
        </div>
    </div>
    <cfquery name="GETD" datasource="#DSN#">
        select * from #dsn#.DEPARTMENT where IS_STORE IN (3,1) AND DEPARTMENT_STATUS=1 
    </cfquery>
   <cfquery name="getrde" datasource="#DSN#">

    SELECT D.DEPARTMENT_HEAD,SL.COMMENT,SL.DEPARTMENT_LOCATION,D.DEPARTMENT_ID
FROM #dsn#.DEPARTMENT AS D
INNER JOIN STOCKS_LOCATION AS SL ON SL.DEPARTMENT_ID=D.DEPARTMENT_ID
WHERE BRANCH_ID IN (
       SELECT D.BRANCH_ID AS B2
       FROM #dsn#.EMPLOYEE_POSITIONS
       INNER JOIN #dsn#.DEPARTMENT AS D2 ON D2.DEPARTMENT_ID = EMPLOYEE_POSITIONS.DEPARTMENT_ID
       WHERE EMPLOYEE_ID = #session.ep.userid#
       ) ORDER BY D.DEPARTMENT_ID
</cfquery>
     <div class="form-group" id="item-company_id">
        <label class="col col-12 col-md-12 col-sm-12 col-xs-12">Teslim Depo</label>							
        <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
            <select name="deliver_dept">
                <option value="">Tümü</option>
                <cfoutput query="getrde" group="DEPARTMENT_ID">
                    <optgroup label="#DEPARTMENT_HEAD#">
                        <cfoutput>
                            <option <cfif attributes.deliver_dept eq DEPARTMENT_LOCATION>selected</cfif> value="#DEPARTMENT_LOCATION#">#COMMENT#</option>
                        </cfoutput>
                    </optgroup>
                </cfoutput>
            </select>
        </div>
    </div>
     <div class="form-group" id="item-company_id">
        <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='57453.Şube'></label>							
        <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
            <select name="Branch" multiple>
              
                <cfoutput query="GETD">
                    <option <cfif listFind(attributes.Branch,DEPARTMENT_ID)>selected</cfif> value="#DEPARTMENT_ID#">#DEPARTMENT_HEAD#</option>
                </cfoutput>
            </select>
        </div>
    </div><!-----
60918 İrsaliye Durumu	
66406	İrsaliyelenmedi
66407	İrsaliyelendi
66408	Açık Sevkiyatlar
        ----->
    <div class="form-group" id="item-company_id">
        <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='66403.Hazırlama Durumu'></label>							
        <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
            <select name="SvkDurum" >
            <option value="">Tümü</option>
            <option <cfif attributes.SvkDurum eq 1>selected</cfif> value="1"><cf_get_lang dictionary_id='39960.Hazırlandı'></option>
            <option <cfif attributes.SvkDurum eq 2>selected</cfif>  value="2"><cf_get_lang dictionary_id='66404.Eksik Hazırlanmış'></option>
            <option <cfif attributes.SvkDurum eq 3>selected</cfif>  value="3"><cf_get_lang dictionary_id='66405.Hazırlanmadı'></option>
            </select>
        </div>
    </div>
    <div class="form-group" id="item-company_id">
        <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='60918.İrsaliye Durumu'></label>							
        <div class="col col-12 col-md-12 col-sm-12 col-xs-12">
            <select name="IrsDurum" >
                <option value=""><cf_get_lang dictionary_id='970.Tümünü Getir'></option>
            <option <cfif attributes.IrsDurum eq 1>selected</cfif>  value="1"><cf_get_lang dictionary_id='66407.İrsaliyelendi'></option>
            <option <cfif attributes.IrsDurum eq 2>selected</cfif> value="2"><cf_get_lang dictionary_id='66409.Eksik Sevkiyatlar'></option>
            <option <cfif attributes.IrsDurum eq 3>selected</cfif> value="3"><cf_get_lang dictionary_id='66408.Açık Sevkiyatlar'></option>
            </select>
        </div>
    </div>
    <div class="form-group" id="item-company_id">
        <label class="col col-12 col-md-12 col-sm-12 col-xs-12"><cf_get_lang dictionary_id='57692.İşlem'></label>							
        <div class="col col-12 col-md-12 col-sm-12 col-xs-12">	
            <select name="FromOrders" >	
                <option value=""><cf_get_lang dictionary_id='970.Tümünü Getir'></option>
            <option <cfif attributes.FromOrders eq 1>selected</cfif>  value="1"><cf_get_lang dictionary_id='31106.Siparişler'></option>
            <option <cfif attributes.FromOrders eq 2>selected</cfif> value="0"><cf_get_lang dictionary_id='30782.İç Talepler'></option>
            
            </select>
        </div>
    </div>
    <input type="hidden" name="is_submit" value="1">
    <input type="submit" value="<cf_get_lang dictionary_id='57565.Ara'>">
</div>
</cfform>
<hr>
<cfif isDefined("attributes.is_submit")>
<cfquery name="getSevkTaleps" datasource="#dsn3#">
    select * from  #DSN3#.LIST_SEVK_TALEP1_#session.EP.PERIOD_YEAR#
    WHERE 1=1
    <cfif isDefined("attributes.member_name") and len(attributes.member_name)>
        <cfif attributes.member_type eq "consumer">
            AND OIS=1
            AND MUSTERI_ID=#attributes.consumer_id#
        <cfelse>
            AND OIS=0
            AND MUSTERI_ID=#attributes.company_id#
        </cfif>
    </cfif>
    <cfif isDefined("attributes.FromOrders") and listLen(attributes.FromOrders)>
        AND FROM_ORDER=#attributes.FromOrders#
    </cfif>
    <cfif isDefined("attributes.Branch") and listLen(attributes.branch)>
            AND MUSTERI_ID IN (#attributes.branch#)
            AND OIS=2
    </cfif>
<cfif isDefined("attributes.SvkDurum") and attributes.SvkDurum eq 1>
    AND HAZ=RCKS
<cfelseif isDefined("attributes.SvkDurum") and  attributes.SvkDurum EQ 2>
    AND HAZ<RCKS
<cfelseif isDefined("attributes.SvkDurum") and  attributes.SvkDurum EQ 3>
  AND  HAZ=0
</cfif>
<cfif isDefined("attributes.IrsDurum") and attributes.IrsDurum eq 1>
    AND IRS=RCKS
<cfelseif isDefined("attributes.IrsDurum") and  attributes.IrsDurum EQ 2>
    AND IRS<RCKS
<cfelseif isDefined("attributes.IrsDurum") and  attributes.IrsDurum EQ 3>
  AND  IRS=0
</cfif>
AND (

FROM_K IN (
SELECT DEPARTMENT_ID
FROM #dsn#.DEPARTMENT AS D
WHERE BRANCH_ID IN (
       SELECT D.BRANCH_ID AS B2
       FROM #dsn#.EMPLOYEE_POSITIONS
       INNER JOIN #dsn#.DEPARTMENT AS D ON D.DEPARTMENT_ID = EMPLOYEE_POSITIONS.DEPARTMENT_ID
       WHERE EMPLOYEE_ID = #session.ep.userid#
       )
)
OR 
TO_K IN (
SELECT DEPARTMENT_ID
FROM #dsn#.DEPARTMENT AS D
WHERE BRANCH_ID IN (
       SELECT D.BRANCH_ID AS B2
       FROM #dsn#.EMPLOYEE_POSITIONS
       INNER JOIN #dsn#.DEPARTMENT AS D ON D.DEPARTMENT_ID = EMPLOYEE_POSITIONS.DEPARTMENT_ID
       WHERE EMPLOYEE_ID = #session.ep.userid#
       )
)
)
<cfif isDefined("attributes.deliver_dept") and len(attributes.deliver_dept)>
    AND DEPARTMENT_ID=#listGetAt(attributes.deliver_dept,1,"-")#
    AND LOCATION_ID=#listGetAt(attributes.deliver_dept,2,"-")#
</cfif>
</cfquery>

</cfif>
<cf_big_list>
    <tr>
        <th>
            <cf_get_lang dictionary_id='57880.Belge No'>
        </th>
        <th>
            <cf_get_lang dictionary_id='57611.Sipariş'> /<cf_get_lang dictionary_id='58798.İç Talep'> <cf_get_lang dictionary_id='57487.No'>
        </th>
        <th>
            <cf_get_lang dictionary_id='57457.Müşteri'>
        </th>
        <th><cf_get_lang dictionary_id='66403.Hazırlama Durumu'></th>
        <th><cf_get_lang dictionary_id='60918.İrsaliye Durumu'></th>
    </tr>
    <cfif isDefined("attributes.is_submit")>
<cfquery name="getrde" datasource="#DSN#">
    SELECT DEPARTMENT_ID
FROM #dsn#.DEPARTMENT AS D
WHERE BRANCH_ID IN (
       SELECT D.BRANCH_ID AS B2
       FROM #dsn#.EMPLOYEE_POSITIONS
       INNER JOIN #dsn#.DEPARTMENT AS D ON D.DEPARTMENT_ID = EMPLOYEE_POSITIONS.DEPARTMENT_ID
       WHERE EMPLOYEE_ID = #session.ep.userid#
       )
</cfquery>
<cfset DDS=valueList(getrde.DEPARTMENT_ID)>
        <cfoutput query="getSevkTaleps">

<tr >
    <td>
        <cfif listFind(DDS,TO_K)><span style="color:red;font-weight:bold">*</span></cfif>
        <!-----<a href="/index.cfm?fuseaction=sales.emptypopup_add_hazirlama&SVK_ID=#SVK_ID#&IS_FROM_ORDER=#FROM_ORDER#&ACTION_ID=#ACTION_ID#">---->#SVK_NUMBER#<!---</a>---->
    </td>
    <td>#ACTION_NUMBER#</td>
    <td>
        <cfif FROM_K neq 0>
            <cfquery name="GETD" datasource="#DSN#">
                SELECT * FROM DEPARTMENT WHERE DEPARTMENT_ID=#FROM_K#
            </cfquery>
            
            #GETD.DEPARTMENT_HEAD# / 
        </cfif>
        #MUSTERI#
    </td>
    <td>
        <CFIF HAZ NEQ 0>
           
            <cfif HAZ eq RCKS>
                <button <cfif listFind(DDS,TO_K) eq 0> onclick="windowopen('/index.cfm?fuseaction=sales.emptypopup_add_hazirlama&SVK_ID=#SVK_ID#&IS_FROM_ORDER=#FROM_ORDER#&ACTION_ID=#ACTION_ID#')"</cfif> class="btn btn-success" style="border-radius: 50% !important;padding: 0;margin: 0;width: 20px;height: 20px;" title="<cf_get_lang dictionary_id='39960.Hazırlandı'>">&nbsp;</button>
            <cfelseif HAZ lt RCKS>
                <button<cfif listFind(DDS,TO_K) eq 0> onclick="windowopen('/index.cfm?fuseaction=sales.emptypopup_add_hazirlama&SVK_ID=#SVK_ID#&IS_FROM_ORDER=#FROM_ORDER#&ACTION_ID=#ACTION_ID#')"</cfif> class="btn btn-warning" style="border-radius: 50% !important;padding: 0;margin: 0;width: 20px;height: 20px;" title="<cf_get_lang dictionary_id='66404.Eksik Hazırlanmış'>">&nbsp;</button>
            <cfelse>
                <button <cfif listFind(DDS,TO_K) eq 0> onclick="windowopen('/index.cfm?fuseaction=sales.emptypopup_add_hazirlama&SVK_ID=#SVK_ID#&IS_FROM_ORDER=#FROM_ORDER#&ACTION_ID=#ACTION_ID#')"</cfif> class="btn btn-dark" style="border-radius: 50% !important;padding: 0;margin: 0;width: 20px;height: 20px;" title="<cf_get_lang dictionary_id='66410.Over Preparation'>">&nbsp;</button>
            </cfif>
        <cfelse>
            <button <cfif listFind(DDS,TO_K) eq 0> onclick="windowopen('/index.cfm?fuseaction=sales.emptypopup_add_hazirlama&SVK_ID=#SVK_ID#&IS_FROM_ORDER=#FROM_ORDER#&ACTION_ID=#ACTION_ID#')"</cfif> class="btn btn-danger" style="border-radius: 50% !important;padding: 0;margin: 0;width: 20px;height: 20px;" title="<cf_get_lang dictionary_id='66405.Hazırlanmadı'>">&nbsp;</button>
        </CFIF>
    </td>
    <td>
        <CFIF IRS NEQ 0>
            <cfif IRS eq RCKS>
                <button <cfif listFind(DDS,TO_K) eq 0></cfif>  class="btn btn-success" style="border-radius: 50% !important;padding: 0;margin: 0;width: 20px;height: 20px;" title="<cf_get_lang dictionary_id='66407.İrsaliyelendi'>">&nbsp;</button>
            <cfelseif IRS lt RCKS>
                <button   class="btn btn-warning" style="border-radius: 50% !important;padding: 0;margin: 0;width: 20px;height: 20px;" <cfif listFind(DDS,TO_K) eq 0>onclick="windowopen('/index.cfm?fuseaction=stock.emptypopup_detail_svk_sevk&ACTION_ID=#ACTION_ID#&IS_FROM_ORDER=#FROM_ORDER#')" </cfif> title="<cf_get_lang dictionary_id='66409.Eksik Sevkiyatlar'>">&nbsp;</button>
            <cfelse>
                <button <cfif listFind(DDS,TO_K) eq 0></cfif>  class="btn btn-dark" style="border-radius: 50% !important;padding: 0;margin: 0;width: 20px;height: 20px;" title="<cf_get_lang dictionary_id='66411.Fazla Sevkiyat'>">&nbsp;</button>
            </cfif>
        <cfelse>
            <button <cfif listFind(DDS,TO_K) eq 0></cfif>  class="btn btn-danger" style="border-radius: 50% !important;padding: 0;margin: 0;width: 20px;height: 20px;" <cfif listFind(DDS,TO_K) eq 0>onclick="windowopen('/index.cfm?fuseaction=stock.emptypopup_detail_svk_sevk&ACTION_ID=#ACTION_ID#&IS_FROM_ORDER=#FROM_ORDER#')"</cfif> title="<cf_get_lang dictionary_id='34107.İrsaliye Ekle'>">&nbsp;</button>
        </CFIF>

        
    </td>
</tr>
</cfoutput>
<cfelse>
    <tr>
        <td colspan="4">	
            <cf_get_lang dictionary_id='63034.Aktif Filtreleme Yapınız'>
        </td>
    </tr>
</cfif>
</cf_big_list>


</cf_box>