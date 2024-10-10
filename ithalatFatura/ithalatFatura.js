var FaturaKalemleri = [];
var FaturaId = 0;
var RowCount = 1;
var OkutulmusArr = [];
function getFatura(el, ev) {
  if (el.value.length>0) {
    var InvoiceResult = wrk_query(
      "SELECT *,YEAR(INVOICE_DATE) AS IV_DATE FROM INVOICE WHERE INVOICE_NUMBER='" +
        el.value +
        "'",
      "dsn2"
    );
    if (InvoiceResult.recordcount > 0) {
      FaturaId = InvoiceResult.INVOICE_ID[0];
      document.getElementById("INVOICE_ID").value = FaturaId;
      document.getElementById("IV_DATE").value = InvoiceResult.IV_DATE[0];
      document.getElementById("lotumcu").removeAttribute("disabled");
      document.getElementById("lotumcu").setAttribute("class","ui-wrk-btn ui-wrk-btn-extra")
      document.getElementById("giri").removeAttribute("disabled");
      document.getElementById("giri").setAttribute("class","ui-wrk-btn ui-wrk-btn-red")
      
      el.setAttribute("disabled", "true");
      var InvoiceRows = wrk_query(
        "SELECT WRK_ROW_ID,INVOICE_ROW_ID,S.STOCK_ID,S.PRODUCT_ID,AMOUNT,S.PRODUCT_CODE,S.PRODUCT_CODE_2,S.PRODUCT_NAME FROM INVOICE_ROW LEFT JOIN "+dsn3+".STOCKS AS S ON S.STOCK_ID=INVOICE_ROW.STOCK_ID WHERE INVOICE_ID=" +
          FaturaId,
        "DSN2"
      );
      for (let index = 0; index < InvoiceRows.recordcount; index++) {
        var FaturaSatiri = {
          WRK_ROW_ID: InvoiceRows.WRK_ROW_ID[index],
          INVOICE_ROW_ID: InvoiceRows.INVOICE_ROW_ID[index],
          STOCK_ID: InvoiceRows.STOCK_ID[index],
          AMOUNT: InvoiceRows.AMOUNT[index],
          PRODUCT_CODE: InvoiceRows.PRODUCT_CODE[index],
          PRODUCT_CODE_2: InvoiceRows.PRODUCT_CODE_2[index],
          PRODUCT_NAME: InvoiceRows.PRODUCT_NAME[index],
          PRODUCT_ID: InvoiceRows.PRODUCT_ID[index],
        };
        FaturaKalemleri.push(FaturaSatiri);
      }
    } else {
      alert("Fatura Bulunamadı !");
      document.getElementById("lotumcu").setAttribute("disabled","yes");
      document.getElementById("lotumcu").setAttribute("class","ui-wrk-btn ui-wrk-btn-busy")
      document.getElementById("giri").setAttribute("disabled","yes");
      document.getElementById("giri").setAttribute("class","ui-wrk-btn ui-wrk-btn-busy")
    }
  }
}
function getLot(el, ev) {
  if (ev.keyCode == 13) {
    var SID = 0;
    var Q = wrk_query(
      "SELECT * FROM INVOICE_LOT_NUMBER_PARTNER WHERE LOT_NUMBER='" +
        el.value +
        "' AND INVOICE_ID=" +
        FaturaId,
      "dsn2"
    );
    if (Q.recordcount > 0) {
      SID = Q.STOCK_ID[0];
      var Q2 =
        "select COUNT(*) AS SCK from STOCKS_ROW WHERE LOT_NO='" +
        el.value +
        "'";
      var qr = wrk_query(Q2, "dsn2");
      if (qr.SCK[0] == "0") {
        var KL = FaturaKalemleri.findIndex(
          (P) => parseInt(P.PRODUCT_ID) == parseInt(SID)
        );
        if (KL != -1) {
          var Kalem = FaturaKalemleri[KL];
          if (OkutulmusArr.findIndex((p) => p == el.value) == -1) {
            satirEkle(
              Kalem.PRODUCT_ID,
              Kalem.STOCK_ID,
              Kalem.WRK_ROW_ID,
              Kalem.PRODUCT_NAME,
              Kalem.PRODUCT_CODE_2,
              el.value
            );

            OkutulmusArr.push(el.value);
          } else {
            alert(el.value + " Seri Nolu Ürün Daha Öncesinde Okutulmuş");
          }
        }
      } else {
        alert(el.value + " Seri Nolu Ürün Daha Öncesinde Okutulmuş");
      }
    } else {
      alert(el.value + " Seri Nolu Ürün Bu Faturada Tanımlı Değil");
    }
    el.value="";
  el.focus();
  }
  
}

/*
test
*/
function Girdim(){
  var idd= document.getElementById("INVOICE_ID").value ;
  windowopen("/index.cfm?fuseaction=settings.partner_test_page&page=8&INVOICE_ID="+idd,"page")
}
function satirEkle(
  PRODUCT_ID,
  STOCK_ID,
  WRK_ROW_ID,
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
  input.setAttribute("value", LOT_NO);
  td.appendChild(input);
  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "PRODUCT_ID_" + RowCount);
  input.setAttribute("value", PRODUCT_ID);
  td.appendChild(input);

  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "STOCK_ID_" + RowCount);
  input.setAttribute("value", STOCK_ID);
  td.appendChild(input);

  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "WRK_ROW_ID_" + RowCount);
  input.setAttribute("value", WRK_ROW_ID);
  td.appendChild(input);

  var input = document.createElement("input");
  input.setAttribute("type", "hidden");
  input.setAttribute("name", "AMOUNT_" + RowCount);
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
  document.getElementById("row_count").value = RowCount;
  RowCount++;
}

function Kaydet() {
  var rf=document.getElementById("raf").value;
if(rf.length==0) {
  alert("Raf Seçmediniz") 
  return false;
}
  $("#Form1").submit();
}
function Temizle() {
  window.location.href='/index.cfm?fuseaction=invoice.emptypopup_ithal_mal_girisi'
  $("#SEPETIM").html("");
  FaturaKalemleri = new Array();
  FaturaId = 0;
  RowCount = 1;
  OkutulmusArr = new Array();
}

function AcCanim(){
  openBoxDraggable('index.cfm?fuseaction=invoice.emptypopup_list_lotnumber&is_submit=1&INVOICE_ID='+FaturaId+'&group=1');
}