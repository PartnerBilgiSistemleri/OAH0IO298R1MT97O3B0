<cfparam name="attributes.pid" default="10">
<cfquery name="getExtraDimention" datasource="#DSN1#">
    SELECT * FROM #DSN1#.PRODUCT_EXTRA_DIMENSIONS_PARTNER WHERE PRODUCT_ID=#attributes.pid#
</cfquery>
<cf_box title="Extra Dimensions">
<cf_grid_list>

    <thead>
        <tr>
            <th>
                #
            </th>
            <th>
                STD DIMENSION (En)
            </th>
            <th>
                STD DIMENSION (Tr)
            </th>
            <th>
                MTR DIMENSION (En)
            </th>
            <th>
                MTR DIMENSION (Tr)
            </th>
            <th>
                <cfoutput><a onclick="windowopen('/index.cfm?fuseaction=product.emptypopup_add_extra_dimension&pid=#attributes.pid#','list')"><span class="icn-md icon-add"></span></a></cfoutput>
            </th>
        </tr>
    </thead>
    <tbody>
    <cfoutput query="getExtraDimention">
        <tr>
            <td>#currentrow#</td>
            <td>
                #STD_EN#
            </td>
            <td>
                #STD_TR#
            </td>
            <td>
                #MTR_EN#
            </td>
            <td>
                #MTR_TR#
            </td>
            <td>
                
                <a onclick="windowopen('/index.cfm?fuseaction=product.emptypopup_upd_extra_dimension&pid=#attributes.pid#&extra_id=#ID#','list')"><span class="icn-md icon-update"></span></a>
            </td>
        </tr>
    </cfoutput>
</tbody>
</cf_grid_list>
</cf_box>