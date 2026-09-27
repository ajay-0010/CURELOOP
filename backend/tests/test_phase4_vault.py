
import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_phase4_vault_search(client: AsyncClient):
    # Setup User A
    auth_a = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1201", "otp": "123456"}
    )
    token_a = auth_a.json()["access_token"]
    headers_a = {"Authorization": f"Bearer {token_a}"}
    await client.put(
        "/api/v1/patient/me", json={"full_name": "Vault User A"}, headers=headers_a
    )

    # Setup User B
    auth_b = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1202", "otp": "123456"}
    )
    token_b = auth_b.json()["access_token"]
    headers_b = {"Authorization": f"Bearer {token_b}"}
    await client.put(
        "/api/v1/patient/me", json={"full_name": "Vault User B"}, headers=headers_b
    )

    # Create prescriptions for A
    p1_data = {
        "prescription_date": "2026-01-01",
        "doctor_name": "Dr. Sharma",
        "medicines": [
            {
                "medicine_name": "Amoxicillin",
                "dosage": "500mg",
                "frequency": "1-0-1",
                "duration_days": 7,
            }
        ],
    }
    p2_data = {
        "prescription_date": "2026-02-01",
        "doctor_name": "Dr. Smith",
        "medicines": [
            {
                "medicine_name": "Ibuprofen",
                "dosage": "200mg",
                "frequency": "1-1-1",
                "duration_days": 3,
            }
        ],
    }
    await client.post("/api/v1/prescriptions", json=p1_data, headers=headers_a)
    await client.post("/api/v1/prescriptions", json=p2_data, headers=headers_a)

    # Create prescription for B
    pb_data = {
        "prescription_date": "2026-01-15",
        "doctor_name": "Dr. Sharma",
        "medicines": [
            {
                "medicine_name": "Amoxicillin",
                "dosage": "250mg",
                "frequency": "1-0-0",
                "duration_days": 5,
            }
        ],
    }
    resp_b = await client.post("/api/v1/prescriptions", json=pb_data, headers=headers_b)
    p_b_id = resp_b.json()["id"]

    # 1. Patient can retrieve their prescriptions
    resp = await client.get("/api/v1/prescriptions", headers=headers_a)
    assert len(resp.json()) == 2

    # 2. Patient cannot retrieve another patient's prescription
    resp_b_get = await client.get(f"/api/v1/prescriptions/{p_b_id}", headers=headers_a)
    assert resp_b_get.status_code == 404

    # 3. Patient can search by medicine
    resp = await client.get("/api/v1/prescriptions?search=amox", headers=headers_a)
    assert len(resp.json()) == 1
    assert resp.json()[0]["doctor_name"] == "Dr. Sharma"

    # 4. Patient can search by doctor
    resp = await client.get("/api/v1/prescriptions?doctor=Smith", headers=headers_a)
    assert len(resp.json()) == 1
    assert resp.json()[0]["doctor_name"] == "Dr. Smith"

    # 5. Patient can filter by date
    resp = await client.get(
        "/api/v1/prescriptions?from_date=2026-01-15", headers=headers_a
    )
    assert len(resp.json()) == 1
    assert resp.json()[0]["doctor_name"] == "Dr. Smith"  # Feb 1 is after Jan 15

    # 6. Search cannot expose another patient's data
    resp = await client.get("/api/v1/prescriptions?doctor=Sharma", headers=headers_a)
    # A has 1 from Sharma, B has 1. A should only see 1.
    assert len(resp.json()) == 1

    # 7. Prescription details contain the expected structured data
    detail_resp = await client.get(
        f"/api/v1/prescriptions/{resp.json()[0]['id']}", headers=headers_a
    )
    detail = detail_resp.json()
    assert detail["status"] == "draft"
    assert "medicines" in detail
    assert detail["medicines"][0]["medicine_name"] == "Amoxicillin"


@pytest.mark.asyncio
async def test_phase4_vault_documents(client: AsyncClient):
    auth_a = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1203", "otp": "123456"}
    )
    token_a = auth_a.json()["access_token"]
    headers_a = {"Authorization": f"Bearer {token_a}"}
    await client.put(
        "/api/v1/patient/me", json={"full_name": "Vault User C"}, headers=headers_a
    )

    auth_b = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1204", "otp": "123456"}
    )
    token_b = auth_b.json()["access_token"]
    headers_b = {"Authorization": f"Bearer {token_b}"}
    await client.put(
        "/api/v1/patient/me", json={"full_name": "Vault User D"}, headers=headers_b
    )

    # Create prescription
    p_data = {"prescription_date": "2026-03-01", "medicines": []}
    resp = await client.post("/api/v1/prescriptions", json=p_data, headers=headers_a)
    p_id = resp.json()["id"]

    # 11. Invalid file type is rejected
    file_invalid = {"file": ("script.exe", b"test", "application/x-msdownload")}
    resp_invalid = await client.post(
        f"/api/v1/prescriptions/{p_id}/documents", files=file_invalid, headers=headers_a
    )
    assert resp_invalid.status_code == 400

    # 12. Oversized file is rejected
    file_large = {"file": ("big.jpg", b"0" * (11 * 1024 * 1024), "image/jpeg")}
    resp_large = await client.post(
        f"/api/v1/prescriptions/{p_id}/documents", files=file_large, headers=headers_a
    )
    assert resp_large.status_code == 400

    # 8. Document attachment is associated with the correct prescription
    # 16. A DRAFT prescription remains DRAFT after document upload
    # Upload valid
    file_valid = {"file": ("test.jpg", b"valid_image_data", "image/jpeg")}
    resp_doc = await client.post(
        f"/api/v1/prescriptions/{p_id}/documents", files=file_valid, headers=headers_a
    )
    assert resp_doc.status_code == 201
    object_key = resp_doc.json()["object_key"]

    p_check = await client.get(f"/api/v1/prescriptions/{p_id}", headers=headers_a)
    assert len(p_check.json()["documents"]) == 1
    assert p_check.json()["status"] == "draft"

    # 17. A PENDING_CONFIRMATION prescription remains PENDING_CONFIRMATION after document upload
    await client.post(
        f"/api/v1/prescriptions/{p_id}/submit-for-confirmation", headers=headers_a
    )
    file_valid_2 = {"file": ("test2.pdf", b"valid_pdf_data", "application/pdf")}
    await client.post(
        f"/api/v1/prescriptions/{p_id}/documents", files=file_valid_2, headers=headers_a
    )
    p_check = await client.get(f"/api/v1/prescriptions/{p_id}", headers=headers_a)
    assert p_check.json()["status"] == "pending_confirmation"
    assert len(p_check.json()["documents"]) == 2

    # 18. A CONFIRMED prescription remains CONFIRMED unless a material prescription edit triggers...
    await client.post(f"/api/v1/prescriptions/{p_id}/confirm", headers=headers_a)
    file_valid_3 = {"file": ("test3.jpg", b"valid_image_data_3", "image/jpeg")}
    await client.post(
        f"/api/v1/prescriptions/{p_id}/documents", files=file_valid_3, headers=headers_a
    )
    p_check = await client.get(f"/api/v1/prescriptions/{p_id}", headers=headers_a)
    assert p_check.json()["status"] == "confirmed"

    # 9. Patient can obtain secure access to their own document
    doc_access = await client.get(
        f"/api/v1/prescriptions/documents/{object_key}", headers=headers_a
    )
    assert doc_access.status_code == 200
    assert doc_access.content == b"valid_image_data"

    # 10. Patient cannot obtain access to another patient's document
    doc_access_b = await client.get(
        f"/api/v1/prescriptions/documents/{object_key}", headers=headers_b
    )
    assert doc_access_b.status_code == 404

    # 14. Deleting a prescription handles its associated document correctly
    del_resp = await client.delete(f"/api/v1/prescriptions/{p_id}", headers=headers_a)
    assert del_resp.status_code == 204

    # The file should be gone from the local storage provider
    doc_access_deleted = await client.get(
        f"/api/v1/prescriptions/documents/{object_key}", headers=headers_a
    )
    assert doc_access_deleted.status_code == 404
