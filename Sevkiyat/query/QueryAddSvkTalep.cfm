

<cfquery name="GETPP" datasource="#DSN3#">
    SELECT SHIP_INTERNAL_NO,SHIP_INTERNAL_NUMBER FROM GENERAL_PAPERS WHERE SHIP_INTERNAL_NO='PSVK'
</cfquery>
<CFSET SIFIRIM="">
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 1><CFSET SIFIRIM="000000"></CFIF>
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 2><CFSET SIFIRIM="00000"></CFIF>
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 3><CFSET SIFIRIM="0000"></CFIF>
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 4><CFSET SIFIRIM="000"></CFIF>
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 5><CFSET SIFIRIM="00"></CFIF>
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 6><CFSET SIFIRIM="0"></CFIF>
<CFIF LEN(GETPP.SHIP_INTERNAL_NUMBER) EQ 7><CFSET SIFIRIM=""></CFIF>
<CFSET PAPER_NO="#GETPP.SHIP_INTERNAL_NO#-#SIFIRIM##GETPP.SHIP_INTERNAL_NUMBER#">

<cfquery name="ins" datasource="#dsn3#" result="resa">
    INSERT INTO SVK_TALEP (SVK_NUMBER,ACTION_ID,FROM_ORDER,RECORD_DATE,RECORD_EMP,DEPARTMENT_ID,LOCATION_ID,DELIVER_DATE ) VALUES ('#PAPER_NO#',#attributes.ACTION_ID#,#attributes.from_order#,GETDATE(),#session.EP.userid#
    ,#listGetAt(attributes.DELIVER_DEPT,1,"-")#,#listGetAt(attributes.DELIVER_DEPT,2,"-")#,'#attributes.DELIVER_DATE#')
</cfquery>


<cfloop list="#attributes.SATIRCIM#" item="li">
    <cfquery name="ins" datasource="#dsn3#">
        INSERT INTO LIST_SEVK_TALEP_ROWS_#session.ep.PERIOD_YEAR#  (WRK_ROW_ID,AMOUNT,SVK_ID,ACTION_ID,FROM_ORDER) VALUES('#li#',#evaluate("attributes.KALAN_#li#")#,#resa.generatedkey#,#attributes.ACTION_ID#,#attributes.FROM_ORDER#)
    </cfquery>
    <cfdump var="#li#"> <br>
</cfloop>



<cfquery name="UPD" datasource="#DSN3#">
    UPDATE  GENERAL_PAPERS SET SHIP_INTERNAL_NUMBER=SHIP_INTERNAL_NUMBER+1 WHERE SHIP_INTERNAL_NO='PSVK'
 </cfquery>