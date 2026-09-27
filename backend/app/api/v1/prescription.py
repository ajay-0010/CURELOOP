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

    # Prevent direct status bypass to CONFIRMED or PENDING_CONFIRMATION
    update_data = data.model_dump(exclude_unset=True)
    if "status" in update_data:
        new_status = update_data["status"]
        if new_status in [
            PrescriptionStatus.CONFIRMED,
            PrescriptionStatus.PENDING_CONFIRMATION,
        ]:
            raise HTTPException(
                status_code=400,
                detail="Cannot bypass confirmation flow. Use dedicated endpoints.",
            )

    # We only allow updating top-level fields for now via this generic endpoint.
    # If a patient edits their prescription (e.g., notes, doctor), we invalidate confirmation.
    # In a full app, modifying nested medicines also triggers this.
    has_material_change = False
    for key, value in update_data.items():
        if getattr(prescription, key) != value:
            setattr(prescription, key, value)
            if key not in [
                "status",
                "notes",
            ]:  # doctor_name, clinic_name, etc. might be material? Yes.
                has_material_change = True

    if has_material_change and prescription.status == PrescriptionStatus.CONFIRMED:
        # Invalidate confirmation
        prescription.status = PrescriptionStatus.PENDING_CONFIRMATION
        prescription.explicit_patient_consent_timestamp = None
        prescription.confirmed_at = None
        prescription.confirmed_by_patient_id = None

    profile_id = profile.id
    await db.commit()
    stmt = (
        select(Prescription)
        .options(
            selectinload(Prescription.medicines).selectinload(
                PrescriptionMedicine.schedules
            )
        )
        .where(Prescription.id == id, Prescription.patient_id == profile_id)
    )
    result = await db.execute(stmt)
    return result.scalar_one()


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


from datetime import datetime, timezone

from app.models.allergy import Allergy
from app.schemas.prescription import (
    PrescriptionConfirmationResponse,
    PrescriptionMedicineCreate,
)
from app.services.safety_engine import safety_engine


@router.put("/{id}/medicines/{med_id}", response_model=PrescriptionResponse)
async def update_prescription_medicine(
    id: UUID,
    med_id: UUID,
    data: PrescriptionMedicineCreate,
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

    medicine = next((m for m in prescription.medicines if m.id == med_id), None)
    if not medicine:
        raise HTTPException(status_code=404, detail="Medicine not found")

    has_change = False
    update_data = data.model_dump()
    for key, value in update_data.items():
        if getattr(medicine, key) != value:
            setattr(medicine, key, value)
            has_change = True

    if has_change:
        if "frequency" in update_data:
            medicine.schedules.clear()
            schedules = generate_schedules_for_frequency(medicine.frequency)
            medicine.schedules.extend(schedules)

        if prescription.status == PrescriptionStatus.CONFIRMED:
            prescription.status = PrescriptionStatus.PENDING_CONFIRMATION
            prescription.explicit_patient_consent_timestamp = None
            prescription.confirmed_at = None
            prescription.confirmed_by_patient_id = None

    profile_id = profile.id
    await db.commit()
    stmt = (
        select(Prescription)
        .options(
            selectinload(Prescription.medicines).selectinload(
                PrescriptionMedicine.schedules
            )
        )
        .where(Prescription.id == id, Prescription.patient_id == profile_id)
    )
    result = await db.execute(stmt)
    return result.scalar_one()


@router.post("/{id}/submit-for-confirmation", response_model=PrescriptionResponse)
async def submit_for_confirmation(
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

    if prescription.status != PrescriptionStatus.DRAFT:
        raise HTTPException(
            status_code=400, detail="Only DRAFT prescriptions can be submitted."
        )

    prescription.status = PrescriptionStatus.PENDING_CONFIRMATION
    profile_id = profile.id
    await db.commit()
    stmt = (
        select(Prescription)
        .options(
            selectinload(Prescription.medicines).selectinload(
                PrescriptionMedicine.schedules
            )
        )
        .where(Prescription.id == id, Prescription.patient_id == profile_id)
    )
    result = await db.execute(stmt)
    return result.scalar_one()


@router.get("/{id}/safety-check", response_model=dict)
async def get_safety_check(
    id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    profile = await get_patient_profile_or_404(current_user, db)

    stmt = (
        select(Prescription)
        .options(selectinload(Prescription.medicines))
        .where(Prescription.id == id, Prescription.patient_id == profile.id)
    )
    result = await db.execute(stmt)
    prescription = result.scalar_one_or_none()

    if not prescription:
        raise HTTPException(status_code=404, detail="Prescription not found")

    allergy_stmt = select(Allergy).where(Allergy.patient_id == profile.id)
    allergy_result = await db.execute(allergy_stmt)
    allergies = allergy_result.scalars().all()

    safety_result = safety_engine.check_prescription_safety(
        profile, prescription, prescription.medicines, allergies
    )
    return safety_result.model_dump()


@router.post("/{id}/confirm", response_model=PrescriptionConfirmationResponse)
async def confirm_prescription(
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

    if prescription.status != PrescriptionStatus.PENDING_CONFIRMATION:
        raise HTTPException(
            status_code=400,
            detail="Prescription must be PENDING_CONFIRMATION to confirm.",
        )

    allergy_stmt = select(Allergy).where(Allergy.patient_id == profile.id)
    allergy_result = await db.execute(allergy_stmt)
    allergies = allergy_result.scalars().all()

    safety_result = safety_engine.check_prescription_safety(
        profile, prescription, prescription.medicines, allergies
    )

    now = datetime.now(timezone.utc)
    prescription.status = PrescriptionStatus.CONFIRMED
    prescription.explicit_patient_consent_timestamp = now
    prescription.confirmed_at = now
    prescription.confirmed_by_patient_id = profile.id

    profile_id = profile.id
    await db.commit()
    stmt = (
        select(Prescription)
        .options(
            selectinload(Prescription.medicines).selectinload(
                PrescriptionMedicine.schedules
            )
        )
        .where(Prescription.id == id, Prescription.patient_id == profile_id)
    )
    result = await db.execute(stmt)
    prescription = result.scalar_one()

    resp_data = PrescriptionConfirmationResponse.model_validate(prescription)
    resp_data.safety = safety_result.model_dump()
    return resp_data



