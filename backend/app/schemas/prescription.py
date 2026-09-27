import re
from datetime import date, time
from uuid import UUID

from pydantic import BaseModel, ConfigDict, Field, field_validator

from app.models.prescription import FoodTiming, PrescriptionStatus


class MedicineScheduleBase(BaseModel):
    scheduled_time: time


class MedicineScheduleResponse(MedicineScheduleBase):
    id: UUID
    prescription_medicine_id: UUID
    model_config = ConfigDict(from_attributes=True)


class PrescriptionMedicineBase(BaseModel):
    medicine_name: str = Field(..., min_length=1)
    dosage: str = Field(..., min_length=1)
    frequency: str = Field(..., description="E.g., 1-0-1 or 1-1-1")
    duration_days: int = Field(..., gt=0)
    food_timing: FoodTiming = FoodTiming.NO_INSTRUCTION
    instructions: str | None = None

    @field_validator("frequency")
    @classmethod
    def validate_frequency(cls, v: str) -> str:
        if not re.match(r"^\d(-\d)+$", v):
            raise ValueError("Frequency must be in format like 1-0-1 or 1-1-1-1")
        return v


class PrescriptionMedicineCreate(PrescriptionMedicineBase):
    pass


class PrescriptionMedicineResponse(PrescriptionMedicineBase):
    id: UUID
    prescription_id: UUID
    schedules: list[MedicineScheduleResponse] = []
    model_config = ConfigDict(from_attributes=True)


class PrescriptionBase(BaseModel):
    doctor_name: str | None = None
    clinic_name: str | None = None
    prescription_date: date
    notes: str | None = None


class PrescriptionCreate(PrescriptionBase):
    medicines: list[PrescriptionMedicineCreate] = []


class PrescriptionUpdate(BaseModel):
    status: PrescriptionStatus | None = None
    doctor_name: str | None = None
    clinic_name: str | None = None
    notes: str | None = None


class PrescriptionResponse(PrescriptionBase):
    id: UUID
    patient_id: UUID
    status: PrescriptionStatus
    medicines: list[PrescriptionMedicineResponse] = []
    model_config = ConfigDict(from_attributes=True)


class PrescriptionConfirmationResponse(PrescriptionResponse):
    safety: dict | None = (
        None  # We'll use a dict here to avoid circular imports or redefining the model
    )
