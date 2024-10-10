

<cfparam name="attributes.pid" default="14">
<cf_box title="Add Cover">
<!-----CREATE TABLE catalys_test_product.PRODUCT_COVER_INFOS_PARTNER(ID INT PRIMARY KEY IDENTITY(1,1),PRODUCT_ID INT,C_NAME_EN NVARCHAR(MAX),C_NAME_TR NVARCHAR(MAX),
    C_LOCATION_EN NVARCHAR(MAX),C_LOCATION_TR NVARCHAR(MAX),C_CONTENT_EN NVARCHAR(MAX),C_CONTENT_TR NVARCHAR(MAX),C_CLEANING_CODE_EN NVARCHAR(MAX),C_CLEANING_CODE_TR NVARCHAR(MAX)------>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
    <cfoutput><input type="hidden" name="pid" value="#attributes.pid#"></cfoutput>
    <input type="hidden" name="is_submit">
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Cover Name (En)
                    </label>
                    <textarea name="C_NAME_EN"></textarea>
                </div>
            </td>
           
            <td>
                <div class="form-group">
                    <label>
                        Cover Name (Tr)
                    </label>
                    <textarea name="C_NAME_TR"></textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Cover Location (En)
                    </label>
                    <textarea name="C_LOCATION_EN"></textarea>
                </div>
            </td>
           
            <td>
                <div class="form-group">
                    <label>
                        Cover Location (Tr)
                    </label>
                    <textarea name="C_LOCATION_TR"></textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Cover Content (En)
                    </label>
                    <textarea name="C_CONTENT_EN"></textarea>
                </div>
            </td>
           
            <td>
                <div class="form-group">
                    <label>
                        Cover Content (Tr)
                    </label>
                    <textarea name="C_CONTENT_TR"></textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Cover Cleaning Code (En)
                    </label>
                    <textarea name="C_CLEANING_CODE_EN"></textarea>
                </div>
            </td>
           
            <td>
                <div class="form-group">
                    <label>
                        Cover Cleaning Code (Tr)
                    </label>
                    <textarea name="C_CLEANING_CODE_TR"></textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:right">
                <input type="submit" value="Kaydet">
            </td>
        </tr>
    </table>
</cfform>
</cf_box>


<cfif isDefined("attributes.is_submit")>
    
            <cfquery name="ins" datasource="#dsn1#">
        INSERT INTO PRODUCT_COVER_INFOS_PARTNER (
            C_NAME_EN,C_NAME_TR,
            C_LOCATION_EN,C_LOCATION_TR,
            C_CONTENT_EN,C_CONTENT_TR,
            C_CLEANING_CODE_EN,C_CLEANING_CODE_TR,
            PRODUCT_ID
            ) VALUES (
    '#attributes.C_NAME_EN#',
    '#attributes.C_NAME_TR#',
    '#attributes.C_LOCATION_EN#',
    '#attributes.C_LOCATION_TR#',
    '#attributes.C_CONTENT_EN#',
    '#attributes.C_CONTENT_TR#',
    '#attributes.C_CLEANING_CODE_EN#',
    '#attributes.C_CLEANING_CODE_TR#',
    #attributes.pid#
)
    </cfquery>
    
    <script>
        window.opener.location.reload();
        this.close();
    </script>
</cfif>