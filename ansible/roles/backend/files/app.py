from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def index():
    return "Hello from the backend!"

@app.route("/info")
def info():
    return jsonify({"message": "Données envoyées depuis le backend."})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)