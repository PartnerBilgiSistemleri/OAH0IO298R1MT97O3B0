<cfspreadsheet action="read" src="#expandPath(".\Addons\Partner\Tools\Test\includes\")#\emre.xlsx" query="resa"> 
<cfdump var="#resa#">

<cfquery name="getData" dbtype="query">
    select col_1,col_2 from resa
</cfquery>


<cfoutput query="getData">
    <cftry>
    <cfquery name="DD" datasource="#dsn1#">
        UPDATE PRODUCT SET COMPANY_ID=#col_1# WHERE PRODUCT_CODE_2='#col_2#'
    </cfquery>
    <cfcatch>
        #col_2# Bulunamadı <br>
    </cfcatch>
    </cftry>
</cfoutput>