from flask import Flask, request
from flask_cors import CORS
import subprocess
import json

app = Flask(__name__)
CORS(app)  # ✅ THIS LINE FIXES THE ERROR

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json

    result = subprocess.run(
        ["python3", "model.py", json.dumps(data)],
        capture_output=True,
        text=True
    )

    return result.stdout

app.run(port=5000)