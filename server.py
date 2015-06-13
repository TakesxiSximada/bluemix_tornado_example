# -*- coding: utf-8 -*-
import six
import os
import sys
import json
import braintree
import tornado.web
import tornado.ioloop
from tornado.web import StaticFileHandler

if six.PY3:
    from urllib.parse import urlparse
else:
    from urlparse import urlparse  # noqa

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
    def post(self):
        data = json.loads(self.request.body.decode())
        total_amount = str(int(data['amount']))
        tax_amount = str(0)
        token = braintree.ClientToken.generate({'customer_id': ''})
        txn = braintree.Transaction(braintree.Environment.Sandbox, attributes={'token': token, 'amount': total_amount, 'tax_amount': tax_amount})
        res = txn.sale({'amount': total_amount, 'payment_method_nonce': 'fake-paypal-future-nonce'})
        self.write('OK: {}'.format(res.transaction.amount))


def main():
    port = os.getenv('VCAP_APP_PORT', None)  # for bluemix
    if not port:
        port = os.getenv('VCAP_APP_PORT', None)  # for heroku
    if not port:
        port = 8000
    port = int(port)

    here = os.path.abspath(os.path.dirname(__file__))
    static_dir = os.path.join(here, 'static')
    application = tornado.web.Application([
        (r"/ping", PingPongHandler),
        (r"/payment/token", TokenHandler),
        (r"/payment/buy", PaymentHandler),
        (r"/static/(.*)", StaticFileHandler, {"path": static_dir}),
        ])
    application.listen(port)
    tornado.ioloop.IOLoop.current().start()

if __name__ == "__main__":
    sys.exit(main())
