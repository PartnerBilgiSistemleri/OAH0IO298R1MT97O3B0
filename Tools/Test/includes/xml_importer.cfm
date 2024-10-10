<cfsetting 

requestTimeOut = "0"
>

<cfoutput>
    #expandPath(".\Addons\Partner\Test\includes\")#
    #expandPath(".\PRODUCT_XML_FOLDER")#
    #now()#
</cfoutput>


<cffile action="read" file="#expandPath(".\PRODUCT_XML_FOLDER")#\urun_aktarim.xml" variable="xmlfile">

<cfset xmlDoc=xmlParse(xmlfile)>



<cfset items=xmlDoc.itemAlignment.items.XmlChildren>

array="#items#" index="i" item="Aitem"

<cfset UrunListesi=arrayNew(1)>

<cfloop from="1" to="#arrayLen(items)#" index="i">
    <cfset Aitem=items[i]>
   
  <cfset Urun=structNew()>
<cfscript>
    if(isDefined("Aitem.XmlAttributes.harmonizationCode")){
    Urun.harmonizationCode=Aitem.XmlAttributes.harmonizationCode; 
 }else{
        Urun.harmonizationCode="";
    }
    Urun.itemClass=Aitem.XmlAttributes.itemClass;  
    Urun.itemColor=Aitem.XmlAttributes.itemColor;  
    Urun.itemGroupCode=Aitem.XmlAttributes.itemGroupCode;  
    Urun.itemIsAvailable=Aitem.XmlAttributes.itemIsAvailable;  
    Urun.itemIsExpressShipEligible=Aitem.XmlAttributes.itemIsExpressShipEligible;  
    Urun.itemIsPackage=Aitem.XmlAttributes.itemIsPackage;  
    Urun.itemStatus=Aitem.XmlAttributes.itemStatus;  
    Urun.itemStatusDate=Aitem.XmlAttributes.itemStatusDate;  
    Urun.itemType=Aitem.XmlAttributes.itemType;  
    
    
    if (structKeyExists(Aitem.XmlAttributes,"itemsPerCase") ){
        Urun.itemsPerCase=Aitem.XmlAttributes.itemsPerCase;
    }else{
        Urun.itemsPerCase="";
    }
    Urun.retailSalesCategory=Aitem.XmlAttributes.retailSalesCategory; 
    if (structKeyExists(Aitem.XmlAttributes,"itemMfgWarrantyDays") ){
        Urun.itemMfgWarrantyDays=Aitem.XmlAttributes.itemMfgWarrantyDays;
    }else{
        Urun.itemMfgWarrantyDays="";
    }

    if (structKeyExists(Aitem.XmlAttributes,"chairQtyPerCarton") ){
        Urun.chairQtyPerCarton=Aitem.XmlAttributes.chairQtyPerCarton;
    }else{
        Urun.chairQtyPerCarton="";
    }

    if (structKeyExists(Aitem.XmlAttributes,"seatCount") ){
        Urun.seatCount=Aitem.XmlAttributes.seatCount;
    }else{
        Urun.seatCount="";
    }
</cfscript>
<cfset Aitem_Identification=Aitem.itemIdentification>
<cfset ItemIdentifiers=arrayFilter(Aitem_Identification.XmlChildren,function(item){
    return item.XmlName=="itemIdentifier"
})>
<cfset identfierArr=arrayNew(1)>
<cfloop from="1" to="#arrayLen(ItemIdentifiers)#" index="j">
    <cfset ii=structNew()>
    <cfset ii.itemNumber=ItemIdentifiers[j].XmlAttributes.itemNumber>
    <cfset ii.itemNumberQualifier=ItemIdentifiers[j].XmlAttributes.itemNumberQualifier>
    <cfscript>
        arrayAppend(identfierArr,ii);
    </cfscript>
