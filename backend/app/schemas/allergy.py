from pydantic import BaseModel, ConfigDict
from typing import Optional
from uuid import UUID
from app.models.allergy import AllergyType, AllergySeverity


class AllergyBase(BaseModel):
    allergen_name: str
    allergy_type: AllergyType = AllergyType.DRUG
    severity: AllergySeverity = AllergySeverity.MODERATE
    reaction_notes: Optional[str] = None


class AllergyCreate(AllergyBase):
    pass


class AllergyResponse(AllergyBase):
    id: UUID
    patient_id: UUID
    model_config = ConfigDict(from_attributes=True)
