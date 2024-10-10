<cfif structKeyExists(Urun,"ITEMFLUFFS")>
    <cfloop array="#Urun.ITEMFLUFFS#" item="it">
 
       
        <cfquery name="INS" datasource="#DSN1#">
            INSERT INTO PRODUCT_FLUFS_PARTNER (FLUFF_EN,
ORDER_NUMBER,
PRODUCT_ID) VALUES ('#it.TEXT#',#it.ID#,#PBS_PRODUCT_ID#)
        </cfquery>

    </cfloop>

</cfif>