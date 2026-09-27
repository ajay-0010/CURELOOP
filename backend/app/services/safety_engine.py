import enum

from pydantic import BaseModel

from app.models.allergy import Allergy
from app.models.patient import PatientProfile
from app.models.prescription import Prescription, PrescriptionMedicine


class SafetyCheckStatus(str, enum.Enum):
    NO_MATCH_FOUND = "no_match_found"
    POTENTIAL_ALLERGY_MATCH = "potential_allergy_match"
    UNABLE_TO_DETERMINE = "unable_to_determine"


class SafetyResult(BaseModel):
    status: SafetyCheckStatus
    message: str
    matched_allergies: list[str] = []


class SafetyEngine:
    @staticmethod
    def check_prescription_safety(
        patient: PatientProfile,
        prescription: Prescription,
        medicines: list[PrescriptionMedicine],
        allergies: list[Allergy],
    ) -> SafetyResult:
        if not allergies:
            return SafetyResult(
                status=SafetyCheckStatus.NO_MATCH_FOUND,
                message="Allergy checks are an informational safety aid. Always confirm medicines with your doctor or pharmacist.",
            )

        matched_allergens = []
        for medicine in medicines:
            med_name_lower = medicine.medicine_name.lower()
            for allergy in allergies:
                allergen_lower = allergy.allergen_name.lower()
                # Simple conservative substring matching
                if allergen_lower in med_name_lower or med_name_lower in allergen_lower:
                    matched_allergens.append(allergy.allergen_name)

        if matched_allergens:
            return SafetyResult(
                status=SafetyCheckStatus.POTENTIAL_ALLERGY_MATCH,
                message="Allergy checks are an informational safety aid. Always confirm medicines with your doctor or pharmacist.",
                matched_allergies=list(set(matched_allergens)),
            )

        # Since we don't have a pharmacological DB, if we don't find a direct string match,
        # we cannot confidently say there is NO match. We return UNABLE_TO_DETERMINE.
        return SafetyResult(
            status=SafetyCheckStatus.UNABLE_TO_DETERMINE,
            message="Unable to determine pharmacological relationship. Allergy checks are an informational safety aid. Always confirm medicines with your doctor or pharmacist.",
        )


safety_engine = SafetyEngine()


def can_activate_reminders(prescription: Prescription) -> bool:
    if prescription.status != "confirmed":  # Using the string value of enum
        return False
    if prescription.explicit_patient_consent_timestamp is None:
        return False
    return prescription.confirmed_by_patient_id == prescription.patient_id
