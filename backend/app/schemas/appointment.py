from datetime import datetime
from uuid import UUID

from pydantic import BaseModel, ConfigDict

from app.models.appointment import AppointmentStatus


class AppointmentBase(BaseModel):
    doctor_name: str
    clinic_name: str | None = None
    appointment_datetime: datetime
    timezone: str | None = None
    notes: str | None = None


class AppointmentCreate(AppointmentBase):
    pass


class AppointmentUpdate(BaseModel):
    doctor_name: str | None = None
    clinic_name: str | None = None
    appointment_datetime: datetime | None = None
    timezone: str | None = None
    notes: str | None = None
    status: AppointmentStatus | None = None


class AppointmentResponse(AppointmentBase):
    id: UUID
    patient_id: UUID
    status: AppointmentStatus

    model_config = ConfigDict(from_attributes=True)
