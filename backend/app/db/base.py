# Import all the models, so that Base has them before being
# imported by Alembic
from app.db.base_class import Base  # noqa: F401
from app.models.allergy import Allergy  # noqa: F401
from app.models.patient import PatientProfile  # noqa: F401
from app.models.prescription import (  # noqa: F401
    MedicineSchedule,
    Prescription,
    PrescriptionDocument,
    PrescriptionMedicine,
)
from app.models.user import User  # noqa: F401
