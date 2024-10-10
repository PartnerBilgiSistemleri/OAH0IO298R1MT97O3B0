
<cfparam name="attributes.pid" default="14">
<cfparam name="attributes.feature_id" default="14">
<cfquery name="getFeature" datasource="#dsn1#">
     SELECT * FROM PRODUCT_FEATURES_PARTNER  WHERE PRODUCT_ID=#attributes.PID# AND ID=#attributes.feature_id#
</cfquery>

<cf_box title="Add Feature">
<!---CREATE TABLE 
    #dsn1#.PRODUCT_FEATURES_PARTNER(ID INT PRIMARY KEY IDENTITY(1,1),PRODUCT_ID INT,FEATURE_EN NVARCHAR(MAX),FEATURE_TR NVARCHAR(MAX),ORDER_NUMBER INT)--->
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" id="frm1">
    <cfoutput>
        <input type="hidden" name="pid" value="#attributes.pid#">
        <input type="hidden" name="feature_id" value="#attributes.feature_id#">
    <input type="hidden" name="is_submit" id="is_submit">
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        FEATURE (En)
                    </label>
                    <textarea name="FEATURE_EN" style="text-align:left">#getFeature.FEATURE_EN#</textarea>
                </div>
            </td>
            </tr>
            <tr>
            <td>
                <div class="form-group">
                    <label>
                        FEATURE (Tr)
                    </label>
                    <textarea name="FEATURE_TR">#getFeature.FEATURE_TR#</textarea>
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
   
    <cfquery name="upd" datasource="#dsn1#">
        UPDATE PRODUCT_FEATURES_PARTNER SET FEATURE_EN='#attributes.FEATURE_EN#',FEATURE_TR='#attributes.FEATURE_TR#' where ID=#attributes.FEATURE_ID#
    </cfquery>
<script>
    window.opener.location.reload();
    this.close();
</script>
</cfif>

<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 0>
   
    <cfquery name="upd" datasource="#dsn1#">
       Delete From PRODUCT_FEATURES_PARTNER where ID=#attributes.FEATURE_ID# 
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