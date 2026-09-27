import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_create_and_get_patient_profile(client: AsyncClient):
    # Register a user first to get token
    auth_resp = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+9876543210", "otp": "123456"}
    )
    token = auth_resp.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}

    # Verify no profile exists
    get_resp = await client.get("/api/v1/patient/me", headers=headers)
    assert get_resp.status_code == 404

    # Create profile (via PUT)
    profile_data = {
        "full_name": "John Doe",
        "blood_group": "O+",
        "emergency_contact": "555-1234",
    }
    put_resp = await client.put(
        "/api/v1/patient/me", json=profile_data, headers=headers
    )
    assert put_resp.status_code == 200
    data = put_resp.json()
    assert data["full_name"] == "John Doe"

    # Get profile again
    get_resp = await client.get("/api/v1/patient/me", headers=headers)
    assert get_resp.status_code == 200
    assert get_resp.json()["full_name"] == "John Doe"


@pytest.mark.asyncio
async def test_unauthenticated_access(client: AsyncClient):
    get_resp = await client.get("/api/v1/patient/me")
    assert get_resp.status_code == 401


@pytest.mark.asyncio
async def test_delete_account(client: AsyncClient):
    auth_resp = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1112223333", "otp": "123456"}
    )
    token = auth_resp.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}

    del_resp = await client.delete("/api/v1/patient/me", headers=headers)
    assert del_resp.status_code == 204

    # Now token should be invalid because user is deleted
    get_resp = await client.get("/api/v1/patient/me", headers=headers)
    assert get_resp.status_code == 401
