

<cfparam name="attributes.pid" default="14">
<cf_box title="Add Feature">
<!---CREATE TABLE 
    #dsn1#.PRODUCT_FEATURES_PARTNER(ID INT PRIMARY KEY IDENTITY(1,1),PRODUCT_ID INT,FEATURE_EN NVARCHAR(MAX),FEATURE_TR NVARCHAR(MAX),ORDER_NUMBER INT)--->
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
    <cfoutput><input type="hidden" name="pid" value="#attributes.pid#"></cfoutput>
    <input type="hidden" name="is_submit">
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        FEATURE (En)
                    </label>
                    <textarea name="FEATURE_EN"></textarea>
                </div>
            </td>
            </tr>
            <tr>
            <td>
                <div class="form-group">
                    <label>
                        FEATURE (Tr)
                    </label>
                    <textarea name="FEATURE_TR"></textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td style="text-align:right">
                <input type="submit" value="Kaydet">
            </td>
        </tr>
    </table>
</cfform>
</cf_box>


<cfif isDefined("attributes.is_submit")>
    <cfquery name="INS" datasource="#DSN1#">
        INSERT INTO PRODUCT_FEATURES_PARTNER (FEATURE_EN,FEATURE_TR,PRODUCT_ID) VALUES ('#attributes.FEATURE_EN#','#attributes.FEATURE_TR#',#attributes.pid#)
    </cfquery>
    <script>
        window.opener.location.reload();
        this.close();
    </script>
</cfif>