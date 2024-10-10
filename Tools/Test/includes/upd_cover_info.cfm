


<cfquery name="getCover" datasource="#dsn1#">
        SELECT * FROM PRODUCT_COVER_INFOS_PARTNER WHERE ID=#attributes.cover_id#
</cfquery>


<cfparam name="attributes.pid" default="14">
<cf_box title="Update Cover">
<!-----CREATE TABLE catalys_test_product.PRODUCT_COVER_INFOS_PARTNER(ID INT PRIMARY KEY IDENTITY(1,1),PRODUCT_ID INT,C_NAME_EN NVARCHAR(MAX),C_NAME_TR NVARCHAR(MAX),
    C_LOCATION_EN NVARCHAR(MAX),C_LOCATION_TR NVARCHAR(MAX),C_CONTENT_EN NVARCHAR(MAX),C_CONTENT_TR NVARCHAR(MAX),C_CLEANING_CODE_EN NVARCHAR(MAX),C_CLEANING_CODE_TR NVARCHAR(MAX)------>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" id="frm1">
    <cfoutput><input type="hidden" name="pid" value="#attributes.pid#">
        <input type="hidden" name="cover_id" value="#attributes.cover_id#">
    <input type="hidden" name="is_submit" id="is_submit">
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Cover Name (En)
                    </label>
                    <textarea name="C_NAME_EN">#getCover.C_NAME_EN#</textarea>
                </div>
            </td>
           
            <td>
                <div class="form-group">
                    <label>
                        Cover Name (Tr)
                    </label>
                    <textarea name="C_NAME_TR">#getCover.C_NAME_EN#</textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Cover Location (En)
                    </label>
                    <textarea name="C_LOCATION_EN">#getCover.C_LOCATION_EN#</textarea>
                </div>
            </td>
           
            <td>
                <div class="form-group">
                    <label>
                        Cover Location (Tr)
                    </label>
                    <textarea name="C_LOCATION_TR">#getCover.C_LOCATION_TR#</textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Cover Content (En)
                    </label>
                    <textarea name="C_CONTENT_EN">#getCover.C_CONTENT_EN#</textarea>
                </div>
            </td>
           
            <td>
                <div class="form-group">
                    <label>
                        Cover Content (Tr)
                    </label>
                    <textarea name="C_CONTENT_TR">#getCover.C_CONTENT_TR#</textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Cover Cleaning Code (En)
                    </label>
                    <textarea name="C_CLEANING_CODE_EN">#getCover.C_CLEANING_CODE_EN#</textarea>
                </div>
            </td>
           
            <td>
                <div class="form-group">
                    <label>
                        Cover Cleaning Code (Tr)
                    </label>
                    <textarea name="C_CLEANING_CODE_TR">#getCover.C_CLEANING_CODE_TR#</textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:right">
                <button class=" ui-wrk-btn ui-wrk-btn-red" onclick="islemYap(0)">Sil</button>
                <button class=" ui-wrk-btn ui-wrk-btn-success" onclick="islemYap(1)" >Güncelle</button>
            </td>
        </tr>
    </table>
</cfoutput>
</cfform>
</cf_box>


<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 1>
    <cfquery name="upod" datasource="#dsn1#">
    UPDATE 
     PRODUCT_COVER_INFOS_PARTNER SET
    C_NAME_EN= '#attributes.C_NAME_EN#',
    C_NAME_TR='#attributes.C_NAME_TR#',
    C_LOCATION_EN='#attributes.C_LOCATION_EN#',
    C_LOCATION_TR='#attributes.C_LOCATION_TR#',
    C_CONTENT_EN='#attributes.C_CONTENT_EN#',
    C_CONTENT_TR='#attributes.C_CONTENT_TR#',
    C_CLEANING_CODE_EN='#attributes.C_CLEANING_CODE_EN#',
    C_CLEANING_CODE_TR='#attributes.C_CLEANING_CODE_TR#'
    where ID=#attributes.cover_id# 
</cfquery>
    <script>
        window.opener.location.reload();
        this.close();
    </script>
</cfif>

<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 0>
       
    <cfquery name="upd" datasource="#dsn1#">
        Delete From PRODUCT_COVER_INFOS_PARTNER where ID=#attributes.cover_id# 
     </cfquery>

    
    <script>
        window.opener.location.reload();
        this.close();
    </script>
</cfif>


<script>
    function islemYap(iid){
        $("#is_submit").val(iid)
        $("#frm1").submit();
    }
</script>