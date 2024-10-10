<cfif structKeyExists(Urun,"ITEMFEATURES")>
    <cfloop array="#Urun.ITEMFEATURES#" item="it">
 
        
        <cfquery name="INS" datasource="#DSN1#">
            INSERT INTO PRODUCT_FEATURES_PARTNER (FEATURE_EN,
ORDER_NUMBER,
PRODUCT_ID) VALUES ('#it.TEXT#',#it.ID#,#PBS_PRODUCT_ID#)
        </cfquery>

    </cfloop>

</cfif>