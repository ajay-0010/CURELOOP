# CureLoop Patient App

This is the Flutter frontend for the CureLoop patient application.

## Prerequisites

The Flutter SDK must be installed on your system. 
Currently, Flutter is unavailable in the automated terminal environment.

### Setup Instructions

1. **Install Flutter**: Follow the official guide at https://docs.flutter.dev/get-started/install
2. **Add to PATH**: Ensure `flutter/bin` is in your environment PATH.
3. **Run Doctor**: Run `flutter doctor` to ensure Android Studio and the Android SDK are configured.
4. **Install Dependencies**:
   ```bash
   cd patient_app
   flutter pub get
   ```
5. **Generate Code**:
   This project uses `riverpod_generator` and `json_serializable`.
   ```bash
   dart run build_runner build -d
   ```
6. **Run the App**:
   ```bash
   flutter run -d emulator-5554
   ```