</cfloop>
<cfset Urun.itemIdentifiers=identfierArr>
<cfset itemDescriptionArr=arrayFilter(Aitem_Identification.XmlChildren,function(item){
    return item.XmlName=="itemDescription"
})>
<cfset descriptionrArr=arrayNew(1)>
<cfloop from="1" to="#arrayLen(itemDescriptionArr)#" index="j">
    <cfset iii=structNew()>
    <cfset iii.descriptionValue=itemDescriptionArr[j].XmlAttributes.descriptionValue>
    <cfset iii.itemDescriptionClassification=itemDescriptionArr[j].XmlAttributes.itemDescriptionClassification>
    <cfset iii.itemDescriptionQualifier=itemDescriptionArr[j].XmlAttributes.itemDescriptionQualifier>
    <cfscript>
        arrayAppend(descriptionrArr,iii);
    </cfscript>
</cfloop>
<cfset Urun.itemDescriptions=descriptionrArr>

<cfset itemCharacteristicsArr=arrayFilter(Aitem_Identification.XmlChildren,function(item){
    return item.XmlName=="itemCharacteristics"
})>

<cfset characteristicArr=arrayNew(1)>
<cfloop from="1" to="#arrayLen(itemCharacteristicsArr)#" index="j">
    <cfset iii=structNew()>
    <CFSET iii.itemUnits.unitOfMeasure=itemCharacteristicsArr[j].itemUnits.XmlAttributes.unitOfMeasure>
    <CFSET iii.itemUnits.value=itemCharacteristicsArr[j].itemUnits.XmlAttributes.value>
    <CFSET iii.itemUnitDescription=itemCharacteristicsArr[j].itemUnitDescription.XmlText>
    <cfif structKeyExists(itemCharacteristicsArr[j],"itemDimensions")>
        <cfif structKeyExists(itemCharacteristicsArr[j].itemDimensions,"depth")>
            <CFSET iii.itemDimensions.depth.unitOfMeasure=itemCharacteristicsArr[j].itemDimensions.depth.XmlAttributes.unitOfMeasure>
            <CFSET iii.itemDimensions.depth.value=itemCharacteristicsArr[j].itemDimensions.depth.XmlAttributes.value>
        <cfelse>
            <CFSET iii.itemDimensions.depth.unitOfMeasure="">
            <CFSET iii.itemDimensions.depth.value="">
        </cfif>
        <cfif structKeyExists(itemCharacteristicsArr[j].itemDimensions,"height")>
            <CFSET iii.itemDimensions.height.unitOfMeasure=itemCharacteristicsArr[j].itemDimensions.height.XmlAttributes.unitOfMeasure>
            <CFSET iii.itemDimensions.height.value=itemCharacteristicsArr[j].itemDimensions.height.XmlAttributes.value>
        <cfelse>
            <CFSET iii.itemDimensions.height.unitOfMeasure="">
            <CFSET iii.itemDimensions.height.value="">
        </cfif>
        <cfif structKeyExists(itemCharacteristicsArr[j].itemDimensions,"length")>
            <CFSET iii.itemDimensions.length.unitOfMeasure=itemCharacteristicsArr[j].itemDimensions.length.XmlAttributes.unitOfMeasure>
            <CFSET iii.itemDimensions.length.value=itemCharacteristicsArr[j].itemDimensions.length.XmlAttributes.value>
        <cfelse>
            <CFSET iii.itemDimensions.length.unitOfMeasure="">
            <CFSET iii.itemDimensions.length.value="">
        </cfif>
    <cfelse>
        <CFSET iii.itemDimensions.length.unitOfMeasure="">
        <CFSET iii.itemDimensions.length.value="0">
        <CFSET iii.itemDimensions.height.unitOfMeasure="">
        <CFSET iii.itemDimensions.height.value="0">
        <CFSET iii.itemDimensions.depth.unitOfMeasure="">
        <CFSET iii.itemDimensions.depth.value="0">
    </cfif>
   <!------ <cfset iii.unitOfMeasure=itemCharacteristicsArr[j].itemUnits.XmlAttributes.unitOfMeasure>
    <cfset iii.value=itemCharacteristicsArr[j].itemUnits.XmlAttributes.value>
    <cfset iii.itemUnitDescription=itemCharacteristicsArr[j].itemUnitDescription.XmlText>
    <cfif structKeyExists(itemCharacteristicsArr[j],"itemDimensions")>
    <cfset iii.itemUnitDescription.measures.unitOfMeasure=itemCharacteristicsArr[j].itemDimensions.depth.XmlAttributes.unitOfMeasure>
    <cfset iii.itemUnitDescription.itemDimensions.depth=itemCharacteristicsArr[j].itemDimensions.depth.XmlAttributes.value>
    <cfset iii.itemUnitDescription.itemDimensions.height=itemCharacteristicsArr[j].itemDimensions.height.XmlAttributes.value>
    <cfset iii.itemUnitDescription.itemDimensions.length=itemCharacteristicsArr[j].itemDimensions.length.XmlAttributes.value>
    </cfif>
    ----->
    <cfscript>
        arrayAppend(characteristicArr,iii);
    </cfscript>
    
</cfloop>
<cfset Urun.itemCharacteristics=characteristicArr>

    <cfset itemPackageCharacteristicsArr=arrayFilter(Aitem_Identification.XmlChildren,function(item){
        return item.XmlName=="packageCharacteristics"
    })>
    
    <cfset PackageCharacteristicsArr=arrayNew(1)>
    <cfloop from="1" to="#arrayLen(itemPackageCharacteristicsArr)#" index="j">
        <cfset iii=structNew()>
        <CFSET iii.packageUnits.unitOfMeasure=itemPackageCharacteristicsArr[j].packageUnits.XmlAttributes.unitOfMeasure>
        <CFSET iii.packageUnits.value=itemPackageCharacteristicsArr[j].packageUnits.XmlAttributes.value>
        <CFSET iii.packageUnitDescription=itemPackageCharacteristicsArr[j].packageUnitDescription.XmlText>
        <cfif structKeyExists(itemPackageCharacteristicsArr[j],"packageDimensions")>
            <cfif structKeyExists(itemPackageCharacteristicsArr[j].packageDimensions,"depth")>
                <CFSET iii.packageDimensions.depth.unitOfMeasure=itemPackageCharacteristicsArr[j].packageDimensions.depth.XmlAttributes.unitOfMeasure>
                <CFSET iii.packageDimensions.depth.value=itemPackageCharacteristicsArr[j].packageDimensions.depth.XmlAttributes.value>
            <cfelse>
                <CFSET iii.packageDimensions.depth.unitOfMeasure="">
                <CFSET iii.packageDimensions.depth.value="">
            </cfif>
            <cfif structKeyExists(itemPackageCharacteristicsArr[j].packageDimensions,"height")>
                <CFSET iii.packageDimensions.height.unitOfMeasure=itemPackageCharacteristicsArr[j].packageDimensions.height.XmlAttributes.unitOfMeasure>
                <CFSET iii.packageDimensions.height.value=itemPackageCharacteristicsArr[j].packageDimensions.height.XmlAttributes.value>
            <cfelse>
                <CFSET iii.packageDimensions.height.unitOfMeasure="">
                <CFSET iii.packageDimensions.height.value="">
            </cfif>
            <cfif structKeyExists(itemPackageCharacteristicsArr[j].packageDimensions,"length")>
                <CFSET iii.packageDimensions.length.unitOfMeasure=itemPackageCharacteristicsArr[j].packageDimensions.length.XmlAttributes.unitOfMeasure>
                <CFSET iii.packageDimensions.length.value=itemPackageCharacteristicsArr[j].packageDimensions.length.XmlAttributes.value>
            <cfelse>
                <CFSET iii.packageDimensions.length.unitOfMeasure="">
                <CFSET iii.packageDimensions.length.value="">
            </cfif>
            <cfif structKeyExists(itemPackageCharacteristicsArr[j].packageDimensions,"volume")>
                <CFSET iii.packageDimensions.volume.unitOfMeasure=itemPackageCharacteristicsArr[j].packageDimensions.volume.XmlAttributes.unitOfMeasure>
                <CFSET iii.packageDimensions.volume.value=itemPackageCharacteristicsArr[j].packageDimensions.volume.XmlAttributes.value>
            <cfelse>
                <CFSET iii.packageDimensions.volume.unitOfMeasure="">
                <CFSET iii.packageDimensions.volume.value="">
            </cfif>
            <cfif structKeyExists(itemPackageCharacteristicsArr[j].packageDimensions,"weight")>
                <CFSET iii.packageDimensions.weight.unitOfMeasure=itemPackageCharacteristicsArr[j].packageDimensions.weight.XmlAttributes.unitOfMeasure>
                <CFSET iii.packageDimensions.weight.value=itemPackageCharacteristicsArr[j].packageDimensions.weight.XmlAttributes.value>
            <cfelse>
                <CFSET iii.packageDimensions.weight.unitOfMeasure="">
                <CFSET iii.packageDimensions.weight.value="">
            </cfif>
        <cfelse>
            <CFSET iii.packageDimensions.length.unitOfMeasure="">
            <CFSET iii.packageDimensions.length.value="0">
            <CFSET iii.packageDimensions.height.unitOfMeasure="">
            <CFSET iii.packageDimensions.height.value="0">
            <CFSET iii.packageDimensions.depth.unitOfMeasure="">
            <CFSET iii.packageDimensions.depth.value="0">
            <CFSET iii.packageDimensions.weight.unitOfMeasure="">
            <CFSET iii.packageDimensions.weight.value="0">
            <CFSET iii.packageDimensions.volume.unitOfMeasure="">
            <CFSET iii.packageDimensions.volume.value="0">
        </cfif>
        <cfscript>
            arrayAppend(PackageCharacteristicsArr,iii);
        </cfscript>
        
    </cfloop>
    <cfset Urun.packageCharacteristics=PackageCharacteristicsArr>
   
