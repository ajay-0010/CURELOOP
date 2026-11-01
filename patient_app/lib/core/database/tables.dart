import 'package:drift/drift.dart';

@DataClassName('PatientProfileEntity')
@TableIndex(name: 'patient_profiles_id_idx', columns: {#id})
class PatientProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get dateOfBirth => text().nullable()();
  TextColumn get bloodGroup => text().nullable()();
  TextColumn get emergencyContactName => text().nullable()();
  TextColumn get emergencyContactPhone => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PrescriptionEntity')
@TableIndex(name: 'prescriptions_patient_idx', columns: {#patientId})
@TableIndex(name: 'prescriptions_status_idx', columns: {#status})
class Prescriptions extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get doctorName => text().nullable()();
  TextColumn get clinicName => text().nullable()();
  TextColumn get prescriptionDate => text()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text()(); // 'DRAFT', 'PENDING_CONFIRMATION', 'CONFIRMED'
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PrescriptionMedicineEntity')
@TableIndex(name: 'prescription_medicines_rx_idx', columns: {#prescriptionId})
class PrescriptionMedicines extends Table {
  TextColumn get id => text()();
  TextColumn get prescriptionId => text().references(Prescriptions, #id, onDelete: KeyAction.cascade)();
  TextColumn get medicineName => text()();
  TextColumn get dosage => text()();
  TextColumn get frequency => text()();
  IntColumn get durationDays => integer().nullable()();
  TextColumn get foodTiming => text().nullable()(); // 'BEFORE_FOOD', 'AFTER_FOOD', 'WITH_FOOD', 'NO_INSTRUCTION'
  TextColumn get instructions => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MedicineScheduleEntity')
@TableIndex(name: 'medicine_schedules_rx_idx', columns: {#prescriptionId})
@TableIndex(name: 'medicine_schedules_active_idx', columns: {#isActive})
class MedicineSchedules extends Table {
  TextColumn get id => text()();
  TextColumn get prescriptionId => text().references(Prescriptions, #id, onDelete: KeyAction.cascade)();
  TextColumn get prescriptionMedicineId => text().references(PrescriptionMedicines, #id, onDelete: KeyAction.cascade)();
  TextColumn get medicineName => text()();
  TextColumn get dosage => text()();
  TextColumn get frequency => text()();
  IntColumn get timesPerDay => integer().withDefault(const Constant(1))();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DoseEventEntity')
@TableIndex(name: 'dose_events_scheduled_idx', columns: {#scheduledAt})
@TableIndex(name: 'dose_events_status_idx', columns: {#status})
@TableIndex(name: 'dose_events_rx_idx', columns: {#prescriptionId})
class DoseEvents extends Table {
  TextColumn get id => text()();
  TextColumn get prescriptionId => text().references(Prescriptions, #id, onDelete: KeyAction.cascade)();
  TextColumn get prescriptionMedicineId => text().references(PrescriptionMedicines, #id, onDelete: KeyAction.cascade)();
  TextColumn get scheduleId => text().nullable().references(MedicineSchedules, #id, onDelete: KeyAction.cascade)();
  TextColumn get medicineName => text()();
  TextColumn get dosage => text()();
  DateTimeColumn get scheduledAt => dateTime()();
  TextColumn get status => text()(); // 'SCHEDULED', 'TAKEN', 'SKIPPED', 'MISSED'
  TextColumn get foodTiming => text().nullable()();
  DateTimeColumn get takenAt => dateTime().nullable()();
  DateTimeColumn get skippedAt => dateTime().nullable()();
  TextColumn get skipReason => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AppointmentEntity')
@TableIndex(name: 'appointments_datetime_idx', columns: {#appointmentDatetime})
@TableIndex(name: 'appointments_status_idx', columns: {#status})
class Appointments extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text()();
  TextColumn get doctorName => text()();
  TextColumn get clinicName => text().nullable()();
  DateTimeColumn get appointmentDatetime => dateTime()();
  TextColumn get timezone => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text()(); // 'scheduled', 'completed', 'cancelled'
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AllergyEntity')
@TableIndex(name: 'allergies_patient_idx', columns: {#patientId})
class Allergies extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text().withDefault(const Constant('p1'))();
  TextColumn get name => text()();
  TextColumn get severity => text()(); // 'Low', 'Medium', 'High'
  TextColumn get reaction => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('FamilyMemberEntity')
@TableIndex(name: 'family_members_patient_idx', columns: {#patientId})
class FamilyMembers extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text().withDefault(const Constant('p1'))();
  TextColumn get name => text()();
  TextColumn get relation => text()();
  TextColumn get dateOfBirth => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
