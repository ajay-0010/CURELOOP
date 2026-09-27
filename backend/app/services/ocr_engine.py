import re
from abc import ABC, abstractmethod
from typing import Any

from pydantic import BaseModel


class OCRResult(BaseModel):
    raw_text: str
    blocks: list[str] = []
    confidence_score: float | None = None
    provider_name: str


class ExtractedField(BaseModel):
    value: str | None
    confidence: str  # "HIGH", "MEDIUM", "LOW", "UNKNOWN"


class CandidateMedicine(BaseModel):
    medicine_name: ExtractedField
    dosage: ExtractedField
    frequency: ExtractedField
    duration_days: ExtractedField
    food_timing: ExtractedField


class BaseOCRProvider(ABC):
    @abstractmethod
    async def extract_text(self, image_bytes: bytes, filename: str) -> OCRResult:
        pass


class MockOCRProvider(BaseOCRProvider):
    async def extract_text(self, image_bytes: bytes, filename: str) -> OCRResult:
        """
        Deterministic mock provider returning different texts based on filename fixtures.
        """
        if "clean" in filename.lower():
            text = "Dr. Smith\nAmoxicillin 500mg 1-0-1 for 5 days after food\n"
        elif "messy" in filename.lower():
            text = "Dr. Messy\nAmoxcill 500 mg   1-1-1  5 d\n"
        elif "missing_dosage" in filename.lower():
            text = "Dr. NoDose\nAmoxicillin 1-0-1 for 5 days\n"
        elif "missing_duration" in filename.lower():
            text = "Dr. NoDuration\nAmoxicillin 500mg 1-0-1\n"
        elif "ambiguous" in filename.lower():
            text = "Dr. Amb\nUnknownMedX or something 500mg 1-0-0 3 days\n"
        elif "unreadable" in filename.lower():
            text = "x@!$*#&\n"
        else:
            text = "Dr. Generic\nCrocin 500mg 1-1-1 3 days\n"

        return OCRResult(
            raw_text=text, provider_name="MockOCRProvider", confidence_score=0.9
        )


class GoogleVisionOCRProvider(BaseOCRProvider):
    async def extract_text(self, image_bytes: bytes, filename: str) -> OCRResult:
        # Documented configuration requirement:
        # Requires GOOGLE_APPLICATION_CREDENTIALS pointing to service account.
        # Uses vision.ImageAnnotatorClient().
        raise NotImplementedError(
            "Real OCR requires cloud credentials. Use MockOCRProvider for local dev."
        )


class MedicineMatcher:
    def match(self, raw_name: str) -> tuple[str, str]:
        """
        Matches raw text to a normalized medicine name and returns confidence.
        """
        raw_lower = raw_name.lower().strip()
        if not raw_lower or "unreadable" in raw_lower or "x@!" in raw_lower:
            return raw_name, "UNKNOWN"

        # Mock database
        database = {
            "amox": "Amoxicillin",
            "amoxicillin": "Amoxicillin",
            "amoxcill": "Amoxicillin",
            "crocin": "Crocin",
            "paracetamol": "Paracetamol",
        }

        for k, v in database.items():
            if k in raw_lower:
                if len(k) == len(raw_lower):
                    return v, "HIGH"
                return v, "MEDIUM"

        return raw_name, "LOW"


class PrescriptionExtractionService:
    def __init__(self, matcher: MedicineMatcher):
        self.matcher = matcher

    def extract(self, ocr_result: OCRResult) -> dict[str, Any]:
        medicines = []

        # Split by lines
        lines = [
            line.strip() for line in ocr_result.raw_text.split("\n") if line.strip()
        ]
        doctor_name = lines[0] if lines else "Unknown Doctor"

        for line in lines[1:]:
            lower_line = line.lower()
            if "unreadable" in lower_line or "x@!" in lower_line:
                continue

            # Naive Regex Extractors
            dosage_match = re.search(r"(\d+\s*mg)", lower_line)
            freq_match = re.search(r"(\d-\d-\d)", lower_line)
            duration_match = re.search(r"(\d+)\s*d", lower_line)
            food_match = (
                "after_food"
                if "after food" in lower_line
                else ("before_food" if "before food" in lower_line else None)
            )

            # Medicine Name (assume first word)
            raw_med_name = line.split(" ")[0] if line else ""
            normalized_name, med_conf = self.matcher.match(raw_med_name)

            med = CandidateMedicine(
                medicine_name=ExtractedField(
                    value=normalized_name if normalized_name else None,
                    confidence=med_conf,
                ),
                dosage=ExtractedField(
                    value=dosage_match.group(1).replace(" ", "")
                    if dosage_match
                    else None,
                    confidence="HIGH" if dosage_match else "UNKNOWN",
                ),
                frequency=ExtractedField(
                    value=freq_match.group(1) if freq_match else None,
                    confidence="HIGH" if freq_match else "UNKNOWN",
                ),
                duration_days=ExtractedField(
                    value=duration_match.group(1) if duration_match else None,
                    confidence="HIGH" if duration_match else "UNKNOWN",
                ),
                food_timing=ExtractedField(
                    value=food_match, confidence="HIGH" if food_match else "UNKNOWN"
                ),
            )
            medicines.append(med)

        return {"doctor_name": doctor_name, "medicines": medicines}


# Global instances
ocr_provider = MockOCRProvider()
medicine_matcher = MedicineMatcher()
prescription_extractor = PrescriptionExtractionService(medicine_matcher)
