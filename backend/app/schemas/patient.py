from datetime import date
from uuid import UUID

from pydantic import BaseModel, ConfigDict


class PatientProfileBase(BaseModel):
    full_name: str
    date_of_birth: date | None = None
    blood_group: str | None = None
    emergency_contact: str | None = None
    medical_notes: str | None = None
    timezone: str = "UTC"


class PatientProfileCreate(PatientProfileBase):
    pass


class PatientProfileUpdate(PatientProfileBase):
    full_name: str | None = None


class PatientProfileResponse(PatientProfileBase):
    id: UUID
    user_id: UUID
    model_config = ConfigDict(from_attributes=True)
