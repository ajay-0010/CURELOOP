import enum
import uuid

from sqlalchemy import Column, DateTime, Enum, ForeignKey, String, Text
from sqlalchemy import Uuid as UUID
from sqlalchemy.orm import relationship

from app.db.base_class import Base


class AppointmentStatus(str, enum.Enum):
    SCHEDULED = "scheduled"
    COMPLETED = "completed"
    CANCELLED = "cancelled"


class Appointment(Base):
    __tablename__ = "appointments"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    patient_id = Column(
        UUID(as_uuid=True),
        ForeignKey("patient_profiles.id", ondelete="CASCADE"),
        nullable=False,
    )

    doctor_name = Column(String, nullable=False)
    clinic_name = Column(String, nullable=True)

    # Stored in canonical UTC
    appointment_datetime = Column(DateTime(timezone=True), nullable=False)

    # Optional patient-specified timezone, falls back to patient_profile.timezone
    timezone = Column(String, nullable=True)

    notes = Column(Text, nullable=True)
    status = Column(
        Enum(AppointmentStatus), default=AppointmentStatus.SCHEDULED, nullable=False
    )

    patient = relationship("PatientProfile", backref="appointments")
