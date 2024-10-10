<script>
    $(document).on('ready',function(){
    var fatid=getParameterByName('iid');
    var elem=document.getElementsByClassName("detailHeadButton")    
    var Ptype=document.getElementById("old_process_type").value;
    var Ptype2=document.getElementById("old_process_cat_id").value;
    Ptype=parseInt(Ptype);
    if(Ptype==591 || Ptype2==209){ 
        $(elem[0].children).append("<li class='dropdown' id='transformation'><a style='color:rgba(208, 72, 54, 0.88)' title='Lot Aktar' onclick='pencereac(1,"+fatid+")'><i class='icon-MLM'></i></a></li>")
        $(elem[0].children).append("<li class='dropdown' id='transformation'><a style='color:rgba(64, 218, 0, 0.88)' title='Lot Kontrol' onclick='pencereac(2,"+fatid+")'><i class='icon-file-text-o'></i></a></li>")
        $(elem[0].children).append("<li class='dropdown' id='transformation'><a style='color:rgba(255, 179, 0, 0.88)' title='Girişi Yapıldı' onclick='pencereac(3,"+fatid+")'><i class='icn-md icon-Intranet'></i></a></li>")
        $(elem[0].children).append("<li class='dropdown' id='transformation'><a style='color:rgba(255, 0, 0, 0.88)' title='Yeniden Bağla' onclick='pencereac(5,"+fatid+")'><i class='icn-md fa fa-connectdevelop'></i></a></li>")
    }
    
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
        windowopen('index.cfm?fuseaction=invoice.emptypopup_add_import_product_lot&INVOICE_ID='+idd,'wide');}else if(tip==2){
            windowopen('index.cfm?fuseaction=invoice.emptypopup_list_lotnumber&is_submit=1&INVOICE_ID='+idd,'wide');
        }else if(tip==3){
            windowopen("/index.cfm?fuseaction=settings.partner_test_page&page=8&INVOICE_ID="+idd,"page")
        }else if(tip==4){
            windowopen('index.cfm?fuseaction=objects.popup_rekactions_prt&action=ORDER&action_id='+idd,'wide');
        }
        else if(tip==5){
            windowopen("/index.cfm?fuseaction=settings.partner_test_page&page=10&INVOICE_ID="+idd,"page")
        }
    }
    ///objects.popup_rekactions_prt
    </script>
    
    
    