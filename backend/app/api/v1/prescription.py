from uuid import UUID

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy.orm import selectinload

from app.api.v1.allergy import get_patient_profile_or_404
from app.core.security import get_current_user
from app.db.database import get_db
from app.models.prescription import (
    Prescription,
    PrescriptionMedicine,
    PrescriptionStatus,
)
from app.models.user import User
from app.schemas.prescription import (
    PrescriptionCreate,
    PrescriptionResponse,
    PrescriptionUpdate,
)
from app.services.schedule_engine import generate_schedules_for_frequency

router = APIRouter(prefix="/prescriptions", tags=["prescription"])


@router.post(
    "", response_model=PrescriptionResponse, status_code=status.HTTP_201_CREATED
)
async def create_prescription(
    data: PrescriptionCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    profile = await get_patient_profile_or_404(current_user, db)

    # Create Prescription
    prescription = Prescription(
        patient_id=profile.id,
        doctor_name=data.doctor_name,
        clinic_name=data.clinic_name,
        prescription_date=data.prescription_date,
        notes=data.notes,
        status=PrescriptionStatus.DRAFT,  # Always start as DRAFT
    )

    # Create Medicines and Schedules
    for med_data in data.medicines:
        medicine = PrescriptionMedicine(
            medicine_name=med_data.medicine_name,
            dosage=med_data.dosage,
            frequency=med_data.frequency,
            duration_days=med_data.duration_days,
            food_timing=med_data.food_timing,
            instructions=med_data.instructions,
        )

        # Generate schedules
        schedules = generate_schedules_for_frequency(medicine.frequency)
        medicine.schedules.extend(schedules)

        prescription.medicines.append(medicine)

    db.add(prescription)
    await db.commit()
    await db.refresh(prescription)

    # Reload with relationships to return complete response
    stmt = (
        select(Prescription)
        .options(
            selectinload(Prescription.medicines).selectinload(
                PrescriptionMedicine.schedules
            )
        )
        .where(Prescription.id == prescription.id)
    )
    result = await db.execute(stmt)
    full_prescription = result.scalar_one()

    return full_prescription


@router.get("", response_model=list[PrescriptionResponse])
async def get_prescriptions(
    current_user: User = Depends(get_current_user), db: AsyncSession = Depends(get_db)
):
    profile = await get_patient_profile_or_404(current_user, db)
    stmt = (
        select(Prescription)
        .options(
            selectinload(Prescription.medicines).selectinload(
                PrescriptionMedicine.schedules
            )
        )
        .where(Prescription.patient_id == profile.id)
    )

    result = await db.execute(stmt)
    prescriptions = result.scalars().all()
    return prescriptions


@router.get("/{id}", response_model=PrescriptionResponse)
async def get_prescription(
    id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    profile = await get_patient_profile_or_404(current_user, db)
    stmt = (
        select(Prescription)
        .options(
            selectinload(Prescription.medicines).selectinload(
                PrescriptionMedicine.schedules
            )
        )
        .where(Prescription.id == id, Prescription.patient_id == profile.id)
    )

    result = await db.execute(stmt)
    prescription = result.scalar_one_or_none()

    if not prescription:
        raise HTTPException(status_code=404, detail="Prescription not found")

    return prescription


@router.put("/{id}", response_model=PrescriptionResponse)
async def update_prescription(
    id: UUID,
    data: PrescriptionUpdate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    profile = await get_patient_profile_or_404(current_user, db)
    stmt = (
        select(Prescription)
        .options(
            selectinload(Prescription.medicines).selectinload(
                PrescriptionMedicine.schedules
            )
        )
        .where(Prescription.id == id, Prescription.patient_id == profile.id)
    )

    result = await db.execute(stmt)
    prescription = result.scalar_one_or_none()

    if not prescription:
        raise HTTPException(status_code=404, detail="Prescription not found")

    # We only allow updating top-level fields for now
    update_data = data.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(prescription, key, value)

    await db.commit()
    await db.refresh(prescription)
    return prescription


@router.delete("/{id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_prescription(
    id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    profile = await get_patient_profile_or_404(current_user, db)
    stmt = select(Prescription).where(
        Prescription.id == id, Prescription.patient_id == profile.id
    )
    result = await db.execute(stmt)
    prescription = result.scalar_one_or_none()

    if not prescription:
        raise HTTPException(status_code=404, detail="Prescription not found")

    await db.delete(prescription)
    await db.commit()
