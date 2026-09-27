import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_allergy_crud(client: AsyncClient):
    # Setup user and profile
    auth_resp = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+9998887777", "otp": "123456"}
    )
    token = auth_resp.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}

    await client.put(
        "/api/v1/patient/me", json={"full_name": "Jane Doe"}, headers=headers
    )

    # Empty allergies
    get_resp = await client.get("/api/v1/patient/allergies", headers=headers)
    assert get_resp.status_code == 200
    assert len(get_resp.json()) == 0

    # Create allergy
    allergy_data = {
        "allergen_name": "Penicillin",
        "allergy_type": "drug",
        "severity": "severe",
    }
    post_resp = await client.post(
        "/api/v1/patient/allergies", json=allergy_data, headers=headers
    )
    assert post_resp.status_code == 201
    allergy_id = post_resp.json()["id"]

    # Get allergies
    get_resp = await client.get("/api/v1/patient/allergies", headers=headers)
    allergies = get_resp.json()
    assert len(allergies) == 1
    assert allergies[0]["allergen_name"] == "Penicillin"

    # Delete allergy
    del_resp = await client.delete(
        f"/api/v1/patient/allergies/{allergy_id}", headers=headers
    )
    assert del_resp.status_code == 204

    # Verify empty
    get_resp = await client.get("/api/v1/patient/allergies", headers=headers)
    assert len(get_resp.json()) == 0


@pytest.mark.asyncio
async def test_allergy_patient_isolation(client: AsyncClient):
    # User 1
    auth1 = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+101", "otp": "123456"}
    )
    t1 = auth1.json()["access_token"]
    h1 = {"Authorization": f"Bearer {t1}"}
    await client.put("/api/v1/patient/me", json={"full_name": "U1"}, headers=h1)

    resp1 = await client.post(
        "/api/v1/patient/allergies", json={"allergen_name": "A1"}, headers=h1
    )
    a1_id = resp1.json()["id"]

    # User 2
    auth2 = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+202", "otp": "123456"}
    )
    t2 = auth2.json()["access_token"]
    h2 = {"Authorization": f"Bearer {t2}"}
    await client.put("/api/v1/patient/me", json={"full_name": "U2"}, headers=h2)

    # User 2 shouldn't see User 1's allergy
    get_resp = await client.get("/api/v1/patient/allergies", headers=h2)
    assert len(get_resp.json()) == 0

    # User 2 cannot delete User 1's allergy
    del_resp = await client.delete(f"/api/v1/patient/allergies/{a1_id}", headers=h2)
    assert del_resp.status_code == 404
