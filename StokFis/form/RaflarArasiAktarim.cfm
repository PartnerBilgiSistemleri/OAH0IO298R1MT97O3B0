<style>
  .inpox{
    font-size:12pt !important;
  }
</style>
<cf_box title="Raf Taşı">
<div class="form-group">
  <input type="text" class="inpox"  name="SHELF_NO" id="SHELF_NO" onkeyup="GetRaf(this,event)">
</div>
<div class="form-group" style="display:none" id="PPAREA">
  <input type="text" class="inpox"  name="LOT_NO" id="LOT_NO" onkeyup="GetProduct(this,event)">
</div>


<cfform>
<div>
  <div id="RafAlani" style="font-size:14pt;color:green;text-align:center">
  
  </div>
  <input type="hidden" name="ToShelfCode" id="ToShelfCode">
  <input type="hidden" name="ToShelfId" id="ToShelfId">
  <input type="hidden" name="ToStore" id="ToStore">
  <input type="hidden" name="ToLocation" id="ToLocation">
</div>
<div style="height:70vh">
<cf_big_list>
<thead>  <tr>
  <th></th>
  <th>SKU</th>
    
    <th>
      Ürün
    </th>
    <th>
      Lot No
    </th>
    <th>
      From Raf No
    </th>
    <th>
      To Raf No
    </th>
    <th></th>
  </tr>
</thead>
<tbody id="Basketim">

</tbody>
</cf_big_list>
</div>
<div class="form-group">
  <a id="ui-otherFileBtn_box_search_stock_list_purchase" onclick="Kaydet()" href="javascript://" class="ui-btn ui-btn-blue ui-btn-addon-right">Kaydet<i class="fa fa-save"></i></a>
</div>
</cfform>
<script>
  var DataSources={
    DSN:"<CFOUTPUT>#DSN#</CFOUTPUT>",
    DSN1:"<CFOUTPUT>#DSN1#</CFOUTPUT>",
    DSN2:"<CFOUTPUT>#DSN2#</CFOUTPUT>",
    DSN3:"<CFOUTPUT>#DSN3#</CFOUTPUT>"
  }
</script>


<script src="/AddOns/Partner/StokFis/RafAktarim.js"></script>


</cf_box>