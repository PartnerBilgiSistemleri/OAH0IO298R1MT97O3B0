$(document).ready(function(){
    $("#SHELF_NO").focus();
})
var RowCount = 0;
var SepetArr = [];
function GetRaf(el, ev) {
    if (ev.keyCode == 13) {
        var Res = wrk_query("SELECT * FROM PRODUCT_PLACE WHERE SHELF_CODE='" + el.value + "'", "dsn3")
        console.log(Res);
        if (Res.recordcount == 0) alert("Raf Bulunamadı");
        else if (Res.recordcount > 1) alert("Aynı Kodda Birden Fazla Raf Var Raf Tanımlarını Kontorol Ediniz");
        else if (Res.recordcount == 1) SetActiveShelf(Res.SHELF_CODE, Res.PRODUCT_PLACE_ID, Res.STORE_ID, Res.LOCATION_ID, el)
    }
}

function SetActiveShelf(SHELF_CODE, PRODUCT_PLACE_ID, STORE_ID, LOCATION_ID, el) {
    el.setAttribute("style", "color:green;font-weight:bold");
    el.setAttribute("disabled", "true");
    $("#PPAREA").show();
    $("#RafAlani").text(SHELF_CODE)
    $("#ToShelfCode").val(SHELF_CODE)
    $("#ToShelfId").val(PRODUCT_PLACE_ID)
    $("#ToStore").val(STORE_ID)
    $("#ToLocation").val(LOCATION_ID)


$("#LOT_NO").focus();

}



function GetProduct(el, ev) {
    if (ev.keyCode == 13) {
        var Qstr = "SELECT STR.LOT_NO,STR.STORE,STR.STORE_LOCATION,PP.SHELF_CODE,S.PRODUCT_NAME,S.PRODUCT_CODE_2,S.PRODUCT_ID,S.STOCK_ID,PP.PRODUCT_PLACE_ID FROM " + DataSources.DSN2 + ".STOCKS_ROW AS STR"
        Qstr += " LEFT JOIN " + DataSources.DSN3 + ".STOCKS AS S ON S.STOCK_ID=STR.STOCK_ID LEFT JOIN " + DataSources.DSN3 + ".PRODUCT_PLACE AS PP ON PP.PRODUCT_PLACE_ID=STR.SHELF_NUMBER WHERE LOT_NO='" + el.value + "'"
        var Res = wrk_query(Qstr, "dsn2");
        console.log(Res);

        var Qstr2 = "SELECT SUM(STOCK_IN-STOCK_OUT) AS SFR FROM STOCKS_ROW WHERE LOT_NO='" + el.value + "' AND SHELF_NUMBER=" + Res.PRODUCT_PLACE_ID[0];
        var Res2 = wrk_query(Qstr2, "dsn2");
        if (parseInt(Res2.SFR[0]) > 0) {
            RowCount++;
            var tr = document.createElement("tr");
            tr.setAttribute("class", "basket_row");
            tr.setAttribute("data-row_id", RowCount);
            tr.id = "ROW_" + RowCount;
            var td = document.createElement("td")
            //td.innerText = RowCount;
            var spn = document.createElement("span");
            spn.innerText = RowCount;
            spn.id = "PNAME_" + RowCount;
            spn.name = "PNAME";
            td.appendChild(spn);
            var inp = document.createElement("input");
            inp.name = "PRODUCT_ID";
            inp.id = "PRODUCT_ID_" + RowCount;
            inp.value = Res.PRODUCT_ID[0]
            inp.type = "hidden"
            td.appendChild(inp)
            var inp = document.createElement("input");
            inp.name = "STOCK_ID";
            inp.id = "STOCK_ID" + RowCount;
            inp.value = Res.STOCK_ID[0]
            inp.type = "hidden"
            td.appendChild(inp)
            tr.appendChild(td);
            var td = document.createElement("td");
            td.innerText = Res.PRODUCT_CODE_2[0]
            tr.appendChild(td);
            var td = document.createElement("td");
            td.innerText = Res.PRODUCT_NAME[0]
            tr.appendChild(td);
            var td = document.createElement("td");
            td.innerText = Res.LOT_NO[0]
            tr.appendChild(td);
            var td = document.createElement("td");
            td.innerText = Res.SHELF_CODE[0];
            var inp = document.createElement("input");
            inp.type = "hidden"
            inp.value = Res.PRODUCT_PLACE_ID[0];
            inp.id = "FROM_SHELF_ID_" + RowCount;
            inp.name = "FROM_SHELF_ID";
            td.appendChild(inp);
            var inp = document.createElement("input");
            inp.type = "hidden"
            inp.value = Res.STORE[0];
            inp.id = "FROM_DEPARTMENT_" + RowCount;
            inp.name = "FROM_DEPARTMENT";
            td.appendChild(inp);
            var inp = document.createElement("input");
            inp.type = "hidden"
            inp.value = Res.STORE_LOCATION[0];
            inp.id = "FROM_LOCATION_" + RowCount;
            inp.name = "FROM_LOCATION";
            td.appendChild(inp);
            tr.appendChild(td);

            var td = document.createElement("td");
            td.innerText = document.getElementById("ToShelfCode").value;
            var inp = document.createElement("input");
            inp.type = "hidden"
            inp.value = document.getElementById("ToShelfId").value
            inp.id = "TO_SHELF_ID_" + RowCount;
            inp.name = "TO_SHELF_ID";
            td.appendChild(inp);
            var inp = document.createElement("input");
            inp.type = "hidden"
            inp.value = document.getElementById("ToStore").value
            inp.id = "TO_DEPARTMENT_" + RowCount;
            inp.name = "TO_DEPARTMENT";
            td.appendChild(inp);
            var inp = document.createElement("input");
            inp.type = "hidden"
            inp.value = document.getElementById("ToLocation").value
            inp.id = "TO_LOCATION_" + RowCount;
            inp.name = "TO_LOCATION";
            td.appendChild(inp);
            tr.appendChild(td);
            var td = document.createElement("td");
            var a = document.createElement("a");
            var i = document.createElement("i");
            i.setAttribute("class", "fa fa-remove");
            a.appendChild(i);
            a.setAttribute("onclick", "SatirSil(" + RowCount + ")")
            a.href = "javascript://"
            td.appendChild(a);
            tr.appendChild(td);

          
            document.getElementById("Basketim").appendChild(tr);

            var Obj = {
                RowId: RowCount,
                PRODUCT_ID: Res.PRODUCT_ID[0],
                STOCK_ID: Res.STOCK_ID[0],
                LOT_NO: Res.LOT_NO[0],
                FROM_SHELF_CODE: Res.SHELF_CODE[0],
                FROM_SHELF_ID: Res.PRODUCT_PLACE_ID[0],
                FROM_DEPARTMENT: Res.STORE[0],
                FROM_LOCATION: Res.STORE_LOCATION[0],
                TO_SHELF_CODE: document.getElementById("ToShelfCode").value,
                TO_SHELF_ID: document.getElementById("ToShelfId").value,
                TO_DEPARTMENT: document.getElementById("ToStore").value,
                TO_LOCATION: document.getElementById("ToLocation").value,
            }

            SepetArr.push(Obj);

            $("#LOT_NO").val("");
            $("#LOT_NO").focus();

        }
    }
}

function SatirSil(rc) {
    $("#ROW_" + rc).remove();
    SepetArr.splice((rc - 1), 1);
    var sx = document.getElementsByClassName("basket_row")
    for (let i = 0; i < sx.length; i++) {
        var si = sx[i];
        console.log(si)
        $(si).find("span")[0].innerText = i + 1;

    }
}

function Kaydet(){
    $.ajax({
        url:"/AddOns/Partner/StokFis/cfc/StokFis.cfc?method=SaveRafTasi",
        data:{
            data:JSON.stringify(SepetArr)
        },
        success:function(retdat){
            var o=JSON.parse(retdat);
            alert(o.MESSAGE);
            if(o.STATUS==1){
                window.location.reload();
            }
        }
    }).done(function(){
        window.location.reload();
    })
}