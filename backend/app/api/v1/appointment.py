from datetime import datetime, timezone
from uuid import UUID

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from app.core.security import get_current_user
from app.db.database import get_db
from app.api.v1.allergy import get_patient_profile_or_404
from app.models.appointment import Appointment, AppointmentStatus
from app.models.user import User
from app.schemas.appointment import AppointmentCreate, AppointmentResponse, AppointmentUpdate
from app.services.reminder_service import ReminderService
from zoneinfo import ZoneInfo

router = APIRouter(prefix="/appointments", tags=["appointments"])

@router.post("", response_model=AppointmentResponse, status_code=status.HTTP_201_CREATED)
async def create_appointment(
    data: AppointmentCreate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    profile = await get_patient_profile_or_404(current_user, db)
    
    # Store datetime in canonical UTC
    appt_dt = data.appointment_datetime
    if not appt_dt.tzinfo:
        appt_dt = appt_dt.replace(tzinfo=ZoneInfo(profile.timezone or "UTC"))
    
    utc_dt = appt_dt.astimezone(ZoneInfo("UTC"))
    
    if utc_dt < datetime.now(timezone.utc):
        raise HTTPException(status_code=400, detail="Cannot schedule appointments in the past.")

    appointment = Appointment(
        patient_id=profile.id,
        doctor_name=data.doctor_name,
        clinic_name=data.clinic_name,
        appointment_datetime=utc_dt,
        timezone=data.timezone or profile.timezone,
        notes=data.notes,
        status=AppointmentStatus.SCHEDULED
    )
    
    db.add(appointment)
    await db.commit()
    await db.refresh(appointment)
    
    await ReminderService.schedule_appointment_reminders(appointment)
    
    return appointment

@router.get("", response_model=list[AppointmentResponse])
async def get_appointments(
    filter: str = "upcoming", # "upcoming" or "past"
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    profile = await get_patient_profile_or_404(current_user, db)
    
    stmt = select(Appointment).where(Appointment.patient_id == profile.id)
    
    now = datetime.now(timezone.utc)
    if filter == "upcoming":
        stmt = stmt.where(Appointment.appointment_datetime >= now, Appointment.status == AppointmentStatus.SCHEDULED).order_by(Appointment.appointment_datetime.asc())
    elif filter == "past":
        from sqlalchemy import or_
        stmt = stmt.where(
            or_(
                Appointment.appointment_datetime < now,
                Appointment.status != AppointmentStatus.SCHEDULED
            )
        ).order_by(Appointment.appointment_datetime.desc())
    else:
        stmt = stmt.order_by(Appointment.appointment_datetime.desc())
        
    result = await db.execute(stmt)
    return result.scalars().all()

@router.get("/{id}", response_model=AppointmentResponse)
async def get_appointment(
    id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    profile = await get_patient_profile_or_404(current_user, db)
    stmt = select(Appointment).where(Appointment.id == id, Appointment.patient_id == profile.id)
    result = await db.execute(stmt)
    appointment = result.scalar_one_or_none()
    
    if not appointment:
        raise HTTPException(status_code=404, detail="Appointment not found")
        
    return appointment

@router.put("/{id}", response_model=AppointmentResponse)
async def update_appointment(
    id: UUID,
    data: AppointmentUpdate,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    profile = await get_patient_profile_or_404(current_user, db)
    stmt = select(Appointment).where(Appointment.id == id, Appointment.patient_id == profile.id)
    result = await db.execute(stmt)
    appointment = result.scalar_one_or_none()
    
    if not appointment:
        raise HTTPException(status_code=404, detail="Appointment not found")
        
    await ReminderService.cancel_appointment_reminders(str(appointment.id), str(profile.id))
    
    update_data = data.model_dump(exclude_unset=True)
    if "appointment_datetime" in update_data:
        appt_dt = update_data["appointment_datetime"]
        if not appt_dt.tzinfo:
            appt_dt = appt_dt.replace(tzinfo=ZoneInfo(profile.timezone or "UTC"))
        appointment.appointment_datetime = appt_dt.astimezone(ZoneInfo("UTC"))
        del update_data["appointment_datetime"]
        
    for key, value in update_data.items():
        setattr(appointment, key, value)
        
    await db.commit()
    await db.refresh(appointment)
    
    if appointment.status == AppointmentStatus.SCHEDULED:
        await ReminderService.schedule_appointment_reminders(appointment)
        
    return appointment

@router.delete("/{id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_appointment(
    id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    profile = await get_patient_profile_or_404(current_user, db)
    stmt = select(Appointment).where(Appointment.id == id, Appointment.patient_id == profile.id)
    result = await db.execute(stmt)
    appointment = result.scalar_one_or_none()
    
    if not appointment:
        raise HTTPException(status_code=404, detail="Appointment not found")
        
    await ReminderService.cancel_appointment_reminders(str(appointment.id), str(profile.id))
    
    await db.delete(appointment)
    await db.commit()
    return None

@router.post("/{id}/complete", response_model=AppointmentResponse)
async def complete_appointment(
    id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    profile = await get_patient_profile_or_404(current_user, db)
    stmt = select(Appointment).where(Appointment.id == id, Appointment.patient_id == profile.id)
    result = await db.execute(stmt)
    appointment = result.scalar_one_or_none()
    
    if not appointment:
        raise HTTPException(status_code=404, detail="Appointment not found")
        
    await ReminderService.cancel_appointment_reminders(str(appointment.id), str(profile.id))
    appointment.status = AppointmentStatus.COMPLETED
    await db.commit()
    await db.refresh(appointment)
    
    return appointment

