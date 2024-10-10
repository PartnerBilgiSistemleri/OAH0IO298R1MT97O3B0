
<cf_box title="KVKK Onay Girişi">

<cfquery name="getP" datasource="#dsn#">
<cfif attributes.ctype eq 1>
    select CP.MOBIL_CODE,CP.MOBILTEL from catalyst_prod.COMPANY as C LEFT JOIN catalyst_prod.COMPANY_PARTNER AS CP ON C.MANAGER_PARTNER_ID=CP.PARTNER_ID WHERE C.COMPANY_ID=#attributes.consumer_id#
    <cfelse>
        select MOBIL_CODE,MOBILTEL from catalyst_prod.CONSUMER WHERE CONSUMER_ID=#attributes.consumer_id#
</cfif>
    
</cfquery>

<cfif len(getP.MOBIL_CODE) eq 0>
    1 Mobil Telefon Kodu Kayıtlı Değildir
    <script>
        alert("Mobil Telefon Kodu Kayıtlı Değildir")
        this.close();
        <cfabort>
    </script>
<cfelse>
    2
    <cfif left(getP.MOBIL_CODE,1) eq "0">
        3 Mobil Telefon Kodunu Başında '0' (Sıfır) Olmadan Yazınız
        <script>
            alert("Mobil Telefon Kodunu Başında '0' (Sıfır) Olmadan Yazınız ")
        this.close();
        <cfabort>
        </script>
    </cfif>
    <cfif len(getP.MOBIL_CODE) neq 3>
       <cfoutput>#len(getP.MOBIL_CODE)#</cfoutput>
        4 Mobil Telefon Kodu 3 Haneli Olmalıdır 
        <script>
            alert("Mobil Telefon Kodu 3 Haneli Olmalıdır ")
        this.close();
        <cfabort>
        </script>
    </cfif>
</cfif>
<cfif len(getP.MOBILTEL) eq 0>
    5 Mobil Telefon Kayıtlı Değildir
    <script>
        alert("Mobil Telefon Kayıtlı Değildir")
        this.close();
        <cfabort>
    </script>
<cfelse>
    <cfif len(getP.MOBILTEL) neq  7>
        <cfoutput>#len(getP.MOBILTEL)#</cfoutput>
        Mobil Telefon  7 Haneli Olmalıdır 
        <script>
            alert("Mobil Telefon  7 Haneli Olmalıdır ")
        this.close();
        <cfabort>
        </script>
    </cfif>
</cfif>
<input type="hidden" name="phone_number" id="phone_number" value="<cfoutput>#getP.MOBIL_CODE##getP.MOBILTEL#</cfoutput>">
<input type="hidden" name="pos" id="pos" value="1">
<input type="hidden" name="message_id" id="message_id" value="0">
<input type="hidden" name="consumer_id" id="consumer_id" value="<cfoutput>#attributes.consumer_id#</cfoutput>">
<input type="hidden" name="ctype" id="ctype" value="<cfoutput>#attributes.ctype#</cfoutput>">
<input type="text" name="activation_code" placeholder="Eşleştirme Kodu" id="activation_code" value="" style="display:none">
<input type="button" class="btn btn-danger" value="Gönder" onclick="sendMessage()">

<script>
    $(document).ready(function(){
        sendMessage();
    })
</script>

<script>

function sendMessage() {
        var phone=document.getElementById("phone_number").value
        var pos=document.getElementById("pos").value
        var message_id=document.getElementById("message_id").value
        var activation_code=document.getElementById("activation_code").value
        var consumer_id=document.getElementById("consumer_id").value
        var ctype=document.getElementById("ctype").value
        $.ajax({
            url:"/AddOns/Partner/verimor/cfc/verimor.cfc?method=SendMessage&pos="+pos+"&ctype="+ctype+"&phone="+phone+"&message_id="+message_id+"&company_id="+consumer_id+"&activation_code="+activation_code,
            success:function(retDat){
               var Obj= JSON.parse(retDat);
               console.log(Obj)
              alert(Obj.MESSAGE+" - "+Obj.MESAJDATA.MESAJ_BILGI)
               if(parseInt(Obj.POS) ==1){
              
                document.getElementById("pos").value=2;
                document.getElementById("message_id").value=Obj.RNDMNMBR;
                $("#activation_code").show();
               }
               if(parseInt(Obj.POS) ==2){
                window.opener.location.reload();
                window.close();
               }
            }
        })
    }

</script>
</cf_box>
<!-----
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">




<br>

<br>






<script
  src="https://code.jquery.com/jquery-3.6.4.js"
  integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="
  crossorigin="anonymous"></script>

<script>
    function sendMessage() {
        var phone=document.getElementById("phone_number").value
        var pos=document.getElementById("pos").value
        var message_id=document.getElementById("message_id").value
        var activation_code=document.getElementById("activation_code").value
        $.ajax({
            url:"/PROJECTS/verimor/verimor.cfc?method=SendMessage&pos="+pos+"&message_id="+message_id+"&company_id=1&activation_code="+activation_code,
            success:function(retDat){
               var Obj= JSON.parse(retDat);
               console.log(Obj)
               if(parseInt(Obj.POS) ==1){
                document.getElementById("pos").value=2;
                document.getElementById("message_id").value=Obj.RNDMNMBR;
                $("#activation_code").show();
               }
            }
        })
    }
    function temizle(){
        document.getElementById("pos").value=1;
        document.getElementById("message_id").value=0;
        $("#activation_code").hide();
    }
</script>


------>