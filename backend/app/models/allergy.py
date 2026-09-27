from sqlalchemy import Column, String, Enum, ForeignKey
from sqlalchemy import Uuid as UUID
from sqlalchemy.orm import relationship
from app.db.base_class import Base
import uuid
import enum


class AllergyType(str, enum.Enum):
    DRUG = "drug"
    FOOD = "food"
    ENVIRONMENTAL = "environmental"
    OTHER = "other"


class AllergySeverity(str, enum.Enum):
    MILD = "mild"
    MODERATE = "moderate"
    SEVERE = "severe"
    ANAPHYLACTIC = "anaphylactic"


class Allergy(Base):
    __tablename__ = "allergies"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    patient_id = Column(
        UUID(as_uuid=True),
        ForeignKey("patient_profiles.id", ondelete="CASCADE"),
        nullable=False,
    )

    allergen_name = Column(String, nullable=False)
    allergy_type = Column(Enum(AllergyType), default=AllergyType.DRUG)
    severity = Column(Enum(AllergySeverity), default=AllergySeverity.MODERATE)
    reaction_notes = Column(String, nullable=True)

    patient = relationship("PatientProfile", backref="allergies")
