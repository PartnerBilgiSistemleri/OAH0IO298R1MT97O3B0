<table>
    <tr>
        <td>

            	
<div class="form-group">
    <input type="text" name="SHELF_CODE" id="SHELF_CODE" onkeyup="getShelf(this,event)" placeholder="<cf_get_lang dictionary_id='37540.Raf Kodu'>">
    <input type="hidden" name="SHELF_ID" id="SHELF_ID" onkeyup="getShelf(this,event)">
</div>
</td>
<td>
<div class="form-group">
    <input type="text" name="LOT_NO" id="LOT_NO" onkeyup="getLot(this,event)" placeholder="<cf_get_lang dictionary_id='57637.Seri No'>(Lot No)">
</div>
</td>
<td>
    <input type="button" onclick="Kaydet()" value="<cf_get_lang dictionary_id='57461.Kaydet'>">
</td>
</tr>
</table>
<cf_big_list>	
    <thead>
        <tr>
            
            <th>
                <cf_get_lang dictionary_id='57637.Seri No'>(Lot No)
            </th>
           <th><cf_get_lang dictionary_id='58800.Ürün Kodu'></th>
           <th><cf_get_lang dictionary_id='57789.Özel Kod'> </th>
        <th>
            <cf_get_lang dictionary_id='44019.Ürün'>
        </th>
       
        <th></th>
    </tr>
    </thead>
    <tbody id="SEPETIM">

    </tbody>
</cf_big_list>
<script>
    <cfoutput>
        var DsnList={
            DSN:"#dsn#",
            DSN2:"#dsn2#",
            DSN3:"#dsn3#",
            DSN1:"#dsn1#"
        }
        //66401		
        var Kelime_1="<cf_get_lang dictionary_id='66399.Raf Bulunamadı'>"	
        var Kelime_2="<cf_get_lang dictionary_id='66400.Seri (Lot) Nolu Ürün Daha Önce Okutulmuş'>"	
        var Kelime_3="<cf_get_lang dictionary_id='66401.Seri (Lot) Nolur Ürünün Stoğu Yetersiz'>"
        var Kelime_4="<cf_get_lang dictionary_id='66402.Seri (Lot) Numarası Mal Kabul Lokasyonunda Bulunamadı'>"	

    </cfoutput>
    var MalKabul={
        DEPARTMENT_ID:1,
        LOCATION_ID:0
    };
    var Fiktif={
        DEPARTMENT_ID:31,
        LOCATION_ID:1
    }
    var Ambar={
        DEPARTMENT_ID:1,
        LOCATION_ID:2
    }
    var CustomDepolar={
        MalKabul:MalKabul,
        Fiktif:Fiktif,
        Ambar:Ambar
    }
</script>

<script src="/AddOns/Partner/StokFis/MalKabulAmbar.js"></script>