<cfif  arrayLen(Urun.COVERINFORMATIONS)>
    <cfloop array="#Urun.COVERINFORMATIONS#" item="it">
    <cfquery name="ins" datasource="#dsn1#">
        INSERT INTO PRODUCT_COVER_INFOS_PARTNER (C_NAME_EN,
C_LOCATION_EN,
C_CONTENT_EN,
C_CLEANING_CODE_EN,
PRODUCT_ID) VALUES (
    '#it.coverName#',
    '#it.coverLocation#',
    '#it.coverContent#',
    '#it.coverCleaningCode#',
    #PBS_PRODUCT_ID#
)
    </cfquery>
</cfloop>
</cfif>


