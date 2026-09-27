import asyncio
import os
import sys

# Add backend to path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app.services.ocr_engine import (
    MedicineMatcher,
    MockOCRProvider,
    PrescriptionExtractionService,
)


async def main():
    print("=" * 50)
    print("CURELOOP OCR EVALUATION FRAMEWORK")
    print("=" * 50)
    print("WARNING: Real-world handwritten OCR has not yet been validated.")
    print("Running evaluation on mock deterministic dataset.\n")

    provider = MockOCRProvider()
    extractor = PrescriptionExtractionService(MedicineMatcher())

    fixtures = [
        "clean_printed.jpg",
        "messy_handwriting.jpg",
        "missing_dosage.jpg",
        "missing_duration.jpg",
        "ambiguous_medicine.jpg",
        "unreadable_noise.jpg",
    ]

    total = len(fixtures)
    success_extraction = 0
    unknown_medicine = 0
    missing_fields = 0

    for fixture in fixtures:
        print(f"Testing fixture: {fixture}")

        # 1. Mock Extraction
        ocr_res = await provider.extract_text(b"dummy_bytes", fixture)

        # 2. Structured Extraction
        structured = extractor.extract(ocr_res)

        medicines = structured.get("medicines", [])
        if not medicines:
            print("  -> FAILURE: No medicines extracted.")
            continue

        success_extraction += 1

        for med in medicines:
            if med.medicine_name.confidence == "UNKNOWN":
                unknown_medicine += 1
            if (
                med.dosage.confidence == "UNKNOWN"
                or med.duration_days.confidence == "UNKNOWN"
            ):
                missing_fields += 1

            print(
                f"  -> Extracted: {med.medicine_name.value} (Conf: {med.medicine_name.confidence})"
            )
            print(f"     Dosage: {med.dosage.value} (Conf: {med.dosage.confidence})")
            print(
                f"     Duration: {med.duration_days.value} (Conf: {med.duration_days.confidence})"
            )
        print("-" * 50)

    print("\nEVALUATION SUMMARY")
    print(f"Total Fixtures: {total}")
    print(f"Extraction Pipeline Success: {success_extraction}/{total}")
    print(f"Medicines mapped to UNKNOWN: {unknown_medicine}")
    print(f"Instances of missing/UNKNOWN fields: {missing_fields}")
    print("\nCONCLUSION: Framework is ready for real handwritten dataset injection.")


if __name__ == "__main__":
    asyncio.run(main())
