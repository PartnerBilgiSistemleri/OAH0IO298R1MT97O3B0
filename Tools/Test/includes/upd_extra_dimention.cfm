
<cfquery name="getdim" datasource="#dsn1#">
    SELECT * FROM PRODUCT_EXTRA_DIMENSIONS_PARTNER WHERE ID=#attributes.extra_id#
</cfquery>
<cfparam name="attributes.pid" default="14">
<cf_box title="Update Extra Dimension">
<!-----CREATE TABLE catalys_test_product.PRODUCT_EXTRA_DIMENSIONS_PARTNER(ID INT PRIMARY KEY IDENTITY(1,1),PRODUCT_ID INT,
    STD_EN NVARCHAR(MAX),STD_TR NVARCHAR(MAX),MTR_EN NVARCHAR(MAX),MTR_TR NVARCHAR(MAX))--->
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" id="frm1">
    <cfoutput><input type="hidden" name="pid" value="#attributes.pid#">
        <input type="hidden" name="extra_id" value="#attributes.extra_id#">
    <input type="hidden" name="is_submit" id="is_submit">
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Std Dimension (En)
                    </label>
                    <textarea name="STD_EN">#getdim.STD_EN#</textarea>
                </div>
            </td>
          
            <td>
                <div class="form-group">
                    <label>
                        Std Dimension (Tr)
                    </label>
                    <textarea name="STD_TR">#getdim.STD_TR#</textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Mtr Dimension (En)
                    </label>
                    <textarea name="MTR_EN">#getdim.MTR_EN#</textarea>
                </div>
            </td>
          
            <td>
                <div class="form-group">
                    <label>
                        Mtr Dimension (Tr)
                    </label>
                    <textarea name="MTR_TR">#getdim.MTR_TR#</textarea>
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
    <cfquery name="INS" datasource="#DSN1#">
        UPDATE  PRODUCT_EXTRA_DIMENSIONS_PARTNER SET 
        STD_EN= '#attributes.STD_EN#',
        STD_TR='#attributes.STD_TR#',
        MTR_EN= '#attributes.MTR_EN#',
        MTR_TR='#attributes.MTR_TR#'
         WHERE ID=#attributes.extra_id#
    </cfquery>
    <script>
        window.opener.location.reload();
        this.close();
    </script>
</cfif>
<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 0>
       
    <cfquery name="upd" datasource="#dsn1#">
        Delete From PRODUCT_EXTRA_DIMENSIONS_PARTNER where ID=#attributes.extra_id# 
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