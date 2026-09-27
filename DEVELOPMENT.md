# CureLoop Development Guide

## Project State
* **Current Phase**: Phase 4 (Prescription Vault) Completed.
* **Next Phase**: Phase 5 (Medicine Scheduling + Reminders + Taken/Skipped Logging - *Pending Instructions*)

## Completed Work (Phases 1-4)
* Initialized backend repository with FastAPI structure.
* Configured SQLite database with Alembic migrations (Fallback used as Docker Desktop / WSL2 was unavailable on host).
* Implemented Authentication domain (Phone + mock OTP).
* Implemented Patient Profile and Allergy schemas & APIs.
* Implemented patient-level data isolation, token security, and account deletion.
* Implemented Manual Prescription Entry (Prescription, Medicine, Schedule generation).
* Validated frequency formats and isolated prescriptions to the authenticated patient.
* Implemented the Prescription SafetyEngine & Allergy Matching for Phase 3.
* Implemented strictly controlled lifecycle endpoints (`submit-for-confirmation` & `confirm`).
* Tracked consent via explicit timestamp and patient IDs.
* Defined `can_activate_reminders()` safety boundary guard.
* Implemented Prescription Vault with robust server-side search (`GET /api/v1/prescriptions`).
* Implemented `StorageProvider` abstraction for document uploads, featuring UUID-based secure object keys, local dev implementation, strict file validation (type, size), and orphaned-file deletion.
* Defined `PDFExportService` boundary preparing for future exports.

## Architecture Decisions
1. **Critical Safety Rule**: Reminders will only be activated if a prescription schedule explicitly transitions to `CONFIRMED` via user input. This will be enforced strictly in the data tier and service layer (`safety_engine.py` / `can_activate_reminders`). Uploading documents does *not* auto-confirm.
2. **Prescription Status Lifecycle**: Status flows securely `DRAFT -> PENDING_CONFIRMATION -> CONFIRMED`. Generic PUT updates to material fields automatically revert prescriptions to `PENDING_CONFIRMATION`, requiring re-consent.
3. **Safety Engine**: Matches allergies against prescription medicine conservatively using substring logic. Since it lacks a pharmacological database, it strictly returns `UNABLE_TO_DETERMINE` when a match isn't found instead of claiming safety.
4. **Storage Abstraction**: The Vault strictly uses `StorageProvider` interface (`local` for development). Production environments will use `S3StorageProvider` requiring bucket/AWS credentials via environment variables. Documents are completely private; authorized users request them via token authentication, mapped to the underlying storage provider.
2. **Database**: We are utilizing SQLite for local development temporarily, but models are prepared (using native SQLAlchemy `Uuid` fields) to seamlessly transition back to PostgreSQL once Docker/WSL is resolved in the deployment environment.
3. **Mock OTP**: A `MockOTPProvider` currently fulfills OTP sending requirements.

## Setup Instructions
```bash
# 1. Setup virtual environment
cd backend
python -m venv venv
.\venv\Scripts\activate

# 2. Install dependencies
pip install -r requirements.txt

# 3. Apply database migrations
alembic upgrade head

# 4. Run the API Server
uvicorn app.main:app --reload
```

## Environment Variables
Create a `.env` file in the root based on `.env.example`:
```
DATABASE_URL=sqlite+aiosqlite:///./cureloop.db
PROJECT_NAME="CureLoop API"
ENVIRONMENT=development
SECRET_KEY=<your-secret-key>
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
REFRESH_TOKEN_EXPIRE_DAYS=7
```

## Tests
```bash
# From the backend directory
pytest -v
```

## Known Limitations
* Docker Compose PostgreSQL startup is blocked because WSL2 is not installed on the host. Falling back to SQLite for MVP tests.
* Flutter project initialization skipped as the Flutter SDK is not present in the host system `PATH`. Awaiting environment configuration for frontend scaffolding.
