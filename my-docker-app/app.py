from http.server import HTTPServer, BaseHTTPRequestHandler

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        message = "Hello from Docker! Built by Angus - DevOps Engineer in training"
        self.wfile.write(message.encode())

    def log_message(self, format, *args):
        pass

server = HTTPServer(('0.0.0.0', 8080), Handler)
print("Server running on port 8080...")
server.serve_forever()
