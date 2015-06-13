# -*- coding: utf-8 -*-
import os
import sys
import braintree
import tornado.web
import tornado.ioloop

merchant = os.getenv('merchant', '')
public_key = os.getenv('public_key', '')
private_key = os.getenv('private_key', '')


braintree.Configuration.configure(
    braintree.Environment.Sandbox,
    merchant,
    public_key,
    private_key,
    )


class PingPongHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("PONG")

    def post(self):
        self.write("PONG")


class TokenHandler(tornado.web.RequestHandler):
    def get(self):
        self.write('SUCCESS!!')


class PaymentHandler(tornado.web.RequestHandler):
    def get(self):
        total_amount = str(3)
        tax_amount = str(1)
        token = braintree.ClientToken.generate({'customer_id': ''})
        txn = braintree.Transaction(braintree.Environment.Sandbox, attributes={'token': token, 'amount': total_amount, 'tax_amount': tax_amount})
        txn.sale({'amount': total_amount, 'payment_method_nonce': 'fake-paypal-future-nonce'})
        self.write('OK: {}'.format(total_amount))


def main():
    port = int(os.getenv('VCAP_APP_PORT', 8000))

    application = tornado.web.Application([
        (r"/ping", PingPongHandler),
        (r"/payment/token", TokenHandler),
        (r"/payment/buy", PaymentHandler),
    ])
    application.listen(port)
    tornado.ioloop.IOLoop.current().start()

if __name__ == "__main__":
    sys.exit(main())
