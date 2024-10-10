<script>
$(document).ready(function(){
    var pid=getParameterByName('pid');
   
    var div=document.createElement("div")
    div.setAttribute("class","form-group")
    var lbl=document.createElement("label")
    lbl.innerText="Xml Bilgileri"
    lbl.setAttribute("class","col col-4 col-md-4 col-sm-4 col-xs-12")
    div.appendChild(lbl)

    var btn=document.createElement("button")  
    var i=document.createElement("i")
        i.setAttribute("class","icn-md icon-cogs")
        i.setAttribute("style","margin:0px 0px 0px 0px !important;")
        btn.setAttribute("style","padding:10px;margin-left:5px")
    btn.setAttribute("class","btn btn-success")
    btn.appendChild(i)
    btn.setAttribute("onclick","pencereac(2,"+pid+")")
    btn.setAttribute("title","Features")
    btn.setAttribute("type","button")
    div.appendChild(btn)

    var btn=document.createElement("button")  
    var i=document.createElement("i")
        i.setAttribute("class","icn-md icon-detail")
        i.setAttribute("style","margin:0px 0px 0px 0px !important;")
        btn.setAttribute("style","padding:10px;margin-left:5px")
    btn.setAttribute("class","btn btn-danger")
    btn.appendChild(i)
    btn.setAttribute("onclick","pencereac(3,"+pid+")")
    btn.setAttribute("title","Covers")
    btn.setAttribute("type","button")
    div.appendChild(btn)
    
    
    var btn=document.createElement("button")  
    var i=document.createElement("i")
        i.setAttribute("class","icn-md icon-book")
        i.setAttribute("style","margin:0px 0px 0px 0px !important;")
        btn.setAttribute("style","padding:10px;margin-left:5px")
    btn.setAttribute("class","btn btn-warning")
    btn.appendChild(i)
    btn.setAttribute("onclick","pencereac(4,"+pid+")")
    btn.setAttribute("title","Extra Dımensions")
    btn.setAttribute("type","button")
    div.appendChild(btn)

    
    var btn=document.createElement("button")  
    var i=document.createElement("i")
        i.setAttribute("class","icn-md icon-file-text")
        i.setAttribute("style","margin:0px 0px 0px 0px !important;")
        btn.setAttribute("style","padding:10px;margin-left:5px")
    btn.setAttribute("class","btn btn-primary")
    btn.setAttribute("type","button")
    btn.appendChild(i)
    btn.setAttribute("onclick","pencereac(5,"+pid+")")
    btn.setAttribute("title","Flufs")
    btn.setAttribute("type","button")
    div.appendChild(btn)
   
    var btn=document.createElement("button")  
    var i=document.createElement("i")
        i.setAttribute("class","icn-md icon-industry")
        i.setAttribute("style","margin:0px 0px 0px 0px !important;")
        btn.setAttribute("style","padding:10px;margin-left:5px")
    btn.setAttribute("class","btn btn-secondary")
    btn.setAttribute("type","button")
    btn.appendChild(i)
    btn.setAttribute("onclick","pencereac(-1,"+pid+")")
    btn.setAttribute("title","Ürün Özellikleri")
    btn.setAttribute("type","button")
    div.appendChild(btn)

    var btn=document.createElement("button")  
    var i=document.createElement("i")
        i.setAttribute("class","icn-md icon-chart")
        i.setAttribute("style","margin:0px 0px 0px 0px !important;")
        btn.setAttribute("style","padding:10px;margin-left:5px")
    btn.setAttribute("class","btn btn-info")
    btn.setAttribute("type","button")
    btn.appendChild(i)
    btn.setAttribute("onclick","pencereac(6,"+pid+")")
    btn.setAttribute("title","Boyutlar")
    btn.setAttribute("type","button")
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
   if(tip != -1){
     windowopen("/index.cfm?fuseaction=settings.partner_test_page&page="+tip+"&pid="+idd,"page")
   }else{
    windowopen('index.cfm?fuseaction=product.popup_form_upd_product_dt_property&pid='+idd,"page")
   }

}
</script>