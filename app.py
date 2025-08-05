from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello from Docker!"

port = int(os.environ.get("PORT", 8080))  # default to 8080

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=port)
