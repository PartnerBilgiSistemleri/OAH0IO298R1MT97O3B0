<cfif arrayLen(Urun.ITEMEXTRADIMENSIONS)>
    <cfloop array="#Urun.ITEMEXTRADIMENSIONS#" item="it">
        <cfquery name="ins" datasource="#dsn1#">
            INSERT INTO PRODUCT_EXTRA_DIMENSIONS_PARTNER(STD_EN,MTR_EN,PRODUCT_ID) VALUES('#it.standardDimension#','#it.metricDimension#',#PBS_PRODUCT_ID#)
        </cfquery>
    </cfloop>
</cfif>