function paypal() {
    var order = loadData("order");
    var length = order.length;
    var total = 0;
    for(var i = 0; i < length; i++) {
        var data  = order[i];
        var price = data.price;
        total += price;
    }


    var bt = new batoran.Batoran();
    bt.buy(total);
    return false;
}

function setOrder() {
  var parent = $("#orderlist");
  var total  = 0;
  var order  = (loadData("order")) ? loadData("order") : [{
    "name"  : "注文はありません。",
    "price" : total
  }];
  var length = order.length;
  var html   = "";

  for(var i = 0; i < length; i++) {
    var data  = order[i];
    var name  = data.name;
    var price = data.price;

    html += '<li>' + name + '<span>￥' + separate(price) + '</span></li>';

    total += price;
  }

  parent.html(html);
  $("#total").html("合計：<span>￥" + separate(total) + "</span>");

  return false;
}

/* -------------------------
Load Data
------------------------- */
function loadData(id) {
  return JSON.parse(localStorage.getItem(id));
}

function separate(num) {
  return String(num).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,');
}