<cfif isDefined("Aitem.image.XmlAttributes.name")>
<cfset Urun.image.name=Aitem.image.XmlAttributes.name>
<cfelse>
    <cfset Urun.image.name="">
</cfif>
<cfif isDefined("Aitem.image.XmlAttributes.quality")>
<cfset Urun.image.quality=Aitem.image.XmlAttributes.quality>
<cfelse>
    <cfset Urun.image.quality="">
</cfif>
<cfif isDefined("Aitem.image.XmlAttributes.quality")>
<cfset Urun.image.url=Aitem.image.XmlAttributes.url>
<cfelse>
    <cfset Urun.image.url="">
</cfif>


<cfif isDefined("Aitem.referenceDocument")>
<cfset Urun.referenceDocument.name=Aitem.referenceDocument.XmlAttributes.name>
<cfset Urun.referenceDocument.referenceDocumentQualifier=Aitem.referenceDocument.XmlAttributes.referenceDocumentQualifier>
<cfset Urun.referenceDocument.url=Aitem.referenceDocument.XmlAttributes.url>
<cfelse>
    <cfset Urun.referenceDocument.name="">
    <cfset Urun.referenceDocument.referenceDocumentQualifier="">
    <cfset Urun.referenceDocument.url="" >
</cfif>
<cfset featureArr=arrayNew(1)>
<cfif isDefined("Aitem.itemFeatures")>

<cfset featurees=Aitem.itemFeatures.XmlChildren>
<cfloop from="1" to="#arrayLen(featurees)#" index="j">
    <cfset ii=structNew()>
    <cfset ii.ID=featurees[j].XmlAttributes.id>
    <cfset ii.Text=featurees[j].XmlText>
    <cfscript>
        arrayAppend(featureArr,ii);
    </cfscript>  
</cfloop>
<cfset  Urun.itemFeatures=featureArr>
<cfelse>
    <cfset  Urun.itemFeatures=featureArr>
</cfif>
<cfset fluffArr=arrayNew(1)>
<cfif isDefined("Aitem.itemFluffs")>
    
    <cfset fluuufes=Aitem.itemFluffs.XmlChildren>
    
    <cfloop from="1" to="#arrayLen(fluuufes)#" index="j">
        <cfset ii=structNew()>
        <cfset ii.ID=fluuufes[j].XmlAttributes.id>
        <cfset ii.Text=fluuufes[j].XmlText>
        <cfscript>
            arrayAppend(fluffArr,ii);
        </cfscript> 
    </cfloop>
    <cfset  Urun.itemFluffs=fluffArr>
<cfelse>
    <cfset  Urun.itemFluffs=fluffArr>
</cfif>
<cfset extraa_dimensions=arrayNew(1)>
<cfif structKeyExists(Aitem,"itemExtraDimensions")>
<cfset UrExD=Aitem.itemExtraDimensions.XmlChildren>
    
    <cfloop from="1" to="#arrayLen(UrExD)#" index="iix">
       <cfset extraa_dimension=structNew()>
        
        <cfloop from="1" to="#arraylen(UrExD[iix].XmlChildren)#" index="jxx">            
            <cfset ii=structNew()>
            <cfset "extraa_dimension.#UrExD[iix].XmlChildren[jxx].XmlName#"=UrExD[iix].XmlChildren[jxx].XmlText>                       
        </cfloop>
        <cfscript>
            arrayAppend(extraa_dimensions,extraa_dimension);
        </cfscript>
    </cfloop>
    <cfset Urun.itemExtraDimensions=extraa_dimensions>
<cfelse>
    <cfset Urun.itemExtraDimensions=arrayNew(1)>
</cfif>


<cfset coverInformations=arrayFilter(Aitem.XmlChildren,function(item){
    return item.XmlName=="coverInformation"
})>

<cfset coverInformationsArr=arrayNew(1)>
<cfloop from="1" to="#arrayLen(coverInformations)#" index="j">
    <cfset ii=structNew()>
    <cfset infoss=coverInformations[j].XmlChildren>
    
    <cfloop array="#infoss#" item="iiit">
        <cfset "ii.#iiit.XmlName#"=iiit.XmlText>
    </cfloop>
    <cfscript>
        arrayAppend(coverInformationsArr,ii);
    </cfscript>
</cfloop>
<cfset Urun.coverInformations=coverInformationsArr>

<cfscript>
    arrayAppend(UrunListesi,Urun);
</cfscript>






<!----<cfdump var="#Aitem_Identification.itemIdentifier[1]#">
<cfdump var="#Aitem_Identification.itemIdentifier[2]#">
<cfdump var="#Aitem_Identification.itemIdentifier[3]#">---->

</cfloop>

<cfoutput>
    <div class="alert alert-success">
    xml Okuma Bitti <br>
    DY:#expandPath(".\Addons\Partner\Test\includes\")#<br>
    DT:#now()#<br>
    ÜrünSayisi:#arrayLen(UrunListesi)#<br>
    
</div>
</cfoutput>

LOOP BASLADI
<cfloop array="#UrunListesi#"  index="i" item="Urun">
  Okudum
    <cfset attributes.HIERARCHY="#Urun.retailSalesCategory#.#Urun.itemClass#.#Urun.ITEMGROUPCODE#">
    <CFSET PRCCC="">
    <cfloop array="#Urun.ITEMIDENTIFIERS#" item="it">
        <cfif it.ITEMNUMBERQUALIFIER eq "SellerAssigned">
            <cfset PRCCC="#it.ITEMNUMBER#">
        </cfif>
    </cfloop>
    <cfquery name="is_product_imported" datasource="#DSN1#">
        SELECT * FROM PRODUCT WHERE PRODUCT_CODE_2='#PRCCC#'
    </cfquery>



<cfif is_product_imported.recordCount>
    <cfset Urun.URUN_ID=is_product_imported.PRODUCT_ID>
    <CFSET PBS_PRODUCT_ID=is_product_imported.PRODUCT_ID>
   
<cfinclude template="image_ekle.cfm">
<cfinclude template="ozellikleri_ekle.cfm">
Ürün Var <br>
  <cfelse>
    <cfinclude template="save_category.cfm">
    <cfinclude template="save_product.cfm">
    <cfset Urun.URUN_ID=PBS_PRODUCT_ID>
    Ürün Yok Açtık <br>
    <!----En Sonda Kalacak  PBS_PRODUCT_ID----->
    <cfinclude template="urun_cover_ekle.cfm">
    <cfinclude template="urun_extra_dimension_ekle.cfm">
    <cfinclude template="fluf_ekle.cfm">
    <cfinclude template="urun_ek_ozellik_ekle.cfm">
    <cfinclude template="ref_doc_ekle.cfm">
    <cfinclude template="save_dimensions.cfm">
    <cfinclude template="image_ekle.cfm">
<cfinclude template="ozellikleri_ekle.cfm">
   

</cfif>
</cfloop>
LOOP BİTTİ
<cfoutput>
    #expandPath(".\Addons\Partner\Test\includes\")#
    #now()#
</cfoutput>