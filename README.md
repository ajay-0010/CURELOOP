# CureLoop — Patient-Centric Health & Prescription Management

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.110+-009688?logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![SQLite / Drift](https://img.shields.io/badge/Drift-SQLite-blue?logo=sqlite&logoColor=white)](https://drift.simonbinder.eu/)
[![License](https://img.shields.io/badge/License-Academic-lightgrey.svg)]()

CureLoop is a comprehensive healthcare companion engineered to solve medication non-adherence, prevent dangerous drug-allergy interactions, and organize patient medical records. It bridges the gap between doctor prescription and daily patient adherence through automated schedule extraction, conservative safety checks, and intuitive tracking.

---

## Table of Contents

- [Features](#features)
- [System Architecture & Topology](#system-architecture--topology)
- [Git & Version Control Policy (.gitignore)](#git--version-control-policy-gitignore)
- [How to Run CureLoop](#how-to-run-cureloop)
  - [Prerequisites](#prerequisites)
  - [Option A — Quick Test via Pre-Built APK (No Build Tools Required)](#option-a--quick-test-via-pre-built-apk-no-build-tools-required)
  - [Option B — Run Flutter App from Source (Standalone Offline Mode)](#option-b--run-flutter-app-from-source-standalone-offline-mode)
  - [Option C — Run Full-Stack Mode (FastAPI Backend + Connected Mobile App)](#option-c--run-full-stack-mode-fastapi-backend--connected-mobile-app)
- [Running Automated Test Suites](#running-automated-test-suites)
- [Code Generation (Build Runner)](#code-generation-build-runner)
- [Recommended Demonstration Flow](#recommended-demonstration-flow)
- [Troubleshooting & FAQ](#troubleshooting--faq)
- [Technical Documentation](#technical-documentation)

---

## Features

- **Onboarding Carousel:** 3-page introduction explaining prescription scanning, reminders, and health profiles.
- **Patient Authentication:** Mobile phone entry with demo OTP verification (code: `1234`).
- **Home Dashboard:** Quick adherence metrics, today's medication schedule, nearest upcoming appointment, and quick-action navigation.
- **Prescription Vault:** Searchable and filterable archive of active and historical prescriptions.
- **Manual Prescription Entry:** Structured multi-medication creation with dosage, frequency, and meal instructions.
- **Prescription Digitization (OCR):** Image capture/selection with field-level confidence indicators (`HIGH`, `MEDIUM`, `LOW`, `UNKNOWN`).
- **Allergy & Contraindication Safety Engine:** Real-time cross-referencing of prescribed medicines against recorded allergies (e.g., Amoxicillin vs. Penicillin allergy alerts).
- **Explicit Patient Confirmation Safeguard:** Strict clinical invariant: reminders and schedules **never** activate without explicit patient review and consent.
- **Medication & Dose Tracking:** Filter by Today, Upcoming, and History. Single-tap **Taken** and **Skip** actions with exact timestamp logging.
- **Doctor Appointments:** Schedule, inspect, complete, or cancel consultations.
- **Patient & Family Profiles:** Personal health profile, allergy manager (severity + reaction), and dependent family tracking.
- **Emergency Medical Card:** High-contrast summary displaying blood group (`O+`), critical medications, severe allergies, and one-touch emergency contact calling.
- **Offline SQLite Persistence:** Built with Drift ORM; all patient data, doses, and prescriptions persist locally on the device across app restarts.

---

## System Architecture & Topology

CureLoop features a flexible **dual-mode architecture**:

1. **Standalone Offline Mode (Default):**
   - The Flutter mobile app communicates directly with a local **Drift SQLite database** (`cureloop_patient.db`).
   - Requires **zero network connectivity** and **no backend setup**. Ideal for grading, offline evaluation, and device demos.
2. **Full-Stack Mode:**
   - The Flutter app switches repositories via dependency injection to communicate over HTTP with the **FastAPI backend** at `/api/v1`.
   - The backend handles JWT authorization, sliding-window rate limiting, async SQLAlchemy ORM queries, and background notification dispatches.

```text
CURELOOP/
├── apk/                              # Pre-built distribution APK
│   └── cureloop-release.apk          # Instant test install binary (~54.8 MB)
├── patient_app/                      # Flutter Mobile Application
│   ├── lib/
│   │   ├── main.dart                 # Application entry point & eager DB init
│   │   ├── core/
│   │   │   ├── config/dev_config.dart# Mode toggle (kFrontendDemoMode)
│   │   │   ├── database/             # Drift SQLite engine (8 tables, DAOs, repos)
│   │   │   ├── network/              # Dio HTTP client with JWT interceptor
│   │   │   ├── routing/router.dart   # GoRouter navigation & auth guards
│   │   │   └── theme/                # Design tokens (AppColors, AppTypography, AppTheme)
│   │   └── features/                 # Modular domains (auth, home, prescriptions, etc.)
│   │       └── <feature>/data/       # Models, repositories, and generated .g.dart files
│   ├── android/                      # Native Android harness & Gradle wrapper
│   └── test/                         # 20 Unit & Widget Tests
├── backend/                          # FastAPI REST API Services
│   ├── app/
│   │   ├── main.py                   # FastAPI initialization & router mounting
│   │   ├── api/v1/                   # Endpoint routers (auth, patient, prescriptions, doses)
│   │   ├── core/                     # JWT tokens, security, settings
│   │   ├── models/ & schemas/        # SQLAlchemy ORM models & Pydantic schemas
│   │   └── services/                 # SafetyEngine, DoseEngine, OCREngine, StorageProvider
│   └── tests/                        # 21 Asynchronous Integration Tests
├── figma_handoff/                    # UI/UX Specifications & 23 PNG mockups
└── docs/                             # Deep-dive architectural documentation
```

---

## Git & Version Control Policy (.gitignore)

### Why previous clones failed
Earlier revisions contained an overly broad `.gitignore` rule (`data/` without a leading `/`). In Git syntax, this unintentionally instructed Git to ignore **any directory named `data` at any depth**, which silently stripped out:
- `patient_app/lib/features/appointments/data/`
- `patient_app/lib/features/auth/data/`
- `patient_app/lib/features/medicines/data/`
- `patient_app/lib/features/prescriptions/data/`
- `patient_app/lib/features/profile/data/`

Without these directories, anyone who cloned the repository encountered hundreds of missing class and unresolved symbol errors.

### The New Bulletproof .gitignore Configuration
The root `.gitignore` and `patient_app/.gitignore` have been rewritten to guarantee complete out-of-the-box reproducibility:

1. **Feature Data Directories Preserved:** Root-level data caches use `/data/` (leading slash) so feature layers (`lib/features/*/data/`) remain fully tracked.
2. **Pre-Generated Code Tracked:** All `*.g.dart` files (Riverpod providers, Drift database classes, and JSON models) are tracked in Git. Anyone cloning the repository can immediately run `flutter test` and `flutter run` without waiting for `build_runner`.
3. **Gradle Wrapper Tracked:** `gradlew`, `gradlew.bat`, and `gradle/wrapper/gradle-wrapper.jar` are committed, ensuring reliable Android builds without needing manual Gradle installations.
4. **Local Secrets Protected:** `.env`, `.env.*` (preserving `.env.example`), `key.properties`, and keystores (`*.jks`, `*.keystore`) are strictly ignored.
5. **Runtime Uploads Ignored:** Temporary OCR test uploads in `backend/storage_dev/*.png` are ignored to prevent repository bloat while preserving the directory via `.gitkeep`.
6. **Pre-Built Presentation APK Included:** The distribution APK at `apk/cureloop-release.apk` and `patient_app/build/app/outputs/flutter-apk/app-release.apk` is explicitly allowed so non-developers can evaluate the app instantly.

---

## How to Run CureLoop

### Prerequisites

| Component | Minimum Version | Notes |
| :--- | :--- | :--- |
| **Flutter SDK** | `3.24.x` or newer | Channel `stable` (includes Dart 3.5+) |
| **Android SDK / Studio** | API Level 34 / 35 | For running on emulator or building APK |
| **Java / JDK** | OpenJDK 17 or 21 | Bundled with modern Android Studio |
| **Python** *(optional)* | `3.11` to `3.13` | Only required if running the FastAPI backend |

Verify your Flutter environment by running:
```bash
flutter doctor
```

---

### Option A — Quick Test via Pre-Built APK (No Build Tools Required)

If you do not have Flutter installed or want to test immediately on an Android device or emulator, use the pre-compiled release APK included in this repository.

**APK Locations:**
- Convenience path: `apk/cureloop-release.apk`
- Standard Flutter path: `patient_app/build/app/outputs/flutter-apk/app-release.apk`

#### Install on a Physical Android Phone
1. Transfer `apk/cureloop-release.apk` to your phone via USB, Google Drive, or messaging.
2. Open the file in your phone's File Manager.
3. If prompted, toggle "Allow from this source" in Android settings.
4. Tap **Install** and open **CureLoop**.
5. *Note:* The APK runs 100% offline; no internet or backend connection is needed.

#### Install on an Android Emulator
1. Start your Android Emulator via Android Studio or command line.
2. Verify the emulator is connected:
   ```bash
   adb devices
   ```
3. Install the APK:
   ```bash
   adb install -r apk/cureloop-release.apk
   ```
   *(Alternatively, simply drag and drop `apk/cureloop-release.apk` onto the running emulator window.)*

---

### Option B — Run Flutter App from Source (Standalone Offline Mode)

This is the **recommended developer mode**. It runs the full Flutter client with local SQLite database persistence (Drift) and zero external dependencies.

#### Step 1: Verify Configuration
Open `patient_app/lib/core/config/dev_config.dart` and confirm offline demo mode is active:
```dart
const bool kDevSkipAuth = true;
const bool kFrontendDemoMode = true;
```

#### Step 2: Install Flutter Dependencies
```bash
cd patient_app
flutter pub get
```

#### Step 3: Check Connected Devices
```bash
flutter devices
```
Make sure an Android Emulator or connected physical phone is listed.

#### Step 4: Launch Application
```bash
flutter run
```
*Tip:* To build and run in release mode for maximum performance:
```bash
flutter run --release
```

---

### Option C — Run Full-Stack Mode (FastAPI Backend + Connected Mobile App)

Follow these steps if you want to run the full-stack architecture with the FastAPI server handling authentication, document storage, and safety engines.

#### Step 1: Set Up & Start Backend Server
```bash
# Navigate to backend directory
cd backend

# Create Python virtual environment
python -m venv venv

# Activate virtual environment
# On Windows (PowerShell):
.\venv\Scripts\Activate.ps1
# On macOS / Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Apply database migrations
alembic upgrade head

# Start API server
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```

Verify the backend is live by opening your browser to:
- Health Check: `http://localhost:8000/health` (should return `{"status":"ok","environment":"development"}`)
- Interactive Swagger API Docs: `http://localhost:8000/docs`

#### Step 2: Configure Mobile App to Connect to Backend
1. Open `patient_app/lib/core/config/dev_config.dart` and switch the flags:
   ```dart
   const bool kDevSkipAuth = false;
   const bool kFrontendDemoMode = false;
   ```
2. Open `patient_app/lib/core/network/dio_client.dart` and check the `baseUrl`:
   - **Android Emulator:** Use `http://10.0.2.2:8000/api/v1` (special loopback alias pointing to your host computer).
   - **Physical Phone:** Use `http://<YOUR_COMPUTER_LOCAL_IP>:8000/api/v1` (ensure both your phone and PC are on the same Wi-Fi network).

#### Step 3: Launch Mobile Client
```bash
cd patient_app
flutter pub get
flutter run
```

---

## Running Automated Test Suites

Both the mobile application and the backend API have comprehensive test coverage.

### Mobile Client Tests (Flutter)
```bash
cd patient_app

# Run all 20 unit and widget tests
flutter test

# Run code analyzer (ensures zero lint errors)
flutter analyze
```
**Current Test Coverage:**
- `test/database_test.dart`: Complete Drift SQLite persistence test (seeding, CRUD, cascade deletions, re-opening database).
- `test/medicine_test.dart`: DoseCard widget rendering and Taken/Skip actions.
- `test/appointment_test.dart`: AppointmentCard status badges and formatting.
- `test/ocr_models_test.dart`: Model serialization and confidence score mapping.

### Backend Tests (Pytest)
```bash
cd backend
.\venv\Scripts\activate
pytest -v
```
**Current Test Coverage:** 21 asynchronous tests covering Auth, Rate Limiting, Patient Isolation, Prescription Cascade Deletions, SafetyEngine Contraindications, Timezone Dose Generation, and OCR Correction flows.

---

## Code Generation (Build Runner)

> **Important:** All generated files (`*.g.dart`) are already pre-generated and committed to Git. You **do not** need to run `build_runner` after cloning.

If you modify Drift database tables in `patient_app/lib/core/database/tables.dart` or Riverpod providers:
```bash
cd patient_app
dart run build_runner build --delete-conflicting-outputs
```

---

## Recommended Demonstration Flow

To experience the complete CureLoop journey, follow this sequence:

```text
1. Home Dashboard
   └── View today's scheduled doses, adherence summary, and upcoming appointment.

2. Add Prescription (Floating Action Button)
   ├── Tap "+" -> Select "Scan Prescription".
   ├── Review Extracted OCR Data (confidence pills: HIGH, MEDIUM, UNKNOWN).
   ├── Tap "Submit for Review".
   ├── Safety Check Screen: Observe automated allergy contraindication alert 
   │   (Penicillin allergy matched against prescribed Amoxicillin).
   └── Confirmation Screen: Check mandatory acknowledgment checkbox -> Tap "Confirm".

3. Dose Tracking (Medicines Tab)
   ├── Notice how confirmed prescription immediately unrolls doses into Today's feed.
   ├── Tap "Taken" on a dose -> Card transitions to green completed state.
   └── Tap "Skip" on a dose -> Card records skipped status.

4. Appointments Tab
   └── View upcoming consultation with Dr. Sharma -> Tap "Add Appointment" to test creation.

5. Profile & Safety Features (Profile Tab)
   ├── Personal vitals and blood group (O+).
   ├── Allergy Profile: View and manage allergens.
   ├── Family Profiles: View dependent family profiles.
   └── Emergency Card: View high-contrast medical card designed for first responders.
```

**Demo Credentials:**
- Phone: Any 10-digit number (e.g., `5551234567`)
- OTP: `1234`

---

## Troubleshooting & FAQ

### 1. `Target of URI doesn't exist` or missing models after clone
- **Cause:** In older versions, `.gitignore` ignored `data/`.
- **Solution:** Pull the latest branch. Ensure `patient_app/lib/features/*/data/` and `patient_app/lib/core/database/` exist on disk, then run `flutter pub get`.

### 2. Gradle build fails or `local.properties` missing SDK path
- **Cause:** Android Studio / Flutter needs to know where your Android SDK is located.
- **Solution:** Create or update `patient_app/android/local.properties`:
  ```properties
  sdk.dir=C:\\Users\\<YourUsername>\\AppData\\Local\\Android\\Sdk
  ```
  *(On macOS: `sdk.dir=/Users/<YourUsername>/Library/Android/sdk`)*

### 3. Emulator cannot connect to FastAPI (`Connection Refused`)
- **Cause:** `localhost` inside an Android emulator refers to the emulator itself, not your computer.
- **Solution:** Use `http://10.0.2.2:8000/api/v1` as the base URL in `patient_app/lib/core/network/dio_client.dart`.

### 4. How do I reset the local SQLite database to fresh demo seed?
- **Solution:** Simply uninstall the app from your device/emulator and re-install, or clear app storage via Android Settings > Apps > CureLoop > Clear Storage. The app will automatically re-seed on next launch.

---

## Technical Documentation

For an exhaustive, file-by-file breakdown of the system architecture, database schemas, and API specifications, refer to:
- [**Master Codebase Documentation (`docs/FULL_CODEBASE_DOCUMENTATION.md`)**](docs/FULL_CODEBASE_DOCUMENTATION.md)
- [**Figma Design Token Specification (`figma_handoff/design_spec.md`)**](figma_handoff/design_spec.md)
- [**OCR Engine & Validation Report (`docs/PHASE10_OCR_VALIDATION.md`)**](docs/PHASE10_OCR_VALIDATION.md)
- [**Physical Device Audit Report (`docs/PHASE10_REAL_DEVICE_TEST.md`)**](docs/PHASE10_REAL_DEVICE_TEST.md)
