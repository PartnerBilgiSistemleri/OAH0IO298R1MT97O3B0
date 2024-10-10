<cfparam name="attributes.pid" default="13">
<cfquery name="getCoverInfo" datasource="#DSN1#">
    SELECT * FROM #DSN1#.PRODUCT_COVER_INFOS_PARTNER WHERE PRODUCT_ID=#attributes.pid#
</cfquery>
<cf_box title="Covers">
<cf_grid_list>
    <thead>
        <tr>
            <th>
                #
            </th>
            <th>
                COVER NAME (En)
            </th>
            <th>
                COVER NAME (Tr)
            </th>
            <th>
                COVER LOCATION (En)
            </th>
            <th>
             COVER LOCATION (Tr)
            </th>
            <th>
                COVER CONTENT  (En)
            </th>
            <th>
                COVER CONTENT (Tr)
            </th>
            <th>
                COVER CLEANING CODE (En)
            </th>
            <th>
                COVER CLEANING CODE (Tr)
            </th>
            <th>
                <cfoutput><a onclick="windowopen('/index.cfm?fuseaction=product.emptypopup_add_cover_info&pid=#attributes.pid#','list')"><span class="icn-md icon-add"></span></a></cfoutput>
            </th>
        </tr>
    </thead>
    <cfoutput query="getCoverInfo">
        <tr>
            <td>#currentrow#</td>
            <td>
                #C_NAME_EN#
            </td>
            <td>
                #C_NAME_TR#
            </td>
            <td>
                #C_LOCATION_EN#
            </td>
            <td>
                #C_LOCATION_TR#
            </td>
            <td>
                #C_CONTENT_EN#
            </td>
            <td>
                #C_CONTENT_TR#
            </td>
            <td>
                #C_CLEANING_CODE_EN#
            </td>
            <td>
                #C_CLEANING_CODE_TR#
            </td>
            <td>
                
                <a onclick="windowopen('/index.cfm?fuseaction=product.emptypopup_upd_cover_info&pid=#attributes.pid#&cover_id=#ID#','list')"><span class="icn-md icon-update"></span></a>
            </td>
        </tr>
    </cfoutput>
</cf_grid_list>
</cf_box>