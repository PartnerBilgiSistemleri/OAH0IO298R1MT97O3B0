
<cfparam name="attributes.pid" default="14">
<cf_box title="Update Fluff">
    <cfquery name="getFluff" datasource="#DSN1#">
        SELECT * FROM PRODUCT_FLUFS_PARTNER WHERE ID=#attributes.fluff_id#
    </cfquery>
<!---CREATE TABLE catalys_test_product.PRODUCT_FLUFS_PARTNER(ID INT PRIMARY KEY IDENTITY(1,1),PRODUCT_ID INT,FLUFF_EN NVARCHAR(MAX),FLUFF_TR NVARCHAR(MAX),ORDER_NUMBER INT)--->
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" id="frm1">
    <cfoutput><input type="hidden" name="pid" value="#attributes.pid#">
        <input type="hidden" name="fluff_id" value="#attributes.fluff_id#">
    <input type="hidden" name="is_submit" id="is_submit">
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        FLUFF (En)
                    </label>
                    <textarea name="FLUFF_EN">#getFluff.FLUFF_EN#</textarea>
                </div>
            </td>
            </tr>
            <tr>
            <td>
                <div class="form-group">
                    <label>
                        FLUFF (Tr)
                    </label>
                    <textarea name="FLUFF_TR">#getFluff.FLUFF_TR#</textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">
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
        UPDATE PRODUCT_FLUFS_PARTNER 
        SET 
        FLUFF_EN='#attributes.FLUFF_EN#',
        FLUFF_TR='#attributes.FLUFF_TR#'
        WHERE ID=#attributes.fluff_id#
    </cfquery>
    <script>
        window.opener.location.reload();
        this.close();
    </script>
</cfif>
<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 0>
   
    <cfquery name="upd" datasource="#dsn1#">
       Delete From PRODUCT_FLUFS_PARTNER where ID=#attributes.FLUFF_ID# 
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