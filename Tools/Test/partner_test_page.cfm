<cfif attributes.page eq 1>
    <cfinclude template="includes/xml_importer.cfm">
<cfelseif attributes.page eq 2>
    <cfinclude template="includes/list_feature.cfm">
<cfelseif  attributes.page eq 3>
    <cfinclude template="includes/list_cover_info.cfm">
<cfelseif  attributes.page eq 4>
    <cfinclude template="includes/list_extra_dimention.cfm">
<cfelseif attributes.page eq 5>
    <cfinclude template="includes/list_fluff.cfm">
<cfelseif attributes.page eq 6>
<cfinclude template="includes/list_dimensions.cfm">
<cfelseif  attributes.page eq 7>
    <cfinclude template="includes/excell_aktarim.cfm">
<cfelseif attributes.page eq 8>
    <cfinclude template="includes/fatgun.cfm">
<cfelseif  attributes.page eq 9>
    <cfinclude template="includes/OzelIskontoImport.cfm">
<cfelseif attributes.page eq 10>
    <cfinclude template="includes/faturabagla.cfm">
<cfelseif attributes.page eq 11>
    <cfinclude template="includes/sayim_sifirlayici.cfm">
</cfif>