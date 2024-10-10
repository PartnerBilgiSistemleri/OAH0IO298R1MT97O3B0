<cfloop array="#Urun.ITEMCHARACTERISTICS#" item="it">
<cfquery name="insDimensions" datasource="#dsn1#">
    INSERT INTO PRODUCT_DIMENTIONS_PARTNER(
        DEPTH,
        DEPTH_MEASURE,
        HEIGHT,
        HEIGHT_MEASURE,
        P_LENGTH,
        LENGTH_MEASURE,      
        DIMENTION_TYPE,
        PRODUCT_ID
        
    ) values(
        <cfif len(it.ITEMDIMENSIONS.DEPTH.VALUE)>#it.ITEMDIMENSIONS.DEPTH.VALUE#<cfelse>0</cfif>,
        '#it.ITEMDIMENSIONS.DEPTH.UNITOFMEASURE#',

        <cfif len(it.ITEMDIMENSIONS.HEIGHT.VALUE)>#it.ITEMDIMENSIONS.HEIGHT.VALUE#<cfelse>0</cfif>,
        '#it.ITEMDIMENSIONS.HEIGHT.UNITOFMEASURE#',

        <cfif len(it.ITEMDIMENSIONS.LENGTH.VALUE)>#it.ITEMDIMENSIONS.LENGTH.VALUE#<cfelse>0</cfif>,
        '#it.ITEMDIMENSIONS.LENGTH.UNITOFMEASURE#',
        1,
            #PBS_PRODUCT_ID#
        
    )
</cfquery>
</cfloop>

<cfloop array="#Urun.PACKAGECHARACTERISTICS#" item="it">
    <cfquery name="insDimensions" datasource="#dsn1#">
        INSERT INTO PRODUCT_DIMENTIONS_PARTNER(
            DEPTH,
            DEPTH_MEASURE,
            HEIGHT,
            HEIGHT_MEASURE,
            P_LENGTH,
            LENGTH_MEASURE,
            DIMENTION_TYPE,
            PRODUCT_ID
            
        ) values(
            <cfif len(it.PACKAGEDIMENSIONS.DEPTH.VALUE)>#it.PACKAGEDIMENSIONS.DEPTH.VALUE#<cfelse>0</cfif>,
            '#it.PACKAGEDIMENSIONS.DEPTH.UNITOFMEASURE#',
    
            <cfif len(it.PACKAGEDIMENSIONS.HEIGHT.VALUE)>#it.PACKAGEDIMENSIONS.HEIGHT.VALUE#<cfelse>0</cfif>,
            '#it.PACKAGEDIMENSIONS.HEIGHT.UNITOFMEASURE#',
    
            <cfif len(it.PACKAGEDIMENSIONS.LENGTH.VALUE)>#it.PACKAGEDIMENSIONS.LENGTH.VALUE#<cfelse>0</cfif>,
            '#it.PACKAGEDIMENSIONS.LENGTH.UNITOFMEASURE#',
    
            0,
            #PBS_PRODUCT_ID#
            
        )
    </cfquery>
    </cfloop>