import enum
import uuid

from sqlalchemy import (
    JSON,
    Column,
    Date,
    DateTime,
    Enum,
    ForeignKey,
    Integer,
    String,
    Text,
    Time,
)
from sqlalchemy import Uuid as UUID
from sqlalchemy.orm import backref, relationship

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
    ocr_raw_text = Column(Text, nullable=True)
    ocr_metadata = Column(JSON, nullable=True)
    status = Column(Enum(PrescriptionStatus), default=PrescriptionStatus.DRAFT)

    explicit_patient_consent_timestamp = Column(DateTime(timezone=True), nullable=True)
    confirmed_at = Column(DateTime(timezone=True), nullable=True)
    confirmed_by_patient_id = Column(
        UUID(as_uuid=True), ForeignKey("patient_profiles.id"), nullable=True
    )

    patient = relationship(
        "PatientProfile", backref="prescriptions", foreign_keys=[patient_id]
    )
    medicines = relationship(
        "PrescriptionMedicine", backref="prescription", cascade="all, delete-orphan"
    )
    documents = relationship(
        "PrescriptionDocument", backref="prescription", cascade="all, delete-orphan"
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


class PrescriptionDocument(Base):
    __tablename__ = "prescription_documents"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    prescription_id = Column(
        UUID(as_uuid=True),
        ForeignKey("prescriptions.id", ondelete="CASCADE"),
        nullable=False,
    )
    storage_provider = Column(String, nullable=False, default="local")
    object_key = Column(String, nullable=False, unique=True)
    original_filename = Column(String, nullable=False)
    content_type = Column(String, nullable=False)
    file_size = Column(Integer, nullable=False)


class DoseStatus(str, enum.Enum):
    SCHEDULED = "scheduled"
    TAKEN = "taken"
    SKIPPED = "skipped"
    EXPIRED = "expired"


class DoseEvent(Base):
    __tablename__ = "dose_events"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    prescription_id = Column(
        UUID(as_uuid=True),
        ForeignKey("prescriptions.id", ondelete="CASCADE"),
        nullable=False,
    )
    prescription_medicine_id = Column(
        UUID(as_uuid=True),
        ForeignKey("prescription_medicines.id", ondelete="CASCADE"),
        nullable=False,
    )

    scheduled_at = Column(DateTime(timezone=True), nullable=False)
    status = Column(Enum(DoseStatus), default=DoseStatus.SCHEDULED)

    taken_at = Column(DateTime(timezone=True), nullable=True)
    skipped_at = Column(DateTime(timezone=True), nullable=True)
    skip_reason = Column(String, nullable=True)

    prescription = relationship(
        "Prescription", backref=backref("dose_events", cascade="all, delete-orphan")
    )
    medicine = relationship(
        "PrescriptionMedicine",
        backref=backref("dose_events", cascade="all, delete-orphan"),
    )
