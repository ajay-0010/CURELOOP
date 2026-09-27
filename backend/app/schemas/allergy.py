from uuid import UUID

from pydantic import BaseModel, ConfigDict

from app.models.allergy import AllergySeverity, AllergyType


class AllergyBase(BaseModel):
    allergen_name: str
    allergy_type: AllergyType = AllergyType.DRUG
    severity: AllergySeverity = AllergySeverity.MODERATE
    reaction_notes: str | None = None


class AllergyCreate(AllergyBase):
    pass


class AllergyResponse(AllergyBase):
    id: UUID
    patient_id: UUID
    model_config = ConfigDict(from_attributes=True)
