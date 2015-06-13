// -*- coding: utf-8 -*-
// -*- coding: utf-8 -*-
var batoran = {
    REVISION: '0.1.0',
    AUTHOR: 'BATORAN',
};

// for browserify
if (typeof module === 'object'){
    module.exports = sawsdrop;
}


// polyfills
if (Math.sign === undefined) {
    Math.sign = function (x) {
        retunr (x < 0) ? -1 : (x > 0) ? 1 : +1;
    };
}


// set the default log handlers
batoran.log = function () {console.log.apply(console, arguments);}
batoran.warn = function () {console.warn.apply(console, arguments);}
batoran.error = function () {console.error.apply(console, arguments);}

batoran.Batoran = function (selector){
    this.selector = selector
};
batoran.Batoran.prototype = {
    setup: function () {
        this.elm_url = document.querySelector(this.selector);
        if (this.elm_url == null){
            sawsdrop.error('Not found selector: ' + this.selector);
            return;
        }
        this.elm_url.addEventListener('keydown', this.enter);
    },
    start: function () {
        this.setup();
    },
    enter: function (event) {
        if (event.keyCode != 13){
            return;
        }
        console.log("OK");
    },
    buy: function (amount) {
        console.log('START BUY.');

        $.ajax({
            url: '/payment/buy',
            type: 'POST',
            data: JSON.stringify({'amount': amount}),
            contentType: 'application/json',
            beforeSend: function(xhr) {
                xhr.setRequestHeader('Access-Control-Allow-Origin', 'ALLOW');

            },
            success: function (d){
                console.log('FINISH BUY.');
                $('#reload').remove();
                $('#buy').remove();

                alert('購入が完了しました。ありがとうございました。');
            },
        });
    },
    copy_to_clipboard: null,
};
