from abc import ABC, abstractmethod
from uuid import UUID


class PDFExportService(ABC):
    """
    Interface for PDF Export.
    Phase 4 prepares this interface. Implementation is deferred to future iterations.
    """

    @abstractmethod
    async def export_prescription_to_pdf(
        self, prescription_id: UUID, patient_id: UUID
    ) -> bytes:
        """
        Generates a PDF for a given prescription.
        Must strictly enforce patient isolation.
        """


class DummyPDFExportService(PDFExportService):
    async def export_prescription_to_pdf(
        self, prescription_id: UUID, patient_id: UUID
    ) -> bytes:
        return b"%PDF-1.4\n% Dummy PDF\n%%EOF\n"


pdf_export_service = DummyPDFExportService()
