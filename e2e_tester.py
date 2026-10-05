import asyncio
from httpx import AsyncClient

async def run_tests():
    API_URL = "http://127.0.0.1:8000/api/v1"
    
    async with AsyncClient(base_url=API_URL) as client:
        print("1. Authentication Test")
        res = await client.post("/auth/verify-otp", json={"phone_number": "+15550000001", "otp": "123456"})
        assert res.status_code == 200
        token_a = res.json()["access_token"]
        refresh_a = res.json()["refresh_token"]
        headers_a = {"Authorization": f"Bearer {token_a}"}
        
        await client.put("/patient/me", json={"full_name": "Test Patient A"}, headers=headers_a)
        
        print("2. Refresh Token Test")
        res_refresh = await client.post("/auth/refresh", json={"refresh_token": refresh_a})
        assert res_refresh.status_code == 200
        token_a = res_refresh.json()["access_token"]
        headers_a = {"Authorization": f"Bearer {token_a}"}

        print("3. OCR Valid Dataset Test (missing_duration.png)")
        dummy_file = b"fake png content"
        files = {"file": ("missing_duration.png", dummy_file, "image/png")}
        res_ocr = await client.post("/prescriptions/ocr", files=files, headers=headers_a)
        assert res_ocr.status_code == 201
        p_id = res_ocr.json()["prescription_id"]
        
        print("4. OCR Safety Test (unresolved fields)")
        res_sub = await client.post(f"/prescriptions/{p_id}/submit-for-confirmation", headers=headers_a)
        assert res_sub.status_code == 400
        
        res_get = await client.get(f"/prescriptions/{p_id}", headers=headers_a)
        assert res_get.json()["status"] == "draft"
        med_id = res_get.json()["medicines"][0]["id"]
        
        print("5. OCR Correction Test")
        res_put = await client.put(f"/prescriptions/{p_id}/medicines/{med_id}", json={
            "medicine_name": "Amoxicillin",
            "dosage": "500mg",
            "frequency": "1-0-1",
            "duration_days": 5,
            "food_timing": "after_food"
        }, headers=headers_a)
        assert res_put.status_code == 200
        
        res_sub2 = await client.post(f"/prescriptions/{p_id}/submit-for-confirmation", headers=headers_a)
        assert res_sub2.status_code == 200
        
        res_conf = await client.post(f"/prescriptions/{p_id}/confirm", headers=headers_a)
        assert res_conf.status_code == 200
        
        print("6. Medicine Tracking & Timezone Test")
        res_doses = await client.get("/doses/upcoming", headers=headers_a)
        assert res_doses.status_code == 200
        doses = res_doses.json()
        assert len(doses) > 0
        dose_id = doses[0]["id"]
        
        res_taken = await client.post(f"/doses/{dose_id}/taken", headers=headers_a)
        assert res_taken.status_code == 200
        
        print("7. Patient Isolation Test")
        res_b = await client.post("/auth/verify-otp", json={"phone_number": "+15550000002", "otp": "123456"})
        token_b = res_b.json()["access_token"]
        headers_b = {"Authorization": f"Bearer {token_b}"}
        
        res_get_b = await client.get(f"/prescriptions/{p_id}", headers=headers_b)
        assert res_get_b.status_code == 404
        
        print("8. Material Edit Invalidates Confirmation Test")
        res_edit = await client.put(f"/prescriptions/{p_id}/medicines/{med_id}", json={
            "medicine_name": "Ibuprofen", "dosage": "400mg", "frequency": "1-1-1", "duration_days": 3, "food_timing": "after_food"
        }, headers=headers_a)
        assert res_edit.status_code == 200
        res_get_after_edit = await client.get(f"/prescriptions/{p_id}", headers=headers_a)
        status = res_get_after_edit.json()["status"]
        if status != "draft":
            print(f"FAILURE: Material edit did not downgrade status. Current status: {status}")
        else:
            print("PASS: Material edit downgraded status")
        
        print("9. Prescription Delete Cascade Test")
        res_del = await client.delete(f"/prescriptions/{p_id}", headers=headers_a)
        assert res_del.status_code == 204
        
        res_doses_after = await client.get("/doses/upcoming", headers=headers_a)
        assert len(res_doses_after.json()) == 0
        
        print("10. Appointment Flow Test")
        res_appt = await client.post("/appointments", json={
            "title": "Dr. Visit",
            "appointment_datetime": "2026-10-15T10:00:00Z",
            "doctor_name": "Dr. Smith",
            "location": "Clinic"
        }, headers=headers_a)
        assert res_appt.status_code == 201
        appt_id = res_appt.json()["id"]
        
        res_appt_get = await client.get(f"/appointments/{appt_id}", headers=headers_a)
        assert res_appt_get.status_code == 200
        
        res_appt_del = await client.delete(f"/appointments/{appt_id}", headers=headers_a)
        assert res_appt_del.status_code == 204
        
        print("All API E2E Validation Tests Passed successfully!")

if __name__ == "__main__":
    asyncio.run(run_tests())

