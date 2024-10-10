

<cfparam name="attributes.pid" default="14">
<cf_box title="Add Extra Dimension">
<!-----CREATE TABLE catalys_test_product.PRODUCT_EXTRA_DIMENSIONS_PARTNER(ID INT PRIMARY KEY IDENTITY(1,1),PRODUCT_ID INT,
    STD_EN NVARCHAR(MAX),STD_TR NVARCHAR(MAX),MTR_EN NVARCHAR(MAX),MTR_TR NVARCHAR(MAX))--->
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
    <cfoutput><input type="hidden" name="pid" value="#attributes.pid#"></cfoutput>
    <input type="hidden" name="is_submit">
    <table>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Std Dimension (En)
                    </label>
                    <textarea name="STD_EN"></textarea>
                </div>
            </td>
          
            <td>
                <div class="form-group">
                    <label>
                        Std Dimension (Tr)
                    </label>
                    <textarea name="STD_TR"></textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="form-group">
                    <label>
                        Mtr Dimension (En)
                    </label>
                    <textarea name="MTR_EN"></textarea>
                </div>
            </td>
          
            <td>
                <div class="form-group">
                    <label>
                        Mtr Dimension (Tr)
                    </label>
                    <textarea name="MTR_TR"></textarea>
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
        INSERT INTO PRODUCT_EXTRA_DIMENSIONS_PARTNER (STD_EN,STD_TR,MTR_EN,MTR_TR,PRODUCT_ID) VALUES ('#attributes.STD_EN#','#attributes.STD_TR#',
        '#attributes.MTR_EN#','#attributes.MTR_TR#',#attributes.pid#)
    </cfquery>
    <script>
        window.opener.location.reload();
        this.close();
    </script>
</cfif>