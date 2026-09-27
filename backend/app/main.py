from fastapi import FastAPI

from app.api.v1.allergy import router as allergy_router
from app.api.v1.auth import router as auth_router
from app.api.v1.patient import router as patient_router
from app.core.config import settings

app = FastAPI(title=settings.PROJECT_NAME)


@app.get("/health", tags=["health"])
async def health_check():
    return {"status": "ok"}


app.include_router(auth_router, prefix="/api/v1")
app.include_router(patient_router, prefix="/api/v1")
app.include_router(allergy_router, prefix="/api/v1")
from app.api.v1.doses import router as doses_router
from app.api.v1.appointment import router as appointment_router
from app.api.v1.prescription import router as prescription_router

app.include_router(prescription_router, prefix="/api/v1")
app.include_router(appointment_router, prefix="/api/v1")
app.include_router(doses_router, prefix="/api/v1")

