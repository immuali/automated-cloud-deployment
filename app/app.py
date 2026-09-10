import os
from datetime import datetime, timezone

import psycopg2
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


@app.route("/database-health")
def database_health():
    try:
        connection = psycopg2.connect(
            host=os.getenv("DB_HOST", "localhost"),
            port=os.getenv("DB_PORT", "5432"),
            database=os.getenv("DB_NAME", "capstone_db"),
            user=os.getenv("DB_USER", "capstone_user"),
            password=os.getenv("DB_PASSWORD"),
            connect_timeout=3
        )

        connection.close()

        return jsonify(
            {
                "application": "healthy",
                "database": "connected"
            }
        ), 200

    except Exception:
        return jsonify(
            {
                "application": "healthy",
                "database": "unavailable"
            }
        ), 503


@app.route("/about")
def about():
    return jsonify(
        {
            "project": "Automated Cloud Deployment Pipeline",
            "developer": "immuali",
            "technologies": [
                "Flask",
                "Docker",
                "PostgreSQL",
                "Terraform",
                "GitHub Actions",
                "AWS"
            ]
        }
    ), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)