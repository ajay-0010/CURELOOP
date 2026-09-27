import enum
import uuid

from sqlalchemy import Column, Date, Enum, ForeignKey, Integer, String, Time
from sqlalchemy import Uuid as UUID
from sqlalchemy.orm import relationship

from app.db.base_class import Base


class PrescriptionStatus(str, enum.Enum):
    DRAFT = "draft"
    PENDING_CONFIRMATION = "pending_confirmation"
    CONFIRMED = "confirmed"
    COMPLETED = "completed"
    CANCELLED = "cancelled"


class FoodTiming(str, enum.Enum):
    BEFORE_FOOD = "before_food"
    AFTER_FOOD = "after_food"
    WITH_FOOD = "with_food"
    NO_INSTRUCTION = "no_instruction"


class Prescription(Base):
    __tablename__ = "prescriptions"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    patient_id = Column(
        UUID(as_uuid=True),
        ForeignKey("patient_profiles.id", ondelete="CASCADE"),
        nullable=False,
    )

    doctor_name = Column(String, nullable=True)
    clinic_name = Column(String, nullable=True)
    prescription_date = Column(Date, nullable=False)
    notes = Column(String, nullable=True)
    status = Column(Enum(PrescriptionStatus), default=PrescriptionStatus.DRAFT)

    patient = relationship("PatientProfile", backref="prescriptions")
    medicines = relationship(
        "PrescriptionMedicine", backref="prescription", cascade="all, delete-orphan"
    )


class PrescriptionMedicine(Base):
    __tablename__ = "prescription_medicines"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    prescription_id = Column(
        UUID(as_uuid=True),
        ForeignKey("prescriptions.id", ondelete="CASCADE"),
        nullable=False,
    )

    medicine_name = Column(String, nullable=False)
    dosage = Column(String, nullable=False)
    frequency = Column(String, nullable=False)  # e.g. "1-0-1"
    duration_days = Column(Integer, nullable=False)
    food_timing = Column(Enum(FoodTiming), default=FoodTiming.NO_INSTRUCTION)
    instructions = Column(String, nullable=True)

    schedules = relationship(
        "MedicineSchedule", backref="medicine", cascade="all, delete-orphan"
    )


class MedicineSchedule(Base):
    __tablename__ = "medicine_schedules"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    prescription_medicine_id = Column(
        UUID(as_uuid=True),
        ForeignKey("prescription_medicines.id", ondelete="CASCADE"),
        nullable=False,
    )

    # Represents the time of day a medicine should be taken
    scheduled_time = Column(Time, nullable=False)
