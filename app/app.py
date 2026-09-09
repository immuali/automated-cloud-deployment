from datetime import datetime, timezone

from flask import Flask, jsonify, render_template


app = Flask(__name__)


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/health")
def health():
    return jsonify(
        {
            "application": "automated-cloud-deployment",
            "status": "healthy",
            "timestamp": datetime.now(timezone.utc).isoformat()
        }
    ), 200


@app.route("/about")
def about():
    return jsonify(
        {
            "project": "Automated Cloud Deployment Pipeline",
            "developer": "immuali",
            "technologies": [
                "Flask",
                "Docker",
                "Terraform",
                "GitHub Actions",
                "AWS"
            ]
        }
    ), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)