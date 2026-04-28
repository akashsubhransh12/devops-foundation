from flask import Flask, jsonify
import os

app = Flask(__name__)

# Version is injected via env var (set in Dockerfile or docker run)
APP_VERSION = os.environ.get("APP_VERSION", "local")

@app.route("/")
def home():
    return jsonify({
        "message": "MeetMux CI Pipeline - Day 11",
        "status":  "running",
        "version": APP_VERSION
    })

@app.route("/health")
def health():
    return jsonify({"status": "healthy"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)