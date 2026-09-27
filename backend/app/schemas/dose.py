from datetime import datetime
from uuid import UUID

from pydantic import BaseModel, ConfigDict

from app.models.prescription import DoseStatus, FoodTiming


class DoseEventResponse(BaseModel):
    id: UUID
    prescription_id: UUID
    prescription_medicine_id: UUID
    scheduled_at: datetime
    status: DoseStatus
    taken_at: datetime | None = None
    skipped_at: datetime | None = None
    skip_reason: str | None = None

    # Optional expanded information for the "Today" view
    medicine_name: str | None = None
    dosage: str | None = None
    food_timing: FoodTiming | None = None

    model_config = ConfigDict(from_attributes=True)
