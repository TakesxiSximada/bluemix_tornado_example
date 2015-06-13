# -*- coding: utf-8 -*-
import os
import tornado.ioloop
import tornado.web
PORT = int(os.getenv('VCAP_APP_PORT', 8000))


class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, world")

application = tornado.web.Application([
    (r"/", MainHandler),
])

if __name__ == "__main__":
    application.listen(PORT)
    tornado.ioloop.IOLoop.current().start()
