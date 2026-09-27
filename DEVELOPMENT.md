# CureLoop Development Guide

## Project State
* **Current Phase**: Phase 2 (Manual Prescription Entry) Completed.
* **Next Phase**: Phase 3 (Prescription Schedule Confirmation + Safety Engine - *Pending Instructions*)

## Completed Work (Phase 1 & 2)
* Initialized backend repository with FastAPI structure.
* Configured SQLite database with Alembic migrations (Fallback used as Docker Desktop / WSL2 was unavailable on host).
* Implemented Authentication domain (Phone + mock OTP).
* Implemented Patient Profile and Allergy schemas & APIs.
* Implemented patient-level data isolation, token security, and account deletion.
* Unit test coverage for auth and patient domains.
* Implemented Phase 2: Manual Prescription Entry (Prescription, Medicine, Schedule generation).
* Validated frequency formats and isolated prescriptions to the authenticated patient.

## Architecture Decisions
1. **Critical Safety Rule**: Reminders will only be activated if a prescription schedule explicitly transitions to `CONFIRMED` via user input. This will be enforced strictly in the data tier and service layer in future phases.
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
