from datetime import datetime, timezone
from uuid import UUID

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy.orm import selectinload

from app.core.security import get_current_user
from app.db.database import get_db
from app.api.v1.allergy import get_patient_profile_or_404
from app.models.prescription import (
    DoseEvent,
    DoseStatus,
    Prescription,
    PrescriptionMedicine,
)
from app.models.user import User
from app.schemas.dose import DoseEventResponse

router = APIRouter(prefix="/doses", tags=["doses"])


async def _get_dose_and_verify_ownership(
    id: UUID, current_user: User, db: AsyncSession
):
    profile = await get_patient_profile_or_404(current_user, db)
    stmt = (
        select(DoseEvent)
        .join(Prescription)
        .where(DoseEvent.id == id, Prescription.patient_id == profile.id)
    )
    result = await db.execute(stmt)
    dose = result.scalar_one_or_none()

    if not dose:
        raise HTTPException(status_code=404, detail="Dose event not found")

    return dose


@router.post("/{id}/taken", response_model=DoseEventResponse)
async def mark_dose_taken(
    id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    dose = await _get_dose_and_verify_ownership(id, current_user, db)
    if dose.status not in (DoseStatus.SCHEDULED,):
        raise HTTPException(
            status_code=400, detail=f"Cannot mark {dose.status.value} dose as TAKEN."
        )

    dose.status = DoseStatus.TAKEN
    dose.taken_at = datetime.now(timezone.utc)
    await db.commit()
    await db.refresh(dose)
    return dose


@router.post("/{id}/skip", response_model=DoseEventResponse)
async def mark_dose_skipped(
    id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    dose = await _get_dose_and_verify_ownership(id, current_user, db)
    if dose.status not in (DoseStatus.SCHEDULED,):
        raise HTTPException(
            status_code=400, detail=f"Cannot mark {dose.status.value} dose as SKIPPED."
        )

    dose.status = DoseStatus.SKIPPED
    dose.skipped_at = datetime.now(timezone.utc)
    await db.commit()
    await db.refresh(dose)
    return dose


def _enrich_dose(dose: DoseEvent) -> DoseEventResponse:
    resp = DoseEventResponse.model_validate(dose)
    if dose.medicine:
        resp.medicine_name = dose.medicine.medicine_name
        resp.dosage = dose.medicine.dosage
        resp.food_timing = dose.medicine.food_timing
    return resp


@router.get("/today", response_model=list[DoseEventResponse])
async def get_today_doses(
    current_user: User = Depends(get_current_user), db: AsyncSession = Depends(get_db)
):
    profile = await get_patient_profile_or_404(current_user, db)
    now = datetime.now(timezone.utc)
    start_of_day = datetime(now.year, now.month, now.day, tzinfo=timezone.utc)
    end_of_day = datetime(now.year, now.month, now.day, 23, 59, 59, tzinfo=timezone.utc)

    stmt = (
        select(DoseEvent)
        .join(Prescription)
        .join(
            PrescriptionMedicine,
            DoseEvent.prescription_medicine_id == PrescriptionMedicine.id,
        )
        .options(selectinload(DoseEvent.medicine))
        .where(
            Prescription.patient_id == profile.id,
            DoseEvent.scheduled_at >= start_of_day,
            DoseEvent.scheduled_at <= end_of_day,
        )
        .order_by(DoseEvent.scheduled_at)
    )
    result = await db.execute(stmt)
    doses = result.scalars().all()

    return [_enrich_dose(d) for d in doses]


@router.get("/upcoming", response_model=list[DoseEventResponse])
async def get_upcoming_doses(
    current_user: User = Depends(get_current_user), db: AsyncSession = Depends(get_db)
):
    profile = await get_patient_profile_or_404(current_user, db)
    now = datetime.now(timezone.utc)

    stmt = (
        select(DoseEvent)
        .join(Prescription)
        .join(
            PrescriptionMedicine,
            DoseEvent.prescription_medicine_id == PrescriptionMedicine.id,
        )
        .options(selectinload(DoseEvent.medicine))
        .where(
            Prescription.patient_id == profile.id,
            DoseEvent.scheduled_at >= now,
            DoseEvent.status == DoseStatus.SCHEDULED,
        )
        .order_by(DoseEvent.scheduled_at)
        .limit(10)
    )
    result = await db.execute(stmt)
    doses = result.scalars().all()

    return [_enrich_dose(d) for d in doses]


@router.get("/history", response_model=list[DoseEventResponse])
async def get_dose_history(
    current_user: User = Depends(get_current_user), db: AsyncSession = Depends(get_db)
):
    profile = await get_patient_profile_or_404(current_user, db)

    stmt = (
        select(DoseEvent)
        .join(Prescription)
        .join(
            PrescriptionMedicine,
            DoseEvent.prescription_medicine_id == PrescriptionMedicine.id,
        )
        .options(selectinload(DoseEvent.medicine))
        .where(
            Prescription.patient_id == profile.id,
            DoseEvent.status.in_([DoseStatus.TAKEN, DoseStatus.SKIPPED]),
        )
        .order_by(DoseEvent.scheduled_at.desc())
    )
    result = await db.execute(stmt)
    doses = result.scalars().all()

    return [_enrich_dose(d) for d in doses]




