

<cfparam name="attributes.pid" default="14">
<cfquery name="getFeatures" datasource="#dsn1#">
    SELECT * FROM PRODUCT_FEATURES_PARTNER  WHERE PRODUCT_ID=#attributes.PID#
</cfquery>
<cf_box title="Features">
<cf_grid_list>
    <thead>
        <tr>
            <th>
                #
            </th>
            <th>
                FEATURE (En)
            </th>
            <th>
                FEATURE (Tr)
            </th>
            <th>
              <cfoutput><a onclick="windowopen('/index.cfm?fuseaction=product.emptypopup_add_feature&pid=#attributes.pid#','list')"><span class="icn-md icon-add"></span></a></cfoutput>
            </th>
        </tr>
    </thead>
    <tbody>
<cfoutput query="getFeatures">
<tr>
    <td>#currentrow#</td>
    <td>
       #FEATURE_EN# 
    </td>
    <td>
        #FEATURE_TR#
    </td>
    <td>
        
        <a onclick="windowopen('/index.cfm?fuseaction=product.emptypopup_upd_feature&feature_id=#ID#&pid=#attributes.pid#','list')"><span class="icn-md icon-update"></span></a>
    </td>
</tr>
</cfoutput>
</tbody>
</cf_grid_list>
</cf_box>