<script>
$(document).on('ready',function(){
var fatid=getParameterByName('id');
var elem=document.getElementsByClassName("detailHeadButton")
//$(elem[0].children).append("<li class='dropdown' id='transformation'><a style='color:#e303fc' title='Takip'onclick='pencereac(4,"+fatid+")'><i class='icon-bell'></i></a></li>")
var e=wrk_query("SELECT * FROM SVK_TALEP WHERE ACTION_ID="+fatid+" AND FROM_ORDER=0","dsn3")
if(e.recordcount>0){
    $(elem[0].children).append("<li class='dropdown' id='transformation'><a style='color:#29c704' onclick='pencereac(2,"+fatid+")' title='Sevkiyat Talebi Verildi'><i class='icon-exchange'></i></a></li>")
}else{
$(elem[0].children).append("<li class='dropdown' id='transformation'><a style='color:#0489c7' title='Sevkiyat Talebi Oluştur' onclick='pencereac(1,"+fatid+")'><i class='icon-exchange'></i></a></li>")}
//$(elem[0].children).append("<li class='dropdown' id='transformation'><a style='color:#04c76c' title='Şube Sevkiyat Talebi Oluştur'onclick='pencereac(2,"+fatid+")'><i class='icon-industry'></i></a></li>")
//$(elem[0].children).append("<li class='dropdown' id='transformation'><a style='color:#fcba03' title='Yazdır'onclick='pencereac(3,"+fatid+")'><i class='icon-print'></i></a></li>")
// var q="SELECT DISTINCT ORDER_ID FROM PRTOTM_SHIP_RESULT_ROW WHERE ORDER_ID="+fatid
// var res=wrk_query(q,"dsn3")
// console.log(res)
// if(res.recordcount >0){
//     $("#workcube_button").remove()
//     $(".detailHeadButton").remove()
//     var drs=$(".detailHeadButton .dropdown a")
//     drs.each(function(i,e){
//         var att=$(e).attr("Title")
//         if(att=="Kaydet"){
//             $(e).remove()
//         }
//     })
// }


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
function pencereac(tip,idd){
    if(tip==1){
    windowopen('index.cfm?fuseaction=sales.emptypopup_add_sevk_talep&tip=1&from_order=0&ACTION_ID='+idd,'wide');}else if(tip==2){
        windowopen('index.cfm?fuseaction=sales.emptypopup_add_sevk_talep&tip=2&from_order=0&ACTION_ID='+idd,'wide');
    }else if(tip==3){
         windowopen('index.cfm?fuseaction=objects.popup_print_files_old&action=sales.list_order&action_id='+idd+'&print_type=73','wide');
    }else if(tip==4){
        windowopen('index.cfm?fuseaction=objects.popup_rekactions_prt&action=ORDER&action_id='+idd,'wide');
    }
}
///objects.popup_rekactions_prt
</script>


