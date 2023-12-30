from flask import Flask, request
import bjoern

app = Flask(__name__)

@app.get("/get")
def get():
  return "Hello World"

@app.post("/post")
def post():
  return request.json

if __name__ == "__main__":
  bjoern.run(app, "localhost", 8080)