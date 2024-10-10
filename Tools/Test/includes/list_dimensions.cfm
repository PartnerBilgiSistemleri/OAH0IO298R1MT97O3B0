<cfparam name="attributes.pid" default="10">
<cfquery name="getExtraDimention" datasource="#DSN1#">
    SELECT DEPTH,DEPTH_MEASURE,HEIGHT,HEIGHT_MEASURE,P_LENGTH,LENGTH_MEASURE,VOLUME,
    VOLUME_MEASURE,P_WEIGHT,WEIGHT_MEASURE,DIMENTION_TYPE FROM PRODUCT_DIMENTIONS_PARTNER
    WHERE PRODUCT_ID=#attributes.pid#
</cfquery>
<cf_box title="Extra Dimensions">
<cf_grid_list>

    <thead>
        <tr>
            <th>
                #
            </th>
            <th>
                DEPTH 
            </th>
            <th>
                HEIGHT 
            </th>
            <th>
                P_LENGTH 
            </th>
            <th>
                VOLUME 
            </th>
            <th>
                P_WEIGHT 
            </th>
            <th>
                Ölçü Tipi
            </th>
            <th>
                
            </th>
        </tr>
    </thead>
    <tbody>
    <cfoutput query="getExtraDimention">
        <tr>
            <td>#currentrow#</td>
            <td>
                #DEPTH# #DEPTH_MEASURE#
            </td>
            <td>
                #HEIGHT# #HEIGHT_MEASURE#
            </td>
            <td>
                #P_LENGTH# #LENGTH_MEASURE#
            </td>
            <td>
                #VOLUME# #VOLUME_MEASURE#
            </td>
            <td>
                #P_WEIGHT# #WEIGHT_MEASURE#
            </td>
            <td>
                <cfif DIMENTION_TYPE eq 0>
                    Paket
                <cfelse>
                    Ürün
                </cfif>
            </td>
            <td>                
                <!---<a onclick="windowopen('/index.cfm?fuseaction=product.emptypopup_upd_extra_dimension&pid=#attributes.pid#&extra_id=#ID#','list')"><span class="icn-md icon-update"></span></a>---->
            </td>
        </tr>
    </cfoutput>
</tbody>
</cf_grid_list>
</cf_box>