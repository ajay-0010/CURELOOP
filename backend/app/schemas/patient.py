from pydantic import BaseModel, ConfigDict
from typing import Optional
from datetime import date
from uuid import UUID


class PatientProfileBase(BaseModel):
    full_name: str
    date_of_birth: Optional[date] = None
    blood_group: Optional[str] = None
    emergency_contact: Optional[str] = None
    medical_notes: Optional[str] = None


class PatientProfileCreate(PatientProfileBase):
    pass


class PatientProfileUpdate(PatientProfileBase):
    full_name: Optional[str] = None


class PatientProfileResponse(PatientProfileBase):
    id: UUID
    user_id: UUID
    model_config = ConfigDict(from_attributes=True)
