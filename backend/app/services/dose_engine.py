from datetime import datetime, timedelta
from zoneinfo import ZoneInfo

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from app.models.patient import PatientProfile
from app.models.prescription import DoseEvent, DoseStatus, Prescription


async def generate_dose_events_for_prescription(
    prescription: Prescription, patient: PatientProfile, db: AsyncSession
) -> list[DoseEvent]:
    """
    Generates DoseEvents for a confirmed prescription.
    Idempotent: Replaces existing future events or skips if already generated.
    """
    if prescription.status != "confirmed":
        return []

    # Get patient timezone
    tz = ZoneInfo(patient.timezone or "UTC")

    # Fetch existing dose events to ensure idempotency
    stmt = select(DoseEvent).where(DoseEvent.prescription_id == prescription.id)
    result = await db.execute(stmt)
    existing_events = result.scalars().all()

    # We will clear existing UNTAKEN/UNSKIPPED future events and regenerate them
    # to handle edits or re-confirmations properly.
    events_to_keep = [
        e for e in existing_events if e.status in (DoseStatus.TAKEN, DoseStatus.SKIPPED)
    ]
    events_to_delete = [e for e in existing_events if e not in events_to_keep]
    for e in events_to_delete:
        await db.delete(e)

    new_events = []

    for medicine in prescription.medicines:
        for day_offset in range(medicine.duration_days):
            current_date = prescription.prescription_date + timedelta(days=day_offset)

            for schedule in medicine.schedules:
                # Combine date and time in the patient's local timezone
                local_dt = datetime.combine(
                    current_date, schedule.scheduled_time, tzinfo=tz
                )

                # Convert to UTC for canonical DB storage
                utc_dt = local_dt.astimezone(ZoneInfo("UTC"))

                # Check if this exact slot was already kept (e.g. taken/skipped)
                already_exists = False
                for kept in events_to_keep:
                    if (
                        kept.prescription_medicine_id == medicine.id
                        and kept.scheduled_at == utc_dt
                    ):
                        already_exists = True
                        break

                if not already_exists:
                    dose = DoseEvent(
                        prescription_id=prescription.id,
                        prescription_medicine_id=medicine.id,
                        medicine=medicine,
                        scheduled_at=utc_dt,
                        status=DoseStatus.SCHEDULED,
                    )
                    db.add(dose)
                    new_events.append(dose)

    return new_events


async def cancel_future_doses(prescription_id, db: AsyncSession):
    """
    Cancels all pending doses for a prescription.
    Used when a prescription is edited (re-entering PENDING_CONFIRMATION) or CANCELLED.
    """
    stmt = select(DoseEvent).where(
        DoseEvent.prescription_id == prescription_id,
        DoseEvent.status == DoseStatus.SCHEDULED,
    )
    result = await db.execute(stmt)
    pending_doses = result.scalars().all()

    for dose in pending_doses:
        await db.delete(dose)
