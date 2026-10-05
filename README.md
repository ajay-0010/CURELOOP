# CureLoop

CureLoop is a comprehensive patient-centric health management application designed to streamline prescription tracking, medication reminders, and medical profiles. This repository contains the mobile frontend prototype built with Flutter.

## Features

The following frontend features are currently implemented and ready for demonstration:

- Onboarding
- Patient authentication/demo login
- Home dashboard
- Prescription vault
- Manual prescription entry
- Prescription scanning / mock OCR
- OCR review
- Safety check
- Allergy warning
- Explicit prescription confirmation
- Medicine tracking
- Taken/Skipped medicine status
- Appointments
- Patient profile
- Allergy profile
- Family profiles
- Emergency card
- Local demo data
- Offline operation

## Current Status

> CureLoop is currently a fully functional Flutter frontend prototype for demonstration purposes. The current version runs completely offline using local demo repositories. The FastAPI backend is intentionally disconnected during this phase.

## Technology Stack

The project currently uses the following technologies:

- **Flutter** & **Dart** (Mobile Application)
- **Riverpod** (State Management)
- **GoRouter** (Navigation)
- **Dio** (HTTP Client - prepared for future backend integration)
- **Flutter Secure Storage** (Local credential storage)
- **FastAPI** (Future backend framework)
- **SQLAlchemy/PostgreSQL** (Future backend database architecture)

## Project Structure

`	ext
CURELOOP/
├── patient_app/       # Flutter mobile application (Current focus)
├── backend/           # FastAPI backend (Disconnected for this phase)
├── figma_handoff/     # UI/UX design specifications and assets
├── docs/              # Project documentation
├── README.md          
└── ...
`

## APK Installation — Physical Android Device

### Option 1 — Direct APK installation

The presentation APK is located at:

patient_app/build/app/outputs/flutter-apk/app-release.apk

Steps to install:
1. Copy the APK to the Android phone.
2. Open the APK on the phone using a file manager.
3. If Android asks for permission to install from unknown sources, allow it for the file manager/browser being used.
4. Tap Install.
5. Open CureLoop.

*Note: The current application works entirely without the backend or an internet connection after installation. You must clone or download this repository to access the APK file.*

## APK Installation — Android Emulator

If you are using a Windows machine with an Android Emulator running, you can easily install the APK via ADB.

First, verify your emulator is running and detected:
`powershell
flutter devices
`

Then install using ADB:
`powershell
adb install -r patient_app/build/app/outputs/flutter-apk/app-release.apk
`

If db is not in your PATH, use the Windows Android SDK fallback:
`powershell
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" install -r "patient_app\build\app\outputs\flutter-apk\app-release.apk"
`
*Alternatively, you can drag and drop the pp-release.apk file directly onto the running Android Emulator window.*

## Running from Source

To run the Flutter application directly from the source code:

`powershell
cd patient_app
flutter pub get
flutter devices
flutter run
`

*Note: The current demo does NOT require FastAPI, PostgreSQL, Docker, Google Vision, FCM, or any backend environment variables. Please do not start the backend for the current demo.*

## Demo Login

The authentication flow is currently mocked for offline demonstration.

- **Demo OTP:** 1234

*Please note this is a local demonstration credential and NOT a real authentication mechanism.*

## Recommended Teacher Demo Flow

To see the full capabilities of CureLoop, we recommend the following demonstration sequence:

`	ext
Home
→ Add Prescription
→ Scan Prescription
→ Mock OCR
→ Review Prescription
→ Safety Check
→ Confirm Prescription
→ Prescription Vault
→ Medicines
→ Mark Medicine as Taken
→ Appointments
→ Profile
→ Allergy Profile
→ Family Profile
→ Emergency Card
`
This flow demonstrates the primary CureLoop user journey from prescription ingestion to health tracking.

## Safety Demonstration

The current presentation build intentionally uses deterministic demo data so the safety demonstration is reliable. 
Specifically, the safety check uses a deterministic **Amoxicillin/Penicillin** allergy demonstration to showcase the app's contraindication alerts. 
*Clearly note that this is demo behavior and should not be interpreted as a production medical decision engine.*

## Current Limitations

1. Backend/API is currently disconnected.
2. Authentication is local/demo-only.
3. OCR is mocked/deterministic for the presentation build.
4. Settings toggles are visual/demo-only.
5. Safety demonstration uses deterministic Amoxicillin/Penicillin demo data.
6. Real FCM notifications are not required for the current demo.
7. Production deployment/security/backend integration are future work.

## Future Development

The following items are planned for future phases:
- Connect Flutter repositories to FastAPI APIs.
- Connect PostgreSQL.
- Implement real authentication/OTP.
- Integrate production OCR.
- Integrate real push notifications/FCM.
- Perform real-device validation.
- Production security hardening.

## Build APK

To generate a new release build (if making modifications):

`powershell
cd patient_app
flutter build apk --release
`

Expected path: patient_app/build/app/outputs/flutter-apk/app-release.apk

## Validation

The repository has been thoroughly verified in its current frozen state:
- lutter analyze — No issues found
- lutter test — All tests passed
- lutter build apk --release — Passed
- Flutter application verified on Android emulator
- Core flows tested end-to-end
- Application works completely without the backend
