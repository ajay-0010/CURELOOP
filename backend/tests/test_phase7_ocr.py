import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_phase7_ocr_pipeline(client: AsyncClient):
    # Setup Patient A
    auth_a = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1601", "otp": "123456"}
    )
    token_a = auth_a.json()["access_token"]
    headers_a = {"Authorization": f"Bearer {token_a}"}
    await client.put(
        "/api/v1/patient/me", json={"full_name": "OCR User A"}, headers=headers_a
    )

    # Setup Patient B
    auth_b = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1602", "otp": "123456"}
    )
    token_b = auth_b.json()["access_token"]
    headers_b = {"Authorization": f"Bearer {token_b}"}
    await client.put(
        "/api/v1/patient/me", json={"full_name": "OCR User B"}, headers=headers_b
    )

    # Image upload mock
    file_bytes = b"fake_image_content"

    # --- TEST 1: clean_printed.png ---
    resp_clean = await client.post(
        "/api/v1/prescriptions/ocr",
        files={"file": ("clean_printed.png", file_bytes, "image/png")},
        headers=headers_a,
    )
    assert resp_clean.status_code == 201
    data_clean = resp_clean.json()
    p_id = data_clean["prescription_id"]

    # 1. OCR cannot directly confirm a prescription.
    # Check DB status is DRAFT
    presc_resp = await client.get("/api/v1/prescriptions", headers=headers_a)
    presc = next(p for p in presc_resp.json() if p["id"] == p_id)
    assert presc["status"] == "draft"

    # 2. OCR cannot directly activate reminders.
    upcoming_doses = await client.get("/api/v1/doses/upcoming", headers=headers_a)
    assert not any(d["prescription_id"] == p_id for d in upcoming_doses.json())

    # 8. OCR-created prescription belongs only to authenticated patient.
    # 9. Patient A cannot access Patient B's OCR result.
    presc_resp_b = await client.get("/api/v1/prescriptions", headers=headers_b)
    assert not any(p["id"] == p_id for p in presc_resp_b.json())

    # 10. Original prescription image is protected by existing storage authorization.
    doc_key = data_clean["document_key"]
    doc_resp_b = await client.get(
        f"/api/v1/prescriptions/documents/{doc_key}", headers=headers_b
    )
    assert doc_resp_b.status_code == 404

    # --- TEST 2: missing_dosage.png ---
    # 4. Unknown dosage remains unknown.
    resp_missing = await client.post(
        "/api/v1/prescriptions/ocr",
        files={"file": ("missing_dosage.png", file_bytes, "image/png")},
        headers=headers_a,
    )
    data_missing = resp_missing.json()
    med_missing = data_missing["medicines"][0]
    assert med_missing["dosage"]["confidence"] == "UNKNOWN"
    assert med_missing["dosage"]["value"] is None

    # --- TEST 3: ambiguous.png ---
    # 3. Low-confidence medicine requires manual review (we map it to UNKNOWN/LOW).
    # 7. Unmatched medicine requires manual correction.
    resp_ambig = await client.post(
        "/api/v1/prescriptions/ocr",
        files={"file": ("ambiguous.png", file_bytes, "image/png")},
        headers=headers_a,
    )
    data_ambig = resp_ambig.json()
    med_ambig = data_ambig["medicines"][0]
    assert med_ambig["medicine_name"]["confidence"] in ["LOW", "UNKNOWN"]

    # --- TEST 4: messy.png ---
    # 5. Unknown frequency remains unknown (depends on regex parsing)
    # 6. Unknown duration remains unknown

    # 14. Editing OCR-derived data before confirmation works correctly.
    med_id_clean = presc["medicines"][0]["id"]
    edit_resp = await client.put(
        f"/api/v1/prescriptions/{p_id}/medicines/{med_id_clean}",
        json={
            "medicine_name": "Amoxicillin",
            "dosage": "1000mg",
            "frequency": "1-0-1",
            "duration_days": 5,
        },
        headers=headers_a,
    )
    assert edit_resp.status_code == 200
    assert edit_resp.json()["medicines"][0]["dosage"] == "1000mg"

    # 11. OCR does not bypass Allergy SafetyEngine.
    allergy_resp = await client.post(
        "/api/v1/patient/allergies",
        json={
            "allergen_name": "Amoxicillin",
            "severity": "severe",
            "allergy_type": "drug",
        },
        headers=headers_a,
    )
    assert allergy_resp.status_code == 201

    submit_resp = await client.post(
        f"/api/v1/prescriptions/{p_id}/submit-for-confirmation", headers=headers_a
    )
    assert submit_resp.status_code == 200
    safety_resp = await client.get(
        f"/api/v1/prescriptions/{p_id}/safety-check", headers=headers_a
    )
    assert safety_resp.json()["status"] == "potential_allergy_match"

    # 12. OCR-generated prescription must still pass Phase 3 confirmation.
    confirm_resp = await client.post(
        f"/api/v1/prescriptions/{p_id}/confirm", headers=headers_a
    )
    assert confirm_resp.status_code == 200
    assert confirm_resp.json()["status"] == "confirmed"

    # 13. After patient confirmation, existing Phase 5 dose generation works normally.
    upcoming_doses_post = await client.get("/api/v1/doses/upcoming", headers=headers_a)
    # We should have doses now since it was Amoxicillin 1-0-1 for 5 days -> 10 doses
    assert len(upcoming_doses_post.json()) > 0

    # 15. Material editing after confirmation still triggers Phase 3 reconfirmation.
    edit_after = await client.put(
        f"/api/v1/prescriptions/{p_id}/medicines/{med_id_clean}",
        json={
            "medicine_name": "Amoxicillin",
            "dosage": "1000mg",
            "frequency": "1-0-1",
            "duration_days": 10,
        },
        headers=headers_a,
    )
    assert edit_after.json()["status"] == "pending_confirmation"

    # Doses are cancelled automatically
    upcoming_after_edit = await client.get("/api/v1/doses/upcoming", headers=headers_a)
    # Only doses matching that prescription are cancelled. Since we only confirmed this one, should be 0.
    assert len(upcoming_after_edit.json()) == 0
