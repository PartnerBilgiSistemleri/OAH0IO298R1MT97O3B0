var RowCount = 0;
var Okutulan = [];
var Sepetim = [];
function getShelf(el, ev) {
  if (ev.keyCode == 13) {
    var qstr =
      "SELECT * FROM (SELECT SL.DEPARTMENT_LOCATION,PP.SHELF_CODE,PP.PRODUCT_PLACE_ID, SL.DEPARTMENT_LOCATION+'-'+PP.SHELF_CODE AS PPSS,SL.DEPARTMENT_ID,SL.LOCATION_ID FROM " +
      DsnList.DSN3 +
      ".PRODUCT_PLACE AS PP";
    qstr +=
      " INNER JOIN " +
      DsnList.DSN +
      ".STOCKS_LOCATION AS SL ON SL.LOCATION_ID=PP.LOCATION_ID AND SL.DEPARTMENT_ID=PP.STORE_ID ) AS TK WHERE PPSS='" +
      el.value +
      "'";
    var queryResult = wrk_query(qstr, "dsn");
    if (queryResult.recordcount > 0) {
      document.getElementById("SHELF_ID").value =
        queryResult.PRODUCT_PLACE_ID[0];
      $("#LOT_NO").focus();
    } else {
      alert("Raf Bulunamadı");
    }
  }
}

function getLot(el, ev) {
  if (ev.keyCode == 13) {
    var qstr =
      "SELECT STOCK_ID,SUM(STOCK_IN-STOCK_OUT) AS BAKIYE , STORE,STORE_LOCATION,LOT_NO FROM STOCKS_ROW AS SR";
    qstr +=
      " WHERE STORE=" +
      MalKabul.DEPARTMENT_ID +
      " AND STORE_LOCATION=" +
      MalKabul.LOCATION_ID +
      " AND LOT_NO='" +
      el.value +
      "' GROUP BY STOCK_ID,STORE,STORE_LOCATION,LOT_NO";
    var queryResult = wrk_query(qstr, "dsn2");
    if (queryResult.recordcount > 0) {
      var Bakiye = parseFloat(queryResult.BAKIYE[0]);
      if (Bakiye > 0) {
        var ProductInfo = wrk_query(
          "SELECT * FROM STOCKS WHERE STOCK_ID=" + queryResult.STOCK_ID[0],
          "DSN3"
        );
        var Obj = {
          PRODUCT_ID: ProductInfo.PRODUCT_ID[0],
          STOCK_ID: ProductInfo.STOCK_ID[0],
          LOT_NO: el.value,
        };
        var kk = Sepetim.findIndex((p) => p.LOT_NO == el.value);
        if (kk == -1) {
          SatirEkle(ProductInfo.PRODUCT_ID[0],ProductInfo.STOCK_ID[0],ProductInfo.PRODUCT_NAME[0],ProductInfo.PRODUCT_CODE[0],el.value);
        } else {
          alert(el.value + " Seri (Lot) Nolu Ürün Daha Önce Okutulmuş");
        }
      } else {
        alert(el.value + "Seri (Lot) Nolur Ürünün Stoğu Yetersiz");
      }
    } else {
      alert(el.value + "Seri (Lot) Numarası Mal Kabul Lokasyonunda Bulunamadı");
    }
  }
}
function SatirEkle(
    PRODUCT_ID,
    STOCK_ID,    
    PRODUCT_NAME,
    PRODUCT_CODE,
    LOT_NO
  ) {
    var tr = document.createElement("tr");
    var td = document.createElement("td");
    td.innerText = RowCount;
    tr.appendChild(td);
    var td = document.createElement("td");
    td.innerText = LOT_NO;
    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("name", "LOT_NO_" + RowCount);
    input.setAttribute("ID", "S_LOT_NO");
    input.setAttribute("value", LOT_NO);
    td.appendChild(input);
    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("name", "PRODUCT_ID_" + RowCount);
    input.setAttribute("ID", "S_PRODUCT_ID");
    input.setAttribute("value", PRODUCT_ID);
    td.appendChild(input);
  
    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("name", "STOCK_ID_" + RowCount);
    input.setAttribute("ID", "S_STOCK_ID");
    input.setAttribute("value", STOCK_ID);
    td.appendChild(input);      
    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("name", "AMOUNT_" + RowCount);
    input.setAttribute("ID", "S_AMOUNT");
    input.setAttribute("value", 1);
    td.appendChild(input);
    tr.appendChild(td);
    var td = document.createElement("td");
    td.innerText = PRODUCT_CODE;
    tr.appendChild(td);
    var td = document.createElement("td");
    td.innerText = PRODUCT_NAME;
    tr.appendChild(td);
    document.getElementById("SEPETIM").appendChild(tr);
    //document.getElementById("row_count").value = RowCount;
    RowCount++;
    
  }

function SendFormData(uri, BasketData) {
  var mapForm = document.createElement("form");
  mapForm.target = "Map";
  mapForm.method = "POST"; // or "post" if appropriate
  mapForm.action = uri;

  var mapInput = document.createElement("input");
  mapInput.type = "hidden";
  mapInput.name = "data";
  mapInput.value = JSON.stringify(BasketData);
  mapForm.appendChild(mapInput);

  document.body.appendChild(mapForm);

  map = window.open(
    uri,
    "Map",
    "status=0,title=0,height=600,width=800,scrollbars=1"
  );

  if (map) {
    mapForm.submit();
  } else {
    alert("You must allow popups for this map to work.");
  }
}
