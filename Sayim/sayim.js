var PRODUCT_ID = "";
var STOCK_ID = "";
var PRODUCT_CODE = "";
var PRODUCT_CODE_2 = "";
var SHELF_CODE = "";
var DEPARTMENT_ID = "";
var LOCATION_ID = "";
var LOT_NO = "";
var RC = 1;

function getProduct(el, ev, productCodeArea) {
  if (ev.keyCode == 13) {
    var GetProductQuery =
      "SELECT PRODUCT_ID,STOCK_ID,PRODUCT_CODE,PRODUCT_CODE_2 FROM STOCKS WHERE " +
      productCodeArea +
      "= '" +
      el.value.trim() +
      "'";
    var GetProductResult = wrk_query(GetProductQuery, "dsn3");
    if (GetProductResult.recordcount > 0) {
      PRODUCT_ID = GetProductResult.PRODUCT_ID[0];
      STOCK_ID = GetProductResult.STOCK_ID[0];
      PRODUCT_CODE = GetProductResult.PRODUCT_CODE[0];
      PRODUCT_CODE_2 = GetProductResult.PRODUCT_CODE_2[0];
      if (SayimSettings.is_lot_no == 1) {
        $("#LOT_NO").focus();
      } else {
        satirEkle();
      }
    } else {
      alert(Kelime_1);
      return false;
    }
  }
}

function GetShelf(el, ev) {
  if (ev.keyCode == 13) {
    var str = document.getElementById("DEPOLAMA").value;
    var STORE_ID = list_getat(str, 1, "-");
    var LOCATION_ID = list_getat(str, 2, "-");
    var SHELF_CODE_ = el.value;

    var GetShelfQuery =
      "SELECT * FROM PRODUCT_PLACE WHERE STORE_ID=" +
      STORE_ID +
      " AND LOCATION_ID=" +
      LOCATION_ID +
      " AND SHELF_CODE='" +
      SHELF_CODE_ +
      "'";
    GetShelfResult = wrk_query(GetShelfQuery, "dsn3");
    if (GetShelfResult.recordcount > 0) {
      SHELF_CODE = GetShelfResult.SHELF_CODE[0];
      DEPARTMENT_ID = GetShelfResult.STORE_ID[0];
      LOCATION_ID = GetShelfResult.LOCATION_ID[0];
      if (SayimSettings.is_product_code == 1) {
        $("#PRODUCT_CODE").focus();
        return true;
      }
      if (SayimSettings.is_lot_no == 1) {
        $("#LOT_NO").focus();
        return true;
      }
    } else {
      alert(Kelime_2);
      return false;
    }
  }
}

function getLotNo(el, ev, productCodeArea) {
  var LotNumarasi = el.value;
  if (ev.keyCode == 13) {
    if (SayimSettings.is_product_code == 0) {
      var GetLotNoQuery =
        "SELECT TOP 1 S.PRODUCT_NAME,S.PRODUCT_ID,S.STOCK_ID,SR.LOT_NO,S.PRODUCT_CODE_2,S.PRODUCT_CODE FROM catalyst_prod_2024_1.STOCKS_ROW AS SR LEFT JOIN catalyst_prod_1.STOCKS AS S ON S.STOCK_ID=SR.STOCK_ID WHERE LOT_NO='" +
        LotNumarasi +
        "'";
      var GetLotNoResult = wrk_query(GetLotNoQuery, "dsn2");
      console.log(GetLotNoResult);
      if (GetLotNoResult.recordcount>0) {
        PRODUCT_ID = GetLotNoResult.PRODUCT_ID[0];
        STOCK_ID = GetLotNoResult.STOCK_ID[0];
        PRODUCT_CODE = GetLotNoResult.PRODUCT_CODE[0];
        LOT_NO = GetLotNoResult.LOT_NO[0];
        PRODUCT_CODE_2 = GetLotNoResult.PRODUCT_CODE_2[0];
        satirEkle();
      } else {
        console.log("Burası")
        alert(Kelime_3);
      }
    } else {
      LOT_NO = LotNumarasi;
      satirEkle();
    }
  }
}
function SatirSil(e) {
  console.log(e)
  var ex = e.parentElement.parentElement
  console.log(ex)
  ex.remove()
  //STOCK_ID_1 SHELF_CODE1
  var elemanlar = document.getElementsByClassName("TRC_000")
  console.log(elemanlar)
  for (let i = 0; i < elemanlar.length; i++) {
    var Satir = elemanlar[i];
    $(Satir).find("#PRODUCT_ID_")[0].setAttribute("name", "PRODUCT_ID_" + (i + 1));
    $(Satir).find("#STOCK_ID_")[0].setAttribute("name", "STOCK_ID_" + (i + 1));
    $(Satir).find("#PRODUCT_CODE")[0].setAttribute("name", "PRODUCT_CODE" + (i + 1));
    $(Satir).find("#PRODUCT_CODE_2")[0].setAttribute("name", "PRODUCT_CODE_2" + (i + 1));
    $(Satir).find("#LOT_NO")[0].setAttribute("name", "LOT_NO" + (i + 1));
    $(Satir).find("#SHELF_CODE")[0].setAttribute("name", "SHELF_CODE" + (i + 1));
    $("#RC").val(elemanlar.length);
    RC = elemanlar.length;

  }
}

function satirEkle(params) {
  var str = document.getElementById("DEPOLAMA").value;
  var STORE_ID = list_getat(str, 1, "-");
  var LOCATION_ID = list_getat(str, 2, "-");
  var tr = document.createElement("tr");
  tr.setAttribute("class", "TRC_000");
  var td = document.createElement("td");
  td.innerText = LOT_NO;
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "PRODUCT_ID_" + RC);
  input.setAttribute("Id", "PRODUCT_ID_");
  input.setAttribute("value", PRODUCT_ID);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "STOCK_ID_" + RC);
  input.setAttribute("Id", "STOCK_ID_");
  input.setAttribute("value", STOCK_ID);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "PRODUCT_CODE" + RC);
  input.setAttribute("Id", "PRODUCT_CODE");
  input.setAttribute("value", PRODUCT_CODE);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "PRODUCT_CODE_2" + RC);
  input.setAttribute("Id", "PRODUCT_CODE_2");
  input.setAttribute("value", PRODUCT_CODE_2);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "LOT_NO" + RC);
  input.setAttribute("Id", "LOT_NO");
  input.setAttribute("value", LOT_NO);
  td.appendChild(input);
  tr.appendChild(td);
  var td = document.createElement("td");
  td.innerText = PRODUCT_CODE_2;
  tr.appendChild(td);
  if (SayimSettings.is_rafli == 1) {
    var td = document.createElement("td");
    td.innerText = SHELF_CODE;
    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("name", "SHELF_CODE" + RC);
    input.setAttribute("Id", "SHELF_CODE");
    input.setAttribute("value", SHELF_CODE);
    td.appendChild(input);

    tr.appendChild(td);
  }

  var td = document.createElement("td");
  td.innerText = 1;
  tr.appendChild(td);
  var td = document.createElement("td");
  var btn = document.createElement("button");
  btn.setAttribute("type", "button");
  btn.innerText = "Sil"
  btn.setAttribute("onclick", "SatirSil(this)");
  td.appendChild(btn);
  tr.appendChild(td);
  document.getElementById("SayimTable").appendChild(tr);
  debugger;
  if (SayimSettings.is_product_code == 1) {
    $("#PRODUCT_CODE").val("");
    $("#LOT_NO").val("");
    $("#PRODUCT_CODE").focus();
  } else {
    $("#LOT_NO").val("");
    $("#LOT_NO").focus();
  }
  PRODUCT_ID = "";
  STOCK_ID = "";
  PRODUCT_CODE = "";
  PRODUCT_CODE_2 = "";
  DEPARTMENT_ID = "";
  LOCATION_ID = "";
  LOT_NO = "";
  $("#RC").val(RC);
  RC++;
}

function setDept(el) {
  el.setAttribute("readonly", "true");
  $("#TXT_DEPARTMENT_IN").val(el.value);
  $("#LotNo").focus();
}

function MerhabaDE() {
  alert("Merhaba Canım");
}
