from http.server import ThreadingHTTPServer, SimpleHTTPRequestHandler
import os
os.chdir("/workspace/bvn-3.3/play")
class H(SimpleHTTPRequestHandler):
    protocol_version = "HTTP/1.1"
    def log_message(self, fmt, *args):
        super().log_message(fmt, *args)
httpd = ThreadingHTTPServer(("127.0.0.1", 8765), H)
print("threaded http on 127.0.0.1:8765 cwd=/workspace/bvn-3.3/play", flush=True)
httpd.serve_forever()
