<CFSET BRANCH_ID=listgetat(session.EP.USER_LOCATION,2,"-")>
<cfdump var="#BRANCH_ID#">
<CFIF BRANCH_ID EQ 1>
   <CFSET SEVK_DEPARTMAN=1>
   <CFSET SEVK_LOKASYON=1>
   <CFSET SEVK_RAF_NO="L0799A99">
   <CFSET SEVK_RAF_ID="754">
<CFELSEIF BRANCH_ID EQ 2>
   <CFSET SEVK_DEPARTMAN=3>
   <CFSET SEVK_LOKASYON=2>
   <CFSET SEVK_RAF_NO="">
   <CFSET SEVK_RAF_ID="">
<CFELSEIF BRANCH_ID EQ 3>
   <CFSET SEVK_DEPARTMAN=2>
   <CFSET SEVK_LOKASYON=1>
   <CFSET SEVK_RAF_NO="">
   <CFSET SEVK_RAF_ID="">
<CFELSEIF BRANCH_ID EQ 4>
   <CFSET SEVK_DEPARTMAN=21>
   <CFSET SEVK_LOKASYON=1>
   <CFSET SEVK_RAF_NO="">
   <CFSET SEVK_RAF_ID="">
<CFELSEIF BRANCH_ID EQ 5>
   <CFSET SEVK_DEPARTMAN=3>
   <CFSET SEVK_LOKASYON=2>
   <CFSET SEVK_RAF_NO="">
   <CFSET SEVK_RAF_ID="">
<CFELSEIF BRANCH_ID EQ 6>
   <CFSET SEVK_DEPARTMAN=24>
   <CFSET SEVK_LOKASYON=2>
   <CFSET SEVK_RAF_NO="">
   <CFSET SEVK_RAF_ID="">
<CFELSEIF BRANCH_ID EQ 7>
   <CFSET SEVK_DEPARTMAN=28>
   <CFSET SEVK_LOKASYON=5>
   <CFSET SEVK_RAF_NO="">
   <CFSET SEVK_RAF_ID="">   
<CFELSEIF BRANCH_ID EQ 8>
   <CFSET SEVK_DEPARTMAN=29>
   <CFSET SEVK_LOKASYON=6>
   <CFSET SEVK_RAF_NO="">
   <CFSET SEVK_RAF_ID="">

</CFIF>