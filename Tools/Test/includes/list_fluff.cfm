
<cfparam name="attributes.pid" default="13">
<cfquery name="getfluff" datasource="#DSN1#">
    SELECT * FROM #DSN1#.PRODUCT_FLUFS_PARTNER WHERE PRODUCT_ID=#attributes.pid#
</cfquery>
<cf_box title="Fluffs">
<cf_grid_list>
    <thead>
        <tr>
            <th>
                #
            </th>
            <th>
                Fluff (En)
            </th>
            <th>
                Fluff (Tr)
            </th>
            <th>
                <cfoutput><a onclick="windowopen('/index.cfm?fuseaction=product.emptypopup_add_fluff&pid=#attributes.pid#','list')"><span class="icn-md icon-add"></span></a></cfoutput>
            </th>
        </tr>
    </thead>
    <tbody>
    <cfoutput query="getfluff">
        <tr>
            <td>
                #currentrow#
            </td>
            <td>
                #FLUFF_EN#
            </td>
            <td>
                #FLUFF_TR#
            </td>
            <td>
                <a onclick="windowopen('/index.cfm?fuseaction=product.emptypopup_upd_fluff&pid=#attributes.pid#&fluff_id=#ID#','list')"><span class="icn-md icon-update"></span></a>
            </td>
        </tr>
    </cfoutput>
</tbody>
</cf_grid_list>
</cf_box>