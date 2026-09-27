import pytest
from httpx import AsyncClient

@pytest.mark.asyncio
async def test_ocr_post_review_corrections(client: AsyncClient):
    # Setup Patient
    auth_resp = await client.post("/api/v1/auth/verify-otp", json={"phone_number": "+1701", "otp": "123456"})
    token = auth_resp.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}
    await client.put("/api/v1/patient/me", json={"full_name": "Correction User"}, headers=headers)

    # 1. Image upload mock - Messy which fails to extract most fields
    file_bytes = b"fake_image_content"
    resp = await client.post(
        "/api/v1/prescriptions/ocr",
        files={"file": ("missing_everything.png", file_bytes, "image/png")},
        headers=headers
    )
    assert resp.status_code == 201
    p_id = resp.json()["prescription_id"]

    presc_resp = await client.get(f"/api/v1/prescriptions/{p_id}", headers=headers)
    assert presc_resp.status_code == 200
    presc = presc_resp.json()
    med = presc["medicines"][0]

    # Prove unresolved conditions
    assert med["dosage"] is None
    assert med["frequency"] is None
    assert med["duration_days"] is None
    assert med["medicine_name"] is None or med["medicine_name"] == ""

    # Try to confirm unresolved prescription
    submit_resp = await client.post(f"/api/v1/prescriptions/{p_id}/submit-for-confirmation", headers=headers)
    assert submit_resp.status_code == 400
    assert "Cannot confirm prescription with unresolved medication details" in submit_resp.json()["detail"]

    # Try to confirm directly
    confirm_resp = await client.post(f"/api/v1/prescriptions/{p_id}/confirm", headers=headers)
    assert confirm_resp.status_code == 400

    # Ensure no reminders exist for DRAFT
    upcoming_doses = await client.get("/api/v1/doses/upcoming", headers=headers)
    assert not any(d["prescription_id"] == p_id for d in upcoming_doses.json())

    # Correct the medication
    med_id = med["id"]
    edit_resp = await client.put(
        f"/api/v1/prescriptions/{p_id}/medicines/{med_id}",
        json={
            "medicine_name": "Amoxicillin",
            "dosage": "500mg",
            "frequency": "1-0-1",
            "duration_days": 7
        },
        headers=headers
    )
    assert edit_resp.status_code == 200

    # Now submit works
    submit_resp2 = await client.post(f"/api/v1/prescriptions/{p_id}/submit-for-confirmation", headers=headers)
    assert submit_resp2.status_code == 200

    # And confirm works
    confirm_resp2 = await client.post(f"/api/v1/prescriptions/{p_id}/confirm", headers=headers)
    assert confirm_resp2.status_code == 200
    assert confirm_resp2.json()["status"] == "confirmed"

    # Ensure doses were generated
    upcoming_doses_after = await client.get("/api/v1/doses/upcoming", headers=headers)
    assert any(d["prescription_id"] == p_id for d in upcoming_doses_after.json())

