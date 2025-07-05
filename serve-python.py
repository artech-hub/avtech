# Python HTTP Server for testing built Angular app
# This serves the docs folder content at http://localhost:8000

import http.server
import socketserver
import os
import sys
from urllib.parse import urlparse

class AngularHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=os.path.join(os.getcwd(), 'docs'), **kwargs)
    
    def do_GET(self):
        # Handle Angular routing by serving index.html for all routes
        parsed_path = urlparse(self.path)
        
        # If the path doesn't exist and it's not a file with extension, serve index.html
        if not os.path.exists(os.path.join(self.directory, parsed_path.path.lstrip('/'))):
            if '.' not in os.path.basename(parsed_path.path):
                self.path = '/index.html'
        
        return super().do_GET()

def main():
    PORT = 8000
    
    if not os.path.exists('docs'):
        print("ERROR: docs folder not found. Please run 'npm run build:github-pages' first.")
        sys.exit(1)
    
    print(f"Starting HTTP server on port {PORT}")
    print(f"Your app will be available at: http://localhost:{PORT}/")
    print("Press Ctrl+C to stop the server")
    
    with socketserver.TCPServer(("", PORT), AngularHTTPRequestHandler) as httpd:
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nServer stopped.")

if __name__ == "__main__":
    main()
