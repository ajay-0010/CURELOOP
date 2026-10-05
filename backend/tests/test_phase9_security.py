import pytest
from httpx import AsyncClient
from app.models.user import User
from app.models.patient import PatientProfile
from app.models.prescription import Prescription, PrescriptionStatus
from sqlalchemy.ext.asyncio import AsyncSession
from uuid import uuid4

@pytest.mark.asyncio
async def test_otp_rate_limiting(client: AsyncClient, db: AsyncSession):
    phone = "+15555555555"
    # Assuming MAX_REQUESTS is 3
    for _ in range(3):
        response = await client.post("/api/v1/auth/request-otp", json={"phone_number": phone})
        assert response.status_code == 200
    
    # 4th request should be rate limited
    response = await client.post("/api/v1/auth/request-otp", json={"phone_number": phone})
    assert response.status_code == 429

@pytest.mark.asyncio
async def test_refresh_token_behavior(client: AsyncClient, db: AsyncSession):
    phone = "+15559999999"
    # Request OTP to get rate limited tracking started, not strictly necessary if verify works
    await client.post("/api/v1/auth/request-otp", json={"phone_number": phone})
    response = await client.post("/api/v1/auth/verify-otp", json={"phone_number": phone, "otp": "123456"})
    assert response.status_code == 200
    data = response.json()
    refresh_token = data["refresh_token"]
    
    # Valid refresh
    refresh_res = await client.post("/api/v1/auth/refresh", json={"refresh_token": refresh_token})
    assert refresh_res.status_code == 200
    new_data = refresh_res.json()
    assert "access_token" in new_data
    assert "refresh_token" in new_data
    # assert new_data["refresh_token"] != refresh_token # (may be same if generated in same second)

    # Invalid refresh
    invalid_res = await client.post("/api/v1/auth/refresh", json={"refresh_token": "invalid.token.here"})
    assert invalid_res.status_code == 401

@pytest.mark.asyncio
async def test_patient_isolation(client: AsyncClient, db: AsyncSession):
    # Create User A
    res_a = await client.post("/api/v1/auth/verify-otp", json={"phone_number": "+15551111111", "otp": "123456"})
    token_a = res_a.json()["access_token"]
    await client.put("/api/v1/patient/me", json={"full_name": "User A", "date_of_birth": "1990-01-01"}, headers={"Authorization": f"Bearer {token_a}"})
    
    # Create User B
    res_b = await client.post("/api/v1/auth/verify-otp", json={"phone_number": "+15552222222", "otp": "123456"})
    token_b = res_b.json()["access_token"]
    await client.put("/api/v1/patient/me", json={"full_name": "User B", "date_of_birth": "1990-01-01"}, headers={"Authorization": f"Bearer {token_b}"})

    # User A creates a prescription
    create_res = await client.post(
        "/api/v1/prescriptions",
        json={"doctor_name": "Dr. A", "prescription_date": "2026-10-02"},
        headers={"Authorization": f"Bearer {token_a}"}
    )
    assert create_res.status_code == 201
    prescription_id = create_res.json()["id"]

    # User B tries to access User A's prescription
    get_res = await client.get(
        f"/api/v1/prescriptions/{prescription_id}",
        headers={"Authorization": f"Bearer {token_b}"}
    )
    assert get_res.status_code == 404

    # User B tries to delete User A's prescription
    del_res = await client.delete(
        f"/api/v1/prescriptions/{prescription_id}",
        headers={"Authorization": f"Bearer {token_b}"}
    )
    assert del_res.status_code == 404

@pytest.mark.asyncio
async def test_unresolved_prescription_cannot_confirm(client: AsyncClient, db: AsyncSession):
    res = await client.post("/api/v1/auth/verify-otp", json={"phone_number": "+15553333333", "otp": "123456"})
    token = res.json()["access_token"]
    await client.put("/api/v1/patient/me", json={"full_name": "User C", "date_of_birth": "1990-01-01"}, headers={"Authorization": f"Bearer {token}"})

    create_res = await client.post(
        "/api/v1/prescriptions",
        json={"doctor_name": "Dr. Unresolved", "prescription_date": "2026-10-02", "medicines": [{"medicine_name": "Incomplete Med", "dosage": "10mg", "frequency": "1-0-0", "duration_days": None, "food_timing": None}]}, 
        headers={"Authorization": f"Bearer {token}"}
    )
    prescription_id = create_res.json()["id"]

    # Submit for confirmation
    sub_res = await client.post(
        f"/api/v1/prescriptions/{prescription_id}/submit-for-confirmation",
        headers={"Authorization": f"Bearer {token}"}
    )
    assert sub_res.status_code == 400

    # Try to confirm
    conf_res = await client.post(
        f"/api/v1/prescriptions/{prescription_id}/confirm",
        headers={"Authorization": f"Bearer {token}"}
    )
    assert conf_res.status_code == 400
    assert "pending_confirmation" in conf_res.json()["detail"].lower()








