<cf_box title="Stok Bul">
    <div class="form-group" style="display:flex">
<input type="text" style="font-size:25pt;width:85% !important" name="PRODUCT_CODE_2" placeholder="SKU" id="PRODUCT_CODE_2" onkeyup="searchSKU(this.value,event)">
<select name="fmdMain" id="fmdMain" style="font-size:25pt;width:15% !important">
  <option value="">Tüm Depolar</option>
  <cfquery name="GETDDDD" datasource="#DSN#">
      SELECT D.BRANCH_ID,SL.DEPARTMENT_ID,SL.LOCATION_ID,D.DEPARTMENT_HEAD,SL.COMMENT FROM catalyst_prod.STOCKS_LOCATION AS SL LEFT JOIN catalyst_prod.DEPARTMENT AS D ON SL.DEPARTMENT_ID=D.DEPARTMENT_ID ORDER BY D.DEPARTMENT_ID,LOCATION_ID
  </cfquery>
  <cfoutput query="GETDDDD" group="DEPARTMENT_ID">
    <optgroup label="#DEPARTMENT_HEAD#">
      <cfoutput>
        <option value="#BRANCH_ID#*#DEPARTMENT_ID#*#LOCATION_ID#">#COMMENT#</option>
      </cfoutput>
    </optgroup>
  </cfoutput>
</select>

</div>
<div id="btn1" onclick="BekleyenAc(this)" class="btn btn-primary" data-stock_id="" style="width: 100%;font-size: 20pt;padding-top: 10px;padding-bottom: 10px;margin-top: 5px;display:none">Bekleyen Siparişler</div>
<div id="btn2" onclick="AlinanAc(this)" class="btn btn-success" data-stock_id="" style="width: 100%;font-size: 20pt;padding-top: 10px;padding-bottom: 10px;margin-top: 5px;display:none">Alınan Siparişler</div>
<div id="btn3" onclick="BeklenenAc(this)" class="btn btn-warning" data-stock_id="" style="width: 100%;font-size: 20pt;padding-top: 10px;padding-bottom: 10px;margin-top: 5px;display:none">Beklenen Siparişler</div>
<div >
  <table class="table">
      <tr>
        <th>
          Depo
        </th>
        <th>
          Bekleyen
        </th>
        <th>
          Satılabilir
        </th>
        <th>
          Beklenen
        </th>
      </tr>
      <tr>
        <td>10</td>
        <td>20</td>
        <td>30</td>
        <td>40</td>
      </tr>
  </table>
</div>
<hr>
<div style="display:flex">
    <div style="width:50%">
      <div id="StokDetay" >

      </div>
      <div id="Bekleyen">

      </div>
      <div id="Alinan">

      </div>
      <div id="Verilen">

      </div>
    </div>
    <div style="width:25%;display: flex;flex-direction: column;" >
        <div id="Lokasyon">
            
        </div>
        
    </div>
    <div style="width:25%;display: flex;flex-direction: column;" >
    <div id="LotDetay">

    </div>
    <div id="GraphArea">
            
    </div>
  </div>
</div>

</cf_box>

<script>
function BekleyenAc(el){
  sid=el.getAttribute("data-stock_id")
  var str="index.cfm?fuseaction=objects.popup_reserved_orders_pbs&taken=1&nosale_order_location=0&sid="+sid
  windowopen(str,"wide")
}
function AlinanAc(el){
  sid=el.getAttribute("data-stock_id")
  var str="index.cfm?fuseaction=objects.popup_reserved_orders&taken=1&nosale_order_location=0&sid="+sid
  windowopen(str,"wide")
}
function BeklenenAc(el){
  sid=el.getAttribute("data-stock_id")
  var str="index.cfm?fuseaction=objects.popup_reserved_orders&taken=0&nosale_order_location=0&pid="+sid
  windowopen(str,"wide")
}
    function searchSKU(v,e) {
        console.log(v);
        console.log(e.keyCode)
        var dpEl=document.getElementById("fmdMain")
var branch_id=list_getat(dpEl.value,1,"*")
var department_id=list_getat(dpEl.value,2,"*")
var location_id=list_getat(dpEl.value,3,"*")
var slx=dpEl.selectedIndex
var dpName=dpEl.options[slx].innerText
console.table({
    branch_id:branch_id,
    department_id:department_id,
    location_id:location_id,
    dpName:dpName
})
      
        if(e.keyCode==13){
            var Sresult=wrk_query("SELECT * FROM STOCKS WHERE PRODUCT_CODE_2='"+v+"'","dsn3")
           console.log(Sresult)
            if(Sresult.recordcount>0){
              var str="index.cfm?fuseaction=stock.detail_stock_popup_pbs&list_type=3&pid="+Sresult.PRODUCT_ID[0]+"&stock_id="+Sresult.STOCK_ID[0]
               
              if(department_id.length>0){
                str+="&cat=&list_type=3&maxrows=20&branch_id=&department_id_="+department_id+"&location_id="+location_id+"&location_name="+dpName+"&row_project_id=&row_project_head=&product_name="+Sresult.PRODUCT_NAME[0]+"&spec_main_id=&spec_name=&startdate=&finishdate=" 
              }
                AjaxPageLoad(
    str,
    "StokDetay",
    1,
    "Yükleniyor"
  );
  AjaxPageLoad(
    "index.cfm?fuseaction=stock.detail_store_stock_popup&product_id="+Sresult.PRODUCT_ID[0]+"&stock_id="+Sresult.STOCK_ID[0],
    "Lokasyon",
    1,
    "Yükleniyor"
  );
  AjaxPageLoad(
    "index.cfm?fuseaction=stock.popup_stock_graph_ajax&pid="+Sresult.PRODUCT_ID[0]+"&stock_code="+Sresult.STOCK_CODE[0],
    "GraphArea",
    1,
    "Yükleniyor"
  );
  AjaxPageLoad(
    "index.cfm?fuseaction=stock.emptypopup_detail_stock_lot&stock_id="+Sresult.STOCK_ID[0]+"&stock_code="+Sresult.STOCK_CODE[0],
    "LotDetay",
    1,
    "Yükleniyor"
  );
  // AjaxPageLoad(
  //   "index.cfm?fuseaction=objects.popup_reserved_orders&taken=1&pid="+Sresult.PRODUCT_ID[0]+"&stock_code="+Sresult.STOCK_CODE[0],
  //   "Alinan",
  //   1,
  //   "Yükleniyor"
  // );
  // AjaxPageLoad(
  //   "index.cfm?fuseaction=objects.popup_reserved_orders&taken=0&nosale_order_location=0&pid="+Sresult.PRODUCT_ID[0],
  //   "Verilen",
  //   1,
  //   "Yükleniyor"
  // );
  /*AjaxPageLoad(
    "index.cfm?fuseaction=objects.popup_reserved_orders_pbs&taken=1&nosale_order_location=0&sid="+Sresult.STOCK_ID[0],
    "Bekleyen",
    1,
    "Yükleniyor"
  );*/
  document.getElementById("btn1").setAttribute("data-stock_id",Sresult.STOCK_ID[0])
  document.getElementById("btn2").setAttribute("data-stock_id",Sresult.STOCK_ID[0])
  document.getElementById("btn3").setAttribute("data-stock_id",Sresult.STOCK_ID[0])
  $("#btn1").show()
  $("#btn2").show()
  $("#btn3").show()
  MerhabaDe()
            }
        }


    }

    function MerhabaDe(params) {
      $(".ui-form-list").remove()
$(".ui-otherFileTitle").remove()
$(".ui-otherFile").remove()
}
</script>

