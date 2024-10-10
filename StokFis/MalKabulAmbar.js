var RowCount = 1;
var Okutulan = [];
var Sepetim = [];
function getShelf(el, ev) {
  if (ev.keyCode == 13) {
    var qstr =
      "SELECT * FROM (SELECT SL.DEPARTMENT_LOCATION,PP.SHELF_CODE,PP.PRODUCT_PLACE_ID, PP.SHELF_CODE AS PPSS,SL.DEPARTMENT_ID,SL.LOCATION_ID FROM " +
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
      el.setAttribute("readonly", "yes");
      $("#LOT_NO").focus();
    } else {
      alert(Kelime_1);
    }
  }
}

function getLot(el, ev) {
  if (ev.keyCode == 13) {
    var qstr =
      "SELECT STOCK_ID,SUM(STOCK_IN-STOCK_OUT) AS BAKIYE , STORE,STORE_LOCATION,LOT_NO,SHELF_NUMBER FROM STOCKS_ROW AS SR";
    qstr +=
      " WHERE STORE=" +
      MalKabul.DEPARTMENT_ID +
      " AND STORE_LOCATION=" +
      MalKabul.LOCATION_ID +
      " AND LOT_NO='" +
      el.value +
      "' GROUP BY STOCK_ID,STORE,STORE_LOCATION,LOT_NO,SHELF_NUMBER";
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
          SatirEkle(
            ProductInfo.PRODUCT_ID[0],
            ProductInfo.STOCK_ID[0],
            ProductInfo.PRODUCT_NAME[0],
            ProductInfo.PRODUCT_CODE[0],
            ProductInfo.PRODUCT_CODE_2[0],
            queryResult.SHELF_NUMBER[0],
            el.value
          );
          Sepetim.push(Obj);
        } else {
          alert(el.value + Kelime_2);
        }
      } else {
        alert(el.value + Kelime_3);
      }
    } else {
      alert(el.value + Kelime_4);
    }
  }
}
function SatirSil(ela) {
  var el = ela.parentElement.parentElement;
  var Lot = $(el).find("#S_LOT_NO").val();
  $("#SEPETIM").find("tr").find("#S_LOT_NO").val();
  var ix = Sepetim.findIndex((P) => P.LOT_NO == Lot);
  Sepetim.splice(ix, 1);
  el.remove();
}
function SatirEkle(
  PRODUCT_ID,
  STOCK_ID,
  PRODUCT_NAME,
  PRODUCT_CODE,
  PRODUCT_CODE_2,
  SHELF_NUMBER,
  LOT_NO
) {
  var tr = document.createElement("tr");
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

  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "SHELF_NUMBER" + RowCount);
  input.setAttribute("ID", "SHELF_NUMBER");
  input.setAttribute("value", SHELF_NUMBER);
  td.appendChild(input);

  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerText = PRODUCT_CODE;
  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerText = PRODUCT_CODE_2;
  tr.appendChild(td);

  var td = document.createElement("td");
  td.innerText = PRODUCT_NAME;
  tr.appendChild(td);
  var td = document.createElement("td");
  var btn = document.createElement("button");
  btn.setAttribute("onclick", "SatirSil(this)");
  btn.setAttribute("class", "ui-wrk-btn ui-wrk-btn-red");
  var span = document.createElement("span");
  span.setAttribute("class", "icn-md icon-minus");
  btn.appendChild(span);
  td.appendChild(btn);
  tr.appendChild(td);
  document.getElementById("SEPETIM").appendChild(tr);
  //document.getElementById("row_count").value = RowCount;
  RowCount++;
  $("#LOT_NO").val("");
    $("#LOT_NO").focus("");
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

function Kaydet() {
  var rows = document.getElementById("SEPETIM").children;
  var Satirlar = [];
  for (let index = 0; index < rows.length; index++) {
    var row = rows[index];
    var PRODUCT_ID = $(row).find("#S_PRODUCT_ID").val();
    var STOCK_ID = $(row).find("#S_STOCK_ID").val();
    var AMOUNT = $(row).find("#S_AMOUNT").val();
    var LOT_NO = $(row).find("#S_LOT_NO").val();
    var SHELF_NUMBER = $(row).find("#SHELF_NUMBER").val();
    var Obj = {
      PRODUCT_ID: PRODUCT_ID,
      STOCK_ID: STOCK_ID,
      AMOUNT: AMOUNT,
      LOT_NO: LOT_NO,
      SHELF_NUMBER:SHELF_NUMBER
    };
    Satirlar.push(Obj);
  }
  var SHELF_CODE = document.getElementById("SHELF_CODE").value;
  var SHELF_ID = document.getElementById("SHELF_ID").value;
  var Datam = {
    SHELFDATA: {
      SHELF_CODE: SHELF_CODE,
      SHELF_ID: SHELF_ID,
    },
    ROWS: Satirlar,
    FROM_LOCATION_DATA: MalKabul,
    TO_LOCATION_DATA: Ambar,
  };
  console.log(Datam);
  console.table(Datam);
  SendFormData("/index.cfm?fuseaction=stock.emptypopup_save_ambar_fis", Datam);
}
