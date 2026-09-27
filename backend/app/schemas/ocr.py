from uuid import UUID

from pydantic import BaseModel

from app.services.ocr_engine import CandidateMedicine


class OCRExtractionResponse(BaseModel):
    prescription_id: UUID
    document_key: str
    doctor_name: str | None
    medicines: list[CandidateMedicine]
    raw_text: str
    provider_name: str
