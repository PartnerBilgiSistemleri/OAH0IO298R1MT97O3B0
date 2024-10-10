<CFSET CPI=0>
<cfset ctype=0>
<CFIF isDefined("attributes.cpid")>
<cfset  CPI=attributes.cpid>
<cfset ctype=1>
<cfelse>
    <cfset  CPI=attributes.cid>
    <cfset ctype=0>
</CFIF>

<cfquery name="getData" datasource="#dsn#">
    SELECT MESSAGE_ID,ACC_CODE,ACC_RETURN_CODE,ACC_INFO_CODE,CONSUMER_ID,SENDING_DATE,SEND_EMP,APPROVAL_DATE FROM CONSUMER_MESSAGES WHERE CONSUMER_ID=#CPI# AND RECORD_TYPE=#ctype# AND APPROVAL_DATE IS NOT NULL
</cfquery>



<cfif getData.recordCount>
    <button type="button" class="btn btn-success">Ok</button>
<cfelse>
    <button type="button" class="btn btn-danger" onclick="windowopen('/index.cfm?fuseaction=objects.emptypopup_send_verimor_message&pos=1&ctype=<cfoutput>#ctype#</cfoutput>&consumer_id='+<cfoutput>#CPI#</cfoutput>)">KVKK Onay Mesajı Gönder !</button>
</cfif>
<!------
<script>
    $(document).ready(function(){
        var pid=getParameterByName('cid');
        var btn=document.createElement("button")
        var qq="SELECT MESSAGE_ID,ACC_CODE,ACC_RETURN_CODE,ACC_INFO_CODE,CONSUMER_ID,SENDING_DATE,SEND_EMP,APPROVAL_DATE FROM CONSUMER_MESSAGES WHERE CONSUMER_ID="+pid
       var res=wrk_query(qq,"dsn1")
        //console.log(res)
        var i=document.createElement("i")
        i.setAttribute("class","icn-md icon-cogs")
        var ims=0;
        if(res.recordcount > 0){
            btn.setAttribute("class","btn btn-success col col-8 col-md-8 col-sm-8 col-xs-12")
    
        }else{
            btn.setAttribute("class","btn btn-danger col col-8 col-md-8 col-sm-8 col-xs-12")
            ims=1
        }
        btn.appendChild(i)
        btn.setAttribute("onclick","pencereac(1,"+pid+","+ims+")")
        var div=document.createElement("div")
        div.setAttribute("class","form-group")
        var lbl=document.createElement("label")
        lbl.innerText="Demonte Edilebilir"
        lbl.setAttribute("class","col col-4 col-md-4 col-sm-4 col-xs-12")
        div.appendChild(lbl)
        div.appendChild(btn)
        var ch_count=$("#unique_sayfa_1").find(".ui-form-list").children().length
        var ls=$("#unique_sayfa_1").find(".ui-form-list").children()[ch_count-1]
        ls.appendChild(div)
    })
    
    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, '\\$&');
        var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    }
    function pencereac(tip,idd,demo){
       if(tip==1){
         windowopen("/index.cfm?fuseaction=objects.emptypopup_update_product_demontage&product_id="+idd+"&IS_DEMONTAGE="+demo)
       }
    }
    </script>---->
    