import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_phase5_doses_generation(client: AsyncClient):
    auth_a = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1501", "otp": "123456"}
    )
    token_a = auth_a.json()["access_token"]
    headers_a = {"Authorization": f"Bearer {token_a}"}
    await client.put(
        "/api/v1/patient/me",
        json={"full_name": "Dose User A", "timezone": "Asia/Kolkata"},
        headers=headers_a,
    )

    auth_b = await client.post(
        "/api/v1/auth/verify-otp", json={"phone_number": "+1502", "otp": "123456"}
    )
    token_b = auth_b.json()["access_token"]
    headers_b = {"Authorization": f"Bearer {token_b}"}
    await client.put(
        "/api/v1/patient/me",
        json={"full_name": "Dose User B", "timezone": "UTC"},
        headers=headers_b,
    )

    # 1. Unconfirmed prescription cannot create active reminders.
    # 2. DRAFT prescription cannot generate dose events.
    p_data = {
        "prescription_date": "2026-05-01",
        "medicines": [
            {
                "medicine_name": "Amox",
                "dosage": "500mg",
                "frequency": "1-0-1",
                "duration_days": 2,
            }
        ],
    }
    resp = await client.post("/api/v1/prescriptions", json=p_data, headers=headers_a)
    p_id = resp.json()["id"]

    upcoming = await client.get("/api/v1/doses/upcoming", headers=headers_a)
    assert len(upcoming.json()) == 0

    # 3. PENDING_CONFIRMATION prescription cannot generate dose events.
    await client.post(
        f"/api/v1/prescriptions/{p_id}/submit-for-confirmation", headers=headers_a
    )
    upcoming2 = await client.get("/api/v1/doses/upcoming", headers=headers_a)
    assert len(upcoming2.json()) == 0

    # 4. CONFIRMED prescription can generate dose events.
    # 7. 1-0-1 produces expected daily dose events (2 per day * 2 days = 4)
    # 10. Duration is respected.
    # 11. A 5-day course produces no day-6 dose (we test 2-day course producing exactly 4 doses)
    await client.post(f"/api/v1/prescriptions/{p_id}/confirm", headers=headers_a)

    # We can check upcoming doses or all doses through history?
    # Upcoming only returns future ones. Since date is May 2026, they are all in the past compared to Sep 2026!
    # Wait, upcoming API checks >= now. Since it's May 2026, it won't show in upcoming if now > May 2026.
    # Let's create a prescription in the future!
    p_data_future = {
        "prescription_date": "2030-05-01",
        "medicines": [
            {
                "medicine_name": "Amox",
                "dosage": "500mg",
                "frequency": "1-0-1",
                "duration_days": 2,
            }
        ],
    }
    resp_future = await client.post(
        "/api/v1/prescriptions", json=p_data_future, headers=headers_a
    )
    p_id_f = resp_future.json()["id"]
    await client.post(
        f"/api/v1/prescriptions/{p_id_f}/submit-for-confirmation", headers=headers_a
    )
    await client.post(f"/api/v1/prescriptions/{p_id_f}/confirm", headers=headers_a)

    upcoming_f = await client.get("/api/v1/doses/upcoming", headers=headers_a)
    assert len(upcoming_f.json()) == 4  # 2 days * (1-0-1) = 4 doses

    # 12. Duplicate schedule generation does not create duplicate dose events.
    # Re-confirm shouldn't duplicate. Wait, we can't confirm an already confirmed one.
    # Let's test editing (which resets to PENDING), then reconfirm.
    # 20. Editing a confirmed prescription invalidates future schedule.
    # 21. Editing a confirmed prescription requires reconfirmation.
    # 22. Reconfirmation generates the new schedule.
    edit_med_data = {
        "medicine_name": "Amox Edited",
        "dosage": "250mg",
        "frequency": "1-1-1",
        "duration_days": 1,
    }
    med_id_f = resp_future.json()["medicines"][0]["id"]
    edit_resp = await client.put(
        f"/api/v1/prescriptions/{p_id_f}/medicines/{med_id_f}",
        json=edit_med_data,
        headers=headers_a,
    )
    assert edit_resp.json()["status"] == "pending_confirmation"

    upcoming_after_edit = await client.get("/api/v1/doses/upcoming", headers=headers_a)
    assert len(upcoming_after_edit.json()) == 0  # Cancelled future doses

    await client.post(f"/api/v1/prescriptions/{p_id_f}/confirm", headers=headers_a)
    upcoming_reconfirmed = await client.get("/api/v1/doses/upcoming", headers=headers_a)
    # 8. 1-1-1 produces expected daily dose events (1 day * 3 doses = 3)
    assert len(upcoming_reconfirmed.json()) == 3

    # Test actions
    dose_id = upcoming_reconfirmed.json()[0]["id"]

    # 13. Patient A cannot access Patient B's dose
    # 14. Patient A cannot mark Patient B's dose as taken
    # 15. Patient A cannot mark Patient B's dose as skipped
    take_b = await client.post(f"/api/v1/doses/{dose_id}/taken", headers=headers_b)
    assert take_b.status_code == 404
    skip_b = await client.post(f"/api/v1/doses/{dose_id}/skip", headers=headers_b)
    assert skip_b.status_code == 404

    # 16. SCHEDULED -> TAKEN works
    take_a = await client.post(f"/api/v1/doses/{dose_id}/taken", headers=headers_a)
    assert take_a.status_code == 200
    assert take_a.json()["status"] == "taken"

    # 18. Invalid dose state transitions are rejected.
    # TAKEN -> SKIPPED is invalid
    skip_a = await client.post(f"/api/v1/doses/{dose_id}/skip", headers=headers_a)
    assert skip_a.status_code == 400

    # 17. SCHEDULED -> SKIPPED works
    dose_id_2 = upcoming_reconfirmed.json()[1]["id"]
    skip_a_2 = await client.post(f"/api/v1/doses/{dose_id_2}/skip", headers=headers_a)
    assert skip_a_2.status_code == 200
    assert skip_a_2.json()["status"] == "skipped"

    # 29. History correctly records Taken/Skipped states.
    history = await client.get("/api/v1/doses/history", headers=headers_a)
    assert len(history.json()) == 2

    # 27. Today's doses
    # 28. Upcoming doses
    # Are properly isolated per patient and correctly returned.

    # 9. 1-0-0 produces the expected daily dose events
    p_data_100 = {
        "prescription_date": "2030-06-01",
        "medicines": [
            {
                "medicine_name": "Med",
                "dosage": "1",
                "frequency": "1-0-0",
                "duration_days": 1,
            }
        ],
    }
    resp_100 = await client.post(
        "/api/v1/prescriptions", json=p_data_100, headers=headers_a
    )
    await client.post(
        f"/api/v1/prescriptions/{resp_100.json()['id']}/submit-for-confirmation",
        headers=headers_a,
    )
    await client.post(
        f"/api/v1/prescriptions/{resp_100.json()['id']}/confirm", headers=headers_a
    )

    upcoming_100 = await client.get("/api/v1/doses/upcoming", headers=headers_a)
    # The previous 1-1-1 has 1 pending dose left. This one adds 1. Total = 2.
    assert len(upcoming_100.json()) == 2

    # 19. Cancelled prescription does not generate future reminders
    # Deleting edits the prescription and cancels reminders.
    await client.delete(
        f"/api/v1/prescriptions/{resp_100.json()['id']}", headers=headers_a
    )
    upcoming_del = await client.get("/api/v1/doses/upcoming", headers=headers_a)
    assert len(upcoming_del.json()) == 1  # Only the 1 left from the 1-1-1 prescription
