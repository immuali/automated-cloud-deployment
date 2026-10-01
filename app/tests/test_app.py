from app.app import app
from unittest.mock import patch


def test_home_page():
    client = app.test_client()

    response = client.get("/")

    assert response.status_code == 200
    assert b"Automated Cloud Deployment Pipeline" in response.data


def test_health_endpoint():
    client = app.test_client()

    response = client.get("/health")
    data = response.get_json()

    assert response.status_code == 200
    assert data["status"] == "healthy"
    assert data["application"] == "automated-cloud-deployment"


def test_about_endpoint():
    client = app.test_client()

    response = client.get("/about")
    data = response.get_json()

    assert response.status_code == 200
    assert data["project"] == "Automated Cloud Deployment Pipeline"
    assert "Docker" in data["technologies"]

@patch("app.app.psycopg2.connect")
def test_messages_endpoint(mock_connect):
    mock_cursor = mock_connect.return_value.cursor.return_value
    mock_cursor.fetchall.return_value = [
        (1, "Docker Compose works")
    ]

    client = app.test_client()
    response = client.get("/messages")
    data = response.get_json()

    assert response.status_code == 200
    assert data == [
        {
            "id": 1,
            "message": "Docker Compose works"
        }
    ]