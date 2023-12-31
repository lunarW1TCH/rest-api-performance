from flask import Flask
import bjoern

app = Flask(__name__)

@app.get("/get")
def get():
  return "Hello World"

if __name__ == "__main__":
  bjoern.run(app, "localhost", 8080)