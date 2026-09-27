from sqlalchemy import Column, String, Date, ForeignKey
from sqlalchemy import Uuid as UUID
from sqlalchemy.orm import relationship
from app.db.base_class import Base
import uuid


class PatientProfile(Base):
    __tablename__ = "patient_profiles"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        unique=True,
        nullable=False,
    )

    full_name = Column(String, nullable=False)
    date_of_birth = Column(Date, nullable=True)
    blood_group = Column(String, nullable=True)
    emergency_contact = Column(String, nullable=True)
    medical_notes = Column(String, nullable=True)

    user = relationship("User", backref="patient_profile")
