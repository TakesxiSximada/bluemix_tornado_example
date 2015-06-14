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
          var price      = $this.find(".price").find("span").text();
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

            if($this.hasClass("chance")) {

              var reset = $this.find("del").text();
              $this.find(".price").html('<span>' + reset + '</span>');
              $this.removeClass("chance").find(".chance").remove();

            }
          }
          
          return false;
        }
        
        return false;
    }

    function setFavorite() {
      var parent = $(this).closest(".j-listview-item-content");
      $(this).toggleClass("favorite");

      parent.addClass("chance");

      setTimeout(function(){ showChance(parent); }, 3000);

      return false;
    }

    function showChance(p) {

      p.css("position", 'relative');
      p.append('<span class="chance" style="width: 100px; text-indent:0; position:absolute; top:-20px; left:-15px; display:block; text-align:center; background:#f00; color:#fff; padding:5px 0;">Chance!!</span>');

      var chance = p.find(".chance");
      var price = p.find(".price").text();
      jump();
      setInterval(jump,800);

      function jump() {
        chance.stop().animate({
          'top' : -10
        }, 200).animate({
          'top' : -15
        }, 80).animate({
          'top' : -10
        }, 80).animate({
          'top' : -20
        }, 180);
      }

      var discount = Number(price.split("￥")[1].split(',').join('').trim()) - 20;

      p.find(".price").html('<del style="margin-right:15px;">' + price + "</del><span>￥" + separate(discount) + "</span>");

      var timer = setTimeout(function(){

        if(!p.find("del").length) {
          clearTimeout(timer);
          return false;
        }

        var reset = p.find("del").text();
        p.find(".price").html('<span>' + reset + '</span>');
        p.removeClass("chance").find(".chance").remove();

      }, 10000);

      return false;
    }

    function separate(num) {
      return String(num).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,');
    }

    /* -------------------------
    Load Data
    ------------------------- */
    function loadData(id) {
      return JSON.parse(localStorage.getItem(id));
    }

})(jQuery)