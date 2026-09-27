import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_create_prescription(client: AsyncClient):
    # Setup user
    auth_resp = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1112223334", "otp": "123456"}
    )
    token = auth_resp.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}
    await client.put(
        "/api/v1/patient/me", json={"full_name": "Test User"}, headers=headers
    )

    # Proof 7: Invalid frequency data is rejected
    invalid_data = {
        "prescription_date": "2026-09-27",
        "medicines": [
            {
                "medicine_name": "Paracetamol",
                "dosage": "500mg",
                "frequency": "1x a day",  # Invalid format
                "duration_days": 5,
            }
        ],
    }
    resp = await client.post(
        "/api/v1/prescriptions", json=invalid_data, headers=headers
    )
    assert resp.status_code == 422  # Validation Error

    # Proof 1 & 6: Create draft prescription and verify medicines
    valid_data = {
        "prescription_date": "2026-09-27",
        "doctor_name": "Dr. Smith",
        "medicines": [
            {
                "medicine_name": "Paracetamol",
                "dosage": "500mg",
                "frequency": "1-0-1",
                "duration_days": 5,
                "food_timing": "after_food",
            }
        ],
    }
    resp = await client.post("/api/v1/prescriptions", json=valid_data, headers=headers)
    assert resp.status_code == 201
    data = resp.json()

    # Proof 4: Cannot be treated as confirmed immediately
    assert data["status"] == "draft"
    assert len(data["medicines"]) == 1
    assert data["medicines"][0]["medicine_name"] == "Paracetamol"
    assert (
        len(data["medicines"][0]["schedules"]) == 2
    )  # 1-0-1 means 2 schedules generated


@pytest.mark.asyncio
async def test_prescription_isolation_and_cascade(client: AsyncClient):
    # Setup User A
    auth_a = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1001", "otp": "123456"}
    )
    token_a = auth_a.json()["access_token"]
    headers_a = {"Authorization": f"Bearer {token_a}"}
    await client.put(
        "/api/v1/patient/me", json={"full_name": "User A"}, headers=headers_a
    )

    # Setup User B
    auth_b = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1002", "otp": "123456"}
    )
    token_b = auth_b.json()["access_token"]
    headers_b = {"Authorization": f"Bearer {token_b}"}
    await client.put(
        "/api/v1/patient/me", json={"full_name": "User B"}, headers=headers_b
    )

    # User A creates a prescription
    data_a = {
        "prescription_date": "2026-09-27",
        "medicines": [
            {
                "medicine_name": "M1",
                "dosage": "1",
                "frequency": "1-0-0",
                "duration_days": 1,
            }
        ],
    }
    resp_a = await client.post("/api/v1/prescriptions", json=data_a, headers=headers_a)
    p_id = resp_a.json()["id"]

    # Proof 2 & 3: Another patient cannot access it
    get_resp_b = await client.get(f"/api/v1/prescriptions/{p_id}", headers=headers_b)
    assert get_resp_b.status_code == 404

    get_all_b = await client.get("/api/v1/prescriptions", headers=headers_b)
    assert len(get_all_b.json()) == 0

    # Proof 8: Deleting prescription handles its child records correctly
    # Because of cascade rules in SQLAlchemy, deleting it should work.
    del_resp = await client.delete(f"/api/v1/prescriptions/{p_id}", headers=headers_a)
    assert del_resp.status_code == 204

    get_resp_a = await client.get(f"/api/v1/prescriptions/{p_id}", headers=headers_a)
    assert get_resp_a.status_code == 404
