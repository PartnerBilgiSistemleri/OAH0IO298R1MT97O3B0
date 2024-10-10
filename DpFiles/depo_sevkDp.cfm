<script>
$(document).on('ready',function(){

var evv=getParameterByName("event")
console.log(evv)
   var saatElem=$("#deliver_date_h")
    var dakikaElem=$("#deliver_date_m")
    var saat =$(saatElem).val();
    var dakika =$(dakikaElem).val();
    var today=new Date();
    if(saat == parseInt(saat) && dakika==parseInt(dakika)){      
        var xx =today.getHours();      
        var yy=xx.toString();    
        if( yy.length ==1){saatElem.val("0"+yy)}else{saatElem.val(today.getHours())}
        xx=today.getMinutes();
        yy=xx.toString();
        if( yy.length ==1){dakikaElem.val(""+yy)}else{dakikaElem.val(today.getMinutes())}                
    }
    var btn =document.createElement("button")
btn.innerText="Rafları Yaz ve Güncelle";
btn.setAttribute("class","ui-wrk-btn ui-wrk-btn-warning")
btn.setAttribute("onclick","RaflariYazGulum()")
document.getElementById("workcube_button").appendChild(btn)

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
function RaflariYazGulum(params) {
    var DIN=document.getElementById("department_in_id").value;
var LIN=document.getElementById("location_in_id").value;

var DOUT=document.getElementById("department_id").value;
var LOUT=document.getElementById("location_id").value;

for(let i=0;i<basket.items.length;i++){
    var SH_IN=wrk_query("SELECT PRODUCT_PLACE_ID,SHELF_CODE FROM PRODUCT_PLACE WHERE STORE_ID="+DIN+" AND LOCATION_ID="+LIN,"DSN3")
    var SH_OUT=wrk_query("SELECT PRODUCT_PLACE_ID,SHELF_CODE FROM PRODUCT_PLACE WHERE STORE_ID="+DOUT+" AND LOCATION_ID="+LOUT,"DSN3")
if(basket.items[i].SHELF_NUMBER_TXT.length>0){}else{
    basket.items[i].SHELF_NUMBER=SH_OUT.PRODUCT_PLACE_ID[0];
    basket.items[i].SHELF_NUMBER_TXT=SH_OUT.SHELF_CODE[0];
}
    if(basket.items[i].TO_SHELF_NUMBER_TXT.length>0){}else{
        basket.items[i].TO_SHELF_NUMBER=SH_IN.PRODUCT_PLACE_ID[0];
    basket.items[i].TO_SHELF_NUMBER_TXT=SH_IN.SHELF_CODE[0];
    }

    
    var BISH={
    raf_out_id:basket.items[i].SHELF_NUMBER,
    raf_out:basket.items[i].SHELF_NUMBER_TXT,
    raf_in_id:basket.items[i].TO_SHELF_NUMBER,
    raf_in:basket.items[i].TO_SHELF_NUMBER_TXT,
}
console.table(BISH)
    
    var IID=document.getElementsByName("shelf_number_txt")[i].parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.id
    console.log("i="+i+" IID="+IID)
    if(IID=='tblBasket'){
        document.getElementsByName("shelf_number_txt")[i].value=basket.items[i].SHELF_NUMBER_TXT;
        document.getElementsByName("shelf_number")[i].value=basket.items[i].SHELF_NUMBER;

        document.getElementsByName("to_shelf_number_txt")[i].value=basket.items[i].TO_SHELF_NUMBER_TXT;
        document.getElementsByName("to_shelf_number")[i].value=basket.items[i].TO_SHELF_NUMBER;
    }
    
}

    (sessionControl() && validateControl() && depo_control() && waitForDisableAction2390348(this))
}
</script>