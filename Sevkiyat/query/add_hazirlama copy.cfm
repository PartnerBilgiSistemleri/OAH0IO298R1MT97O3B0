<cfloop from="1" to="#attributes.RC#" index="i">
   <cfset PRODUCT_ID=evaluate("attributes.PRODUCT_ID_#i#")>
   <cfset STOCK_ID=evaluate("attributes.STOCK_ID_#i#")>
   <cfset WRK_ROW_ID=evaluate("attributes.WRK_ROW_ID_#i#")>
   <cfset LOT=evaluate("attributes.LOT_#i#")>
   <CFSET AMOUNT=1>
   <CFIF LEN(LOT)>
      <cfquery name="ihv" datasource="#dsn3#">
         select * from HAZIRLAMA_ROWS where WRK_ROW_ID='#WRK_ROW_ID#'
      </cfquery>
      <cfif ihv.recordCount>
      <cfelse>   
         <cfquery name="INS" datasource="#DSN3#">
            INSERT INTO #DSN3#.HAZIRLAMA_ROWS(SVK_ID,ACTION_ID, WRK_ROW_ID,PRODUCT_ID,STOCK_ID,AMOUNT,RECORD_EMP,RECORD_DATE)
            VALUES(#attributes.SVK_ID#,#attributes.ACTION_ID#,'#WRK_ROW_ID#',#PRODUCT_ID#,#STOCK_ID#,#AMOUNT#,#session.ep.userid#,GETDATE())
         </cfquery>
         <cfif attributes.IS_FROM_ORDER EQ 1>
            <cfquery name="UPDA" datasource="#DSN3#">
               UPDATE ORDER_ROW SET LOT_NO='#LOT#',ORDER_ROW_CURRENCY=-6 WHERE WRK_ROW_ID='#WRK_ROW_ID#'
            </cfquery>
         <CFELSE>
            <cfquery name="UPDA" datasource="#DSN3#">
               UPDATE INTERNALDEMAND_ROW SET LOT_NO='#LOT#' WHERE WRK_ROW_ID='#WRK_ROW_ID#'
            </cfquery>
         </cfif>
      </cfif> 
   </CFIF>
</cfloop>
<script>
   window.location.href='/index.cfm?fuseaction=sales.emptypopup_list_sevk_talep'
   
</script>