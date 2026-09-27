# CureLoop Future Phases Roadmap

## Phase 3: Prescription Schedule Confirmation + Safety Engine
- [x] Implement Patient Confirmation screen logic and schedule state transitions.
- [x] Connect Allergy checker to new prescriptions.

## Phase 4: Prescription Vault
- [x] R2/S3 integration for prescription photos.
- [x] List, filter, search prescriptions.

## Phase 5: Medicine Scheduling + Reminders + Taken/Skipped Logging
- [x] Dose generation engine and APIs (Taken/Skipped/Today/History).
- [x] Push notification service for reminders (Mocked).
- [x] Timezone-aware logic bounding course lengths safely.
- [x] Logging Taken/Skipped doses.

## Phase 6: Appointment Management + Reminders
- [ ] Appointment model & CRUD API.
- [ ] Appointment reminder scheduling.

## Phase 7: Prescription OCR
- [ ] OCR Service integration (behind interface).

## Phase 8: Family Profiles
- [ ] Update models to support family members tied to a primary account.

## Phase 9: Emergency Card
- [ ] Emergency card API generation.

## Phase 10: Health Timeline + AI Features + Premium
- [ ] Health timeline.
- [ ] AI medicine explanations.
- [ ] Comprehensive drug interaction checks.

## Compliance & Security Backlog
- [ ] GDPR/HIPAA compliance formal review and document drafting.
- [ ] Transition mock OTP to real SMS provider (Twilio/AWS).
- [ ] Configure production PostgreSQL instance.
- [ ] Implement robust CI/CD pipelines.
