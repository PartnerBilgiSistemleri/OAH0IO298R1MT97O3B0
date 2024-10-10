
<cfquery name="DEL" datasource="#DSN1#">
    DELETE FROM PRODUCT_DT_PROPERTIES WHERE PRODUCT_ID=#PBS_PRODUCT_ID#
</cfquery>
<cfquery name="isHvItemType" datasource="#dsn1#">
    select * from #dsn1#.PRODUCT_PROPERTY_DETAIL where PRPT_ID=1 and PROPERTY_DETAIL='#Urun.ITEMTYPE#'
</cfquery>
<cfif isHvItemType.recordCount>
<cfquery name="AddDtProperty" datasource="#dsn1#">
    INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
VALUES(#PBS_PRODUCT_ID#,1,#isHvItemType.PROPERTY_DETAIL_ID#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
</cfquery>

<cfelse>
<cfquery name="InsType" datasource="#dsn1#" result="RES">
    INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE,RECORD_EMP,RECORD_DATE) VALUES (
        1,'#Urun.ITEMTYPE#',1,#session.EP.USERID#,#now()#
    )
</cfquery>
<cfquery name="AddDtProperty" datasource="#dsn1#">
    INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
VALUES(#PBS_PRODUCT_ID#,1,#RES.IDENTITYCOL#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
</cfquery>  
</cfif>

<cfquery name="isHvITEMCLASS" datasource="#dsn1#">
    select * from #dsn1#.PRODUCT_PROPERTY_DETAIL where PRPT_ID=2 and PROPERTY_DETAIL='#Urun.ITEMCLASS#'
</cfquery>
<cfif isHvITEMCLASS.recordCount>
    <cfquery name="AddDtProperty" datasource="#dsn1#">
        INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
    VALUES(#PBS_PRODUCT_ID#,2,#isHvITEMCLASS.PROPERTY_DETAIL_ID#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
    </cfquery>   
<cfelse>
<cfquery name="InsType" datasource="#dsn1#" result="RES">
    INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE,RECORD_EMP,RECORD_DATE) VALUES (
        2,'#Urun.ITEMCLASS#',1,#session.EP.USERID#,#now()#
    )
</cfquery>
<cfquery name="AddDtProperty" datasource="#dsn1#">
    INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
VALUES(#PBS_PRODUCT_ID#,2,#RES.IDENTITYCOL#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
</cfquery>  
</cfif>

<cfquery name="isHvITEMSTATUS" datasource="#dsn1#">
    select * from #dsn1#.PRODUCT_PROPERTY_DETAIL where PRPT_ID=3 and PROPERTY_DETAIL='#Urun.ITEMSTATUS#'
</cfquery>
<cfif isHvITEMSTATUS.recordCount>
    <cfquery name="AddDtProperty" datasource="#dsn1#">
        INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
    VALUES(#PBS_PRODUCT_ID#,3,#isHvITEMSTATUS.PROPERTY_DETAIL_ID#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
    </cfquery>     
<cfelse>
<cfquery name="InsType" datasource="#dsn1#" result="RES">
    INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE,RECORD_EMP,RECORD_DATE) VALUES (
        3,'#Urun.ITEMSTATUS#',1,#session.EP.USERID#,#now()#
    )
</cfquery>
<cfquery name="AddDtProperty" datasource="#dsn1#">
    INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
VALUES(#PBS_PRODUCT_ID#,3,#RES.IDENTITYCOL#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
</cfquery>  
</cfif>

<cfif len(Urun.ITEMMFGWARRANTYDAYS)>

    <cfquery name="isHvITEMMFGWARRANTYDAYS" datasource="#dsn1#">
        select * from #dsn1#.PRODUCT_PROPERTY_DETAIL where PRPT_ID=11 and PROPERTY_DETAIL='#Urun.ITEMMFGWARRANTYDAYS#'
    </cfquery>
    <cfif isHvITEMMFGWARRANTYDAYS.recordCount>
        <cfquery name="AddDtProperty" datasource="#dsn1#">
            INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
        VALUES(#PBS_PRODUCT_ID#,11,#isHvITEMMFGWARRANTYDAYS.PROPERTY_DETAIL_ID#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
        </cfquery>  
    <cfelse>
    <cfquery name="InsType" datasource="#dsn1#" result="RES">
        INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE,RECORD_EMP,RECORD_DATE) VALUES (
            11,'#Urun.ITEMMFGWARRANTYDAYS#',1,#session.EP.USERID#,#now()#
        )
    </cfquery>
                <cfquery name="AddDtProperty" datasource="#dsn1#">
                    INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
                VALUES(#PBS_PRODUCT_ID#,11,#RES.IDENTITYCOL#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
                </cfquery>  
    </cfif>
    
</cfif>


<cfif len(Urun.ITEMISAVAILABLE)>

    <cfquery name="isHvITEMISAVAILABLE" datasource="#dsn1#">
        select * from #dsn1#.PRODUCT_PROPERTY_DETAIL where PRPT_ID=4 and PROPERTY_DETAIL='#Urun.ITEMISAVAILABLE#'
    </cfquery>
    <cfif isHvITEMISAVAILABLE.recordCount>
        <cfquery name="AddDtProperty" datasource="#dsn1#">
            INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
        VALUES(#PBS_PRODUCT_ID#,4,#isHvITEMISAVAILABLE.PROPERTY_DETAIL_ID#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
        </cfquery>    
    <cfelse>
    <cfquery name="InsType" datasource="#dsn1#" result="RES">
        INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE,RECORD_EMP,RECORD_DATE) VALUES (
            4,'#Urun.ITEMISAVAILABLE#',1,#session.EP.USERID#,#now()#
        )
    </cfquery>
                <cfquery name="AddDtProperty" datasource="#dsn1#">
                    INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
                VALUES(#PBS_PRODUCT_ID#,4,#RES.IDENTITYCOL#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
                </cfquery>  
    </cfif>
    
</cfif>


<cfif len(Urun.ITEMCOLOR)>

    <cfquery name="isHvITEMCOLOR" datasource="#dsn1#">
        select * from #dsn1#.PRODUCT_PROPERTY_DETAIL where PRPT_ID=7 and PROPERTY_DETAIL='#Urun.ITEMCOLOR#'
    </cfquery>
    <cfif isHvITEMCOLOR.recordCount>
        <cfquery name="AddDtProperty" datasource="#dsn1#">
            INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
        VALUES(#PBS_PRODUCT_ID#,7,#isHvITEMCOLOR.PROPERTY_DETAIL_ID#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
        </cfquery>   
    <cfelse>
    <cfquery name="InsType" datasource="#dsn1#" result="RES">
        INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE,RECORD_EMP,RECORD_DATE) VALUES (
            7,'#Urun.ITEMCOLOR#',1,#session.EP.USERID#,#now()#
        )
    </cfquery>
                <cfquery name="AddDtProperty" datasource="#dsn1#">
                    INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
                VALUES(#PBS_PRODUCT_ID#,7,#RES.IDENTITYCOL#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
                </cfquery>  
    </cfif>
    
</cfif>

<cfif len(Urun.ITEMISPACKAGE)>

    <cfquery name="isHvITEMISPACKAGE" datasource="#dsn1#">
        select * from #dsn1#.PRODUCT_PROPERTY_DETAIL where PRPT_ID=5 and PROPERTY_DETAIL='#Urun.ITEMISPACKAGE#'
    </cfquery>
    <cfif isHvITEMISPACKAGE.recordCount>
        <cfquery name="AddDtProperty" datasource="#dsn1#">
            INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
        VALUES(#PBS_PRODUCT_ID#,5,#isHvITEMISPACKAGE.PROPERTY_DETAIL_ID#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
        </cfquery>     
    <cfelse>
    <cfquery name="InsType" datasource="#dsn1#" result="RES">
        INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE,RECORD_EMP,RECORD_DATE) VALUES (
            5,'#Urun.ITEMISPACKAGE#',1,#session.EP.USERID#,#now()#
        )
    </cfquery>
                <cfquery name="AddDtProperty" datasource="#dsn1#">
                    INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
                VALUES(#PBS_PRODUCT_ID#,5,#RES.IDENTITYCOL#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
                </cfquery>  
    </cfif>
    
</cfif>

<cfif len(Urun.ITEMSPERCASE)>

    <cfquery name="isHvITEMSPERCASE" datasource="#dsn1#">
        select * from #dsn1#.PRODUCT_PROPERTY_DETAIL where PRPT_ID=8 and PROPERTY_DETAIL='#Urun.ITEMSPERCASE#'
    </cfquery>
    <cfif isHvITEMSPERCASE.recordCount>
        <cfquery name="AddDtProperty" datasource="#dsn1#">
            INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
        VALUES(#PBS_PRODUCT_ID#,8,#isHvITEMSPERCASE.PROPERTY_DETAIL_ID#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
        </cfquery>      
    <cfelse>
    <cfquery name="InsType" datasource="#dsn1#" result="RES">
        INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE,RECORD_EMP,RECORD_DATE) VALUES (
            8,'#Urun.ITEMSPERCASE#',1,#session.EP.USERID#,#now()#
        )
    </cfquery>
                <cfquery name="AddDtProperty" datasource="#dsn1#">
                    INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
                VALUES(#PBS_PRODUCT_ID#,8,#RES.IDENTITYCOL#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
                </cfquery>  
    </cfif>
    
</cfif>

<cfif len(Urun.CHAIRQTYPERCARTON)>

    <cfquery name="isHvCHAIRQTYPERCARTON" datasource="#dsn1#">
        select * from #dsn1#.PRODUCT_PROPERTY_DETAIL where PRPT_ID=10 and PROPERTY_DETAIL='#Urun.CHAIRQTYPERCARTON#'
    </cfquery>
    <cfif isHvCHAIRQTYPERCARTON.recordCount>
        <cfquery name="AddDtProperty" datasource="#dsn1#">
            INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
        VALUES(#PBS_PRODUCT_ID#,10,#isHvCHAIRQTYPERCARTON.PROPERTY_DETAIL_ID#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
        </cfquery> 
    <cfelse>
    <cfquery name="InsType" datasource="#dsn1#" result="RES">
        INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE,RECORD_EMP,RECORD_DATE) VALUES (
            10,'#Urun.CHAIRQTYPERCARTON#',1,#session.EP.USERID#,#now()#
        )
    </cfquery>
                <cfquery name="AddDtProperty" datasource="#dsn1#">
                    INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
                VALUES(#PBS_PRODUCT_ID#,10,#RES.IDENTITYCOL#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
                </cfquery>  
    </cfif>
    
</cfif>


<cfif len(Urun.seatCount)>

    <cfquery name="isHvseatCount" datasource="#dsn1#">
        select * from #dsn1#.PRODUCT_PROPERTY_DETAIL where PRPT_ID=9 and PROPERTY_DETAIL='#Urun.seatCount#'
    </cfquery>
    <cfif isHvseatCount.recordCount>
        <cfquery name="AddDtProperty" datasource="#dsn1#">
            INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
        VALUES(#PBS_PRODUCT_ID#,9,#isHvseatCount.PROPERTY_DETAIL_ID#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
        </cfquery>   
    <cfelse>
    <cfquery name="InsType" datasource="#dsn1#" result="RES">
        INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE,RECORD_EMP,RECORD_DATE) VALUES (
            9,'#Urun.seatCount#',1,#session.EP.USERID#,#now()#
        )
    </cfquery>
                <cfquery name="AddDtProperty" datasource="#dsn1#">
                    INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
                VALUES(#PBS_PRODUCT_ID#,9,#RES.IDENTITYCOL#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
                </cfquery>  
    </cfif>
    
</cfif>

<cfif len(Urun.ITEMISEXPRESSSHIPELIGIBLE)>

    <cfquery name="isHvITEMISEXPRESSSHIPELIGIBLE" datasource="#dsn1#">
        select * from #dsn1#.PRODUCT_PROPERTY_DETAIL where PRPT_ID=6 and PROPERTY_DETAIL='#Urun.ITEMISEXPRESSSHIPELIGIBLE#'
    </cfquery>
    <cfif isHvITEMISEXPRESSSHIPELIGIBLE.recordCount>
        <cfquery name="AddDtProperty" datasource="#dsn1#">
            INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
        VALUES(#PBS_PRODUCT_ID#,6,#isHvITEMISEXPRESSSHIPELIGIBLE.PROPERTY_DETAIL_ID#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
        </cfquery>  
    <cfelse>
    <cfquery name="InsType" datasource="#dsn1#" result="RES">
        INSERT INTO PRODUCT_PROPERTY_DETAIL (PRPT_ID,PROPERTY_DETAIL,IS_ACTIVE,RECORD_EMP,RECORD_DATE) VALUES (
            6,'#Urun.ITEMISEXPRESSSHIPELIGIBLE#',1,#session.EP.USERID#,#now()#
        )
    </cfquery>
            <cfquery name="AddDtProperty" datasource="#dsn1#">
                INSERT INTO #dsn1#.PRODUCT_DT_PROPERTIES(PRODUCT_ID,PROPERTY_ID,VARIATION_ID,AMOUNT,IS_OPTIONAL,IS_EXIT,IS_INTERNET,RECORD_EMP,RECORD_DATE,RECORD_IP) 
            VALUES(#PBS_PRODUCT_ID#,6,#RES.IDENTITYCOL#,0,0,0,1,#session.ep.USERID#,#NOW()#,'#CGI.REMOTE_ADDR#')
            </cfquery>  
    <!---Dönen Sonuca Göre DTPROPERTY EKLENECEK ÜRÜN EKLENDİKTEN SONRA----->
    </cfif>
    
</cfif>