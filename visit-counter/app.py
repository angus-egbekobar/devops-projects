import os  #lets you read environment variables (like DB_HOST, DB_PASSWORD)
import psycopg2  #the library that lets Python talk to PostgreSQL
from http.server import HTTPServer, BaseHTTPRequestHandler #built-in Python web server

# Connecting to the database. 
#This is a function that opens a connection to PostgreSQL.
def get_db():
    return psycopg2.connect(
        host=os.environ.get("DB_HOST", "db"), #means—look for an environment variable called DB_HOST,and if it doesn't exist use "db" as d defaul
        database=os.environ.get("DB_NAME", "visitdb"), # check for all these environment variables in your yaml file.
        user=os.environ.get("DB_USER", "devops"), #That's where these values come from. The app reads them at runtime. This is the professional 
	password=os.environ.get("DB_PASSWORD", "password") # way — you never hardcode passwords in your code.
    )


#Setting up the database
def init_db():
    conn = get_db() #conn = open a connection to the database
    cur = conn.cursor()  #cur  = a cursor, like a pen you use to write/read from the database
    cur.execute("""  
        CREATE TABLE IF NOT EXISTS visits (
            id SERIAL PRIMARY KEY,
            visited_at TIMESTAMP DEFAULT NOW()
        )
    """)
    conn.commit()  # conn.commit = save the changes
    cur.close()
    conn.close()


# Handling web requests
class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        conn = get_db()
        cur = conn.cursor()
        cur.execute("INSERT INTO visits (visited_at) VALUES (NOW())")
        conn.commit()
        cur.execute("SELECT COUNT(*) FROM visits")
        count = cur.fetchone()[0]
        cur.close()
        conn.close()

        self.send_response(200)
        self.end_headers()
        message = f"Hello from Docker Compose! This page has been visited {count} times."
        self.wfile.write(message.encode())

    def log_message(self, format, *args):
        pass

print("Initialising database...")
init_db()
print("Server running on port 8080...")
server = HTTPServer(('0.0.0.0', 8080), Handler)
server.serve_forever()
