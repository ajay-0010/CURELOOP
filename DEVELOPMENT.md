# CureLoop Development Guide

## Project State
* **Current Phase**: Phase 6 (Appointment Management + Reminders) Completed.
* **Next Phase**: Phase 7 (Prescription OCR - *Pending Instructions*)

## Completed Work (Phases 1-7)
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
* Implemented DoseEvent schema/models tracking `TAKEN`/`SKIPPED` adherence per medicine occurrence.
* Engineered Timezone-aware local dose generation syncing explicitly with patient's standard UTC mapping.
* Programmed idempotency around Dose generation â€” duplicate invocations wipe un-actioned upcoming doses while preserving historical taken/skipped doses.
* Connected mock `NotificationProvider` and abstract `ReminderService` bounded strictly by patient confirmation blocks.
* Automated cancellation of future reminders upon Prescription edits / soft-deletions / duration-timeouts.
* Engineered generic `Appointment` domain (POST/GET/PUT/DELETE/Complete) integrated seamlessly into the existing Timezone handling architecture (canonical UTC tracking natively matched to local zones).
* Unified the `ReminderService` payload generation across Medicine/Appointment domains handling precise offset cancellations (24h/2h).
* Engineered Mock OCR Integration isolating raw extraction confidence from structured confirmation.
* Validated OCR medicine parsing bounds resolving low-confidence matches directly to DRAFT prescription states requiring explicit manual review.
* Verified robust OCR safety integration, proving AI extraction could not bypass the existing Allergy SafetyEngine.

## Architecture Decisions
1. **Critical Safety Rule**: Reminders will only be activated if a prescription schedule explicitly transitions to `CONFIRMED` via user input. This will be enforced strictly in the data tier and service layer (`safety_engine.py` / `can_activate_reminders`). Uploading documents does *not* auto-confirm.
2. **Prescription Status Lifecycle**: Status flows securely `DRAFT -> PENDING_CONFIRMATION -> CONFIRMED`. Generic PUT updates to material fields automatically revert prescriptions to `PENDING_CONFIRMATION`, requiring re-consent.
3. **Safety Engine**: Matches allergies against prescription medicine conservatively using substring logic. Since it lacks a pharmacological database, it strictly returns `UNABLE_TO_DETERMINE` when a match isn't found instead of claiming safety.
4. **Storage Abstraction**: The Vault strictly uses `StorageProvider` interface (`local` for development). Production environments will use `S3StorageProvider` requiring bucket/AWS credentials via environment variables. Documents are completely private; authorized users request them via token authentication, mapped to the underlying storage provider.
5. **Dose Event Generation**: Occurrences of a schedule (e.g. 1-0-1 Morning and Night) are unrolled into individual discrete `DoseEvent` entities in the database when a prescription is `CONFIRMED`. They span out maximally to `duration_days` ending the course naturally without chron job cleanups.
6. **Timezone Strategy**: System utilizes canonical UTC for all timestamp tracking, while resolving patient-local days (e.g., Morning) bounded by the `timezone` parameter appended to `PatientProfile`. Timezone is dynamically processed via `zoneinfo`.
7. **Reminder Orchestration**: The `ReminderService` operates abstractly against a `NotificationProvider`. For integration tests and rapid iteration, a `MockNotificationProvider` captures events sequentially without real cloud credentials.
8. **Idempotency & Re-confirmations**: Generative `DoseEvent` creation preserves historic `TAKEN`/`SKIPPED` statuses when a prescription undergoes a PENDING->CONFIRMED sequence repeatedly. Only un-actioned upcoming doses are recreated. Material edits instantly cancel future notifications and doses.
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

