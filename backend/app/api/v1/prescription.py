from datetime import date
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
            ),
            selectinload(Prescription.documents),
        )
        .where(Prescription.id == prescription.id)
    )
    result = await db.execute(stmt)
    full_prescription = result.scalar_one()

    return full_prescription


@router.get("", response_model=list[PrescriptionResponse])
async def get_prescriptions(
    search: str | None = None,
    doctor: str | None = None,
    from_date: date | None = None,
    to_date: date | None = None,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    profile = await get_patient_profile_or_404(current_user, db)
    stmt = (
        select(Prescription)
        .options(
            selectinload(Prescription.medicines).selectinload(
                PrescriptionMedicine.schedules
            ),
            selectinload(Prescription.documents),
            selectinload(Prescription.documents),
        )
        .where(Prescription.patient_id == profile.id)
    )

    if doctor:
        stmt = stmt.where(Prescription.doctor_name.ilike(f"%{doctor}%"))
    if from_date:
        stmt = stmt.where(Prescription.prescription_date >= from_date)
    if to_date:
        stmt = stmt.where(Prescription.prescription_date <= to_date)
    if search:
        stmt = stmt.join(PrescriptionMedicine).where(
            PrescriptionMedicine.medicine_name.ilike(f"%{search}%")
        )

    result = await db.execute(stmt)
    prescriptions = result.scalars().unique().all()
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
            ),
            selectinload(Prescription.documents),
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
            ),
            selectinload(Prescription.documents),
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

        # Phase 5: Cancel doses and reminders
        from app.services.dose_engine import cancel_future_doses
        from app.services.reminder_service import ReminderService

        await cancel_future_doses(prescription.id, db)
        await ReminderService.cancel_reminders_for_prescription(prescription.id)

    profile_id = profile.id
    await db.commit()
    stmt = (
        select(Prescription)
        .options(
            selectinload(Prescription.medicines).selectinload(
                PrescriptionMedicine.schedules
            ),
            selectinload(Prescription.documents),
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
    stmt = (
        select(Prescription)
        .options(selectinload(Prescription.documents))
        .where(Prescription.id == id, Prescription.patient_id == profile.id)
    )
    result = await db.execute(stmt)
    prescription = result.scalar_one_or_none()

    if not prescription:
        raise HTTPException(status_code=404, detail="Prescription not found")

    # Delete associated documents via storage provider
    for doc in prescription.documents:
        await storage_provider.delete(doc.object_key)

    # Phase 5: Cancel reminders
    from app.services.reminder_service import ReminderService

    await ReminderService.cancel_reminders_for_prescription(prescription.id)

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
            ),
            selectinload(Prescription.documents),
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

        # Phase 5: Cancel doses and reminders
        from app.services.dose_engine import cancel_future_doses
        from app.services.reminder_service import ReminderService

        await cancel_future_doses(prescription.id, db)
        await ReminderService.cancel_reminders_for_prescription(prescription.id)

    profile_id = profile.id
    await db.commit()
    stmt = (
        select(Prescription)
        .options(
            selectinload(Prescription.medicines).selectinload(
                PrescriptionMedicine.schedules
            ),
            selectinload(Prescription.documents),
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
            ),
            selectinload(Prescription.documents),
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
            ),
            selectinload(Prescription.documents),
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
            ),
            selectinload(Prescription.documents),
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

    # Phase 5: Generate Doses
    from app.services.dose_engine import generate_dose_events_for_prescription
    from app.services.reminder_service import ReminderService

    doses = await generate_dose_events_for_prescription(prescription, profile, db)

    # Phase 5: Schedule Reminders
    await ReminderService.schedule_reminders_for_prescription(prescription, doses)

    profile_id = profile.id
    await db.commit()
    stmt = (
        select(Prescription)
        .options(
            selectinload(Prescription.medicines).selectinload(
                PrescriptionMedicine.schedules
            ),
            selectinload(Prescription.documents),
        )
        .where(Prescription.id == id, Prescription.patient_id == profile_id)
    )
    result = await db.execute(stmt)
    prescription = result.scalar_one()

    resp_data = PrescriptionConfirmationResponse.model_validate(prescription)
    resp_data.safety = safety_result.model_dump()
    return resp_data


from fastapi import File, UploadFile
from fastapi.responses import FileResponse

from app.models.prescription import PrescriptionDocument
from app.schemas.prescription import PrescriptionDocumentResponse
from app.services.storage_provider import storage_provider


@router.post(
    "/{id}/documents", response_model=PrescriptionDocumentResponse, status_code=201
)
async def upload_prescription_document(
    id: UUID,
    file: UploadFile = File(...),
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

    # File validation
    ALLOWED_TYPES = ["image/jpeg", "image/png", "application/pdf"]
    if file.content_type not in ALLOWED_TYPES:
        raise HTTPException(
            status_code=400,
            detail="Invalid file type. Only JPEG, PNG, and PDF are allowed.",
        )

    content = await file.read()
    if len(content) > 10 * 1024 * 1024:  # 10MB limit
        raise HTTPException(status_code=400, detail="File size exceeds 10MB limit.")

    object_key = await storage_provider.upload(
        content, file.filename, file.content_type
    )

    doc = PrescriptionDocument(
        prescription_id=prescription.id,
        storage_provider="local",
        object_key=object_key,
        original_filename=file.filename,
        content_type=file.content_type,
        file_size=len(content),
    )
    db.add(doc)
    await db.commit()
    await db.refresh(doc)

    return doc


@router.get("/documents/{object_key}", response_class=FileResponse)
async def get_prescription_document_file(
    object_key: str,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    # Security: Verify the user owns the prescription associated with this document
    profile = await get_patient_profile_or_404(current_user, db)

    stmt = (
        select(PrescriptionDocument)
        .join(Prescription)
        .where(
            PrescriptionDocument.object_key == object_key,
            Prescription.patient_id == profile.id,
        )
    )
    result = await db.execute(stmt)
    doc = result.scalar_one_or_none()

    if not doc:
        raise HTTPException(
            status_code=404, detail="Document not found or access denied"
        )

    # Local dev mode specific
    if hasattr(storage_provider, "get_local_path"):
        path = storage_provider.get_local_path(object_key)
        if path:
            return FileResponse(
                path, media_type=doc.content_type, filename=doc.original_filename
            )

    raise HTTPException(status_code=404, detail="File not found on disk")


from fastapi.responses import Response

from app.services.pdf_export import pdf_export_service


@router.get("/{id}/export/pdf", response_class=Response)
async def export_prescription_pdf(
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

    pdf_bytes = await pdf_export_service.export_prescription_to_pdf(
        prescription.id, profile.id
    )
    return Response(
        content=pdf_bytes,
        media_type="application/pdf",
        headers={
            "Content-Disposition": f'attachment; filename="prescription_{id}.pdf"'
        },
    )


