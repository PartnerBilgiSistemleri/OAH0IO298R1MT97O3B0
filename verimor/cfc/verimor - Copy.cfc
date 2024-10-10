
<cfcomponent>
<cfset username="902323351637">
<cfset dsn = application.systemParam.systemParam().dsn>
<cfset password="UHCpTWYK">
    
<cffunction name="SendSubMessage" access="remote" httpMethod="POST"  returntype="any" returnFormat="json">
    <cfargument name="Mesaj">
    <cfargument name="Telefon">
    <cfargument name="MesajTipi">
    <cfargument name="Baslik">
    
    <cfscript>
        messageData={
           "username"    = "#username#",
           "password"    = "#password#",
           "source_addr" = "#arguments.Baslik#",           
           "datacoding"  = "0",
           "messages"= [
                        { 
                         "msg" = "#arguments.Mesaj#",
                         "dest"= "#arguments.Telefon#"
                         
                        }
                       ]
         }
   </cfscript>

   <cfset Uri="https://sms.verimor.com.tr/v2/send?username=#username#&password=#password#&msg=#arguments.Mesaj#&dest=#arguments.Telefon#&datacoding=0">
    <cfhttp url="#Uri#" result="resa" method="GET">
      <!---  <cfhttpparam type="header" name="Content-Type" value="application/json">
        <cfhttpparam type="header" name="Content-Length" value="#len(trim(replace(serializeJSON(messageData),"//","")))#">
        <cfhttpparam type="header" name="Accept-Encoding" value="gzip, deflate, br">
        
        <cfhttpparam type="header" name="Accept" value="*/*">
        <cfhttpparam type="body" value="#trim(replace(serializeJSON(messageData),"//",""))#">     ---->       
    </cfhttp>
<!----<cfreturn resa.filecontent>---->
<CFSET ARGUMENTS.MESAJ_BILGI=resa.filecontent>
<CFSET ARGUMENTS.messageData=trim(replace(serializeJSON(messageData),"//",""))>
<CFSET ARGUMENTS.resa=trim(replace(serializeJSON(resa),"//",""))>
<cfreturn arguments>
     
</cffunction>

<cffunction name="SendMessage" access="remote" httpMethod="POST"  returntype="any" returnFormat="json">
        <cfargument name="phone">
        <cfargument name="message">
        <cfargument name="pos" default="1">
        <cfargument name="company_id">
        <cfargument name="message_id" default="">
        <cfargument name="ctype" default="">

        <cfargument name="Banka" default="">
        <cfargument name="Kisi" default="">
        <cfargument name="Tutar" default="">
        <cfargument name="OdemeTipi" default="">
        <cfargument name="ParaBirimi" default="">     
        
        <cfset RandomNmbr=genKey(arguments.pos,arguments.message_id,arguments.company_id,arguments.ctype)>
        
        <cfset Mesaj="">
        <cfif arguments.pos eq 1>
            <cfset Mesaj="KVKK geregi islenecek kisisel verilerinizle telefonunuzu eslestirme kodunuz: #RandomNmbr#- Aydinlatma Metni İçin https://www.ashleyturkiye.com/kisisel-verilerin-korunmasi">
        <cfelseif arguments.pos eq 2>
            <cfquery name="ihv" datasource="#dsn#">
                SELECT * FROM CONSUMER_MESSAGES WHERE ACC_CODE='#arguments.activation_code#'
            </cfquery>
            <cfif not ihv.recordcount>
                <cfset returnData.Durum=0>
                <cfset returnData.Message="Onay Kodu Hatalı">
                <cfset returnData.Pos=arguments.pos>
                <cfset returnData.RndmNmbr="">
                <cfreturn replace(serializeJson(returnData),"//","")>
            </cfif>
            <cfquery name="upd" datasource="#dsn#">
                UPDATE CONSUMER_MESSAGES SET ACC_RETURN_CODE='#arguments.activation_code#',APPROVAL_DATE=#now()# WHERE ACC_CODE='#arguments.activation_code#'
            </cfquery>
            <cfset Mesaj="Onay Kodu: #RandomNmbr# ETK uyarinca kisisel verilerinizin islenmesine dair onayinizi aydinlatma metnimiz kapsamında https://www.ashleyturkiye.com/kisisel-verilerin-korunmasi talep etmekteyiz">        
        <cfelseif arguments.pos eq 3>
            <cfset Mesaj="Sayın #arguments.Kisi# #dateformat(now(),"dd.mm.yyyy")# tarihinde kurumumuza #tlformat(arguments.tutar)# #arguments.ParaBirimi# tutarinda #arguments.OdemeTipi# ile ödeme yaptınız; Saglikli gunler dileriz.">
        </cfif>

<cfquery name="INSLOG" datasource="#DSN#">
    INSERT INTO CONSUMER_MESSAGE_LOG (CONSUMER_ID,MESSSAGE,SEND_EMP,RECORD_DATE,POS,PHONE_NUMBER,RECORD_TYPE) VALUES(#arguments.company_id#,'#Mesaj#',#session.ep.userid#,#now()#,#arguments.pos#,'#arguments.phone#',#arguments.ctype#)
</cfquery>

        <cfset returnData.Durum=1>
        <cfset returnData.Message="Mesaj Gönderildi">
        <cfset returnData.Pos=arguments.pos>
        <cfset returnData.RndmNmbr=RandomNmbr>
        <cfset returnData.MesajData=SendSubMessage(Mesaj,'#arguments.phone#',arguments.pos,"ASHLEY")>
        <cfreturn replace(serializeJson(returnData),"//","")>
<!---
       <cfargument name="Mesaj">
    <cfargument name="Telefon">
    <cfargument name="MesajTipi">
    <cfargument name="Baslik">
    <cfargument name="iid">
     ---->
    <cfreturn RandomNmbr>
    </cffunction>
    
    <cffunction name="genKey">
        <cfargument name="pos" default="1">
        <cfargument name="id" default="">
        <cfargument name="company_id" default="">
        <cfargument name="ctype" default="0">
        <cfset num1 = 1000>
        <cfset num2 = 100000>     
        <cfset randAlgorithmArray = ["CFMX_COMPAT", "SHA1PRNG", "IBMSecureRandom"]>
       <cfset rnd= randRange(num1, num2, randAlgorithmArray[2])>
        <cfquery name="ih" datasource="#dsn#">
            SELECT * FROM CONSUMER_MESSAGES WHERE 1=1 <cfif pos eq 1>
                AND ACC_CODE='#rnd#'
            <cfelse>
                AND ACC_INFO_CODE='#rnd#'
            </cfif>
        </cfquery>
        <cfif ih.recordcount>
            <cfset rnd=genKey(arguments.pos,arguments,id,arguments.company_id)>
        <cfelse>
            <cfif pos eq 1>
                    
                <cfquery name="ins" datasource="#dsn#">
                    INSERT INTO CONSUMER_MESSAGES (ACC_CODE,CONSUMER_ID,SENDING_DATE,SEND_EMP,RECORD_TYPE) VALUES('#rnd#',#arguments.company_id#,#now()#,#session.ep.userid#,#arguments.ctype#)
                </cfquery>
            <cfelse>               
                    <cfquery name="upd" datasource="#dsn#">
                    UPDATE CONSUMER_MESSAGES SET ACC_INFO_CODE='#rnd#' WHERE ACC_CODE=#arguments.id#
                </cfquery>
               
            </cfif>
           
        </cfif>
        <cfreturn rnd>
    </cffunction>
</cfcomponent>