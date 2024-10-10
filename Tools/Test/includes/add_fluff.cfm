

<cfparam name="attributes.pid" default="14">
<cf_box title="Add Fluff">
<!---CREATE TABLE catalys_test_product.PRODUCT_FLUFS_PARTNER(ID INT PRIMARY KEY IDENTITY(1,1),PRODUCT_ID INT,FLUFF_EN NVARCHAR(MAX),FLUFF_TR NVARCHAR(MAX),ORDER_NUMBER INT)--->
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
    <cfoutput><input type="hidden" name="pid" value="#attributes.pid#"></cfoutput>
    <input type="hidden" name="is_submit">
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        FLUFF (En)
                    </label>
                    <textarea name="FLUFF_EN"></textarea>
                </div>
            </td>
            </tr>
            <tr>
            <td>
                <div class="form-group">
                    <label>
                        FLUFF (Tr)
                    </label>
                    <textarea name="FLUFF_TR"></textarea>
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
        INSERT INTO PRODUCT_FLUFS_PARTNER (FLUFF_EN,FLUFF_TR,PRODUCT_ID) VALUES ('#attributes.FLUFF_EN#','#attributes.FLUFF_TR#',#attributes.pid#)
    </cfquery>
    <script>
        window.opener.location.reload();
        this.close();
    </script>
</cfif>