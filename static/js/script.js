(function($){
    $(window).on({
        "load" : setMenu
    });

    function setMenu() {
        var target = $(".j-listview-item-content");

        target.on("click", showMenu);
        target.find(".heart").on("click", setFavorite);

        function showMenu() {

          var $this      = $(this);
          var name       = $this.find(".name").text();
          var price      = $this.find(".price").text();
          var orderPrice = Number(price.split("￥")[1].split(',').join('').trim());
          var orderTotal = (loadData("order")) ? loadData("order") : [];
          var order      = {
            "name"  : name,
            "price" : orderPrice
          }

          orderTotal.push(order);
          
          if(confirm(name + '(' +price + ')を注文しますか？')) {
            alert("注文が完了しました。");
            localStorage.setItem("order", JSON.stringify(orderTotal));
          }
          
          return false;
        }
        
        return false;
    }

    function setFavorite() {
      var $this = $(this);

      if($this.hasClass("favorite")) {
        $this.removeClass("favorite");
      } else {
        $this.addClass("favorite");
      }

      return false;
    }

    /* -------------------------
    Load Data
    ------------------------- */
    function loadData(id) {
      return JSON.parse(localStorage.getItem(id));
    }

})(jQuery)