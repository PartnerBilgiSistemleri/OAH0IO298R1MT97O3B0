<cfset Uri_1="https://www.ashleydirect.com/Graphics/">
<cfset Uri_2="https://www.ashleydirect.com/Graphics/ad_images/">
<cfif isDefined("Urun.IMAGE")>
<cfset str=Urun.IMAGE.URL>
<cfif len(str) gt 0>
    
<cfset Uri_1="#Uri_1##str#">
<cfset str=replace(str,"_BIG","")>
<cfset str=replace(str,"_MED","")>
<cfset Uri_2="#Uri_2##str#">


<cfquery name="ins" datasource="#dsn1#">

    INSERT INTO #dsn1#.PRODUCT_IMAGES (
    PRODUCT_ID,IMAGE_SIZE,IS_INTERNET,IS_EXTERNAL_LINK,VIDEO_PATH,PRD_IMG_NAME,VIDEO_LINK
    ) VALUES (
        #Urun.URUN_ID#,0,1,1,'#Uri_1#','#Urun.IMAGE.NAME#',0
    )
    </cfquery>

<cfquery name="ins" datasource="#dsn1#">

    INSERT INTO #dsn1#.PRODUCT_IMAGES (
    PRODUCT_ID,IMAGE_SIZE,IS_INTERNET,IS_EXTERNAL_LINK,VIDEO_PATH,PRD_IMG_NAME,VIDEO_LINK
    ) VALUES (
        #Urun.URUN_ID#,0,1,1,'#Uri_2#','#Urun.IMAGE.NAME#_2',0
    )
    </cfquery>
</cfif>




</cfif>