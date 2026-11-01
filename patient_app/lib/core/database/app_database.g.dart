// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PatientProfilesTable extends PatientProfiles
    with TableInfo<$PatientProfilesTable, PatientProfileEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<String> dateOfBirth = GeneratedColumn<String>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bloodGroupMeta =
      const VerificationMeta('bloodGroup');
  @override
  late final GeneratedColumn<String> bloodGroup = GeneratedColumn<String>(
      'blood_group', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emergencyContactNameMeta =
      const VerificationMeta('emergencyContactName');
  @override
  late final GeneratedColumn<String> emergencyContactName =
      GeneratedColumn<String>('emergency_contact_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emergencyContactPhoneMeta =
      const VerificationMeta('emergencyContactPhone');
  @override
  late final GeneratedColumn<String> emergencyContactPhone =
      GeneratedColumn<String>('emergency_contact_phone', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        phone,
        email,
        dateOfBirth,
        bloodGroup,
        emergencyContactName,
        emergencyContactPhone,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patient_profiles';
  @override
  VerificationContext validateIntegrity(
      Insertable<PatientProfileEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('blood_group')) {
      context.handle(
          _bloodGroupMeta,
          bloodGroup.isAcceptableOrUnknown(
              data['blood_group']!, _bloodGroupMeta));
    }
    if (data.containsKey('emergency_contact_name')) {
      context.handle(
          _emergencyContactNameMeta,
          emergencyContactName.isAcceptableOrUnknown(
              data['emergency_contact_name']!, _emergencyContactNameMeta));
    }
    if (data.containsKey('emergency_contact_phone')) {
      context.handle(
          _emergencyContactPhoneMeta,
          emergencyContactPhone.isAcceptableOrUnknown(
              data['emergency_contact_phone']!, _emergencyContactPhoneMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PatientProfileEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PatientProfileEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      dateOfBirth: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_of_birth']),
      bloodGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}blood_group']),
      emergencyContactName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}emergency_contact_name']),
      emergencyContactPhone: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}emergency_contact_phone']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PatientProfilesTable createAlias(String alias) {
    return $PatientProfilesTable(attachedDatabase, alias);
  }
}

class PatientProfileEntity extends DataClass
    implements Insertable<PatientProfileEntity> {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? dateOfBirth;
  final String? bloodGroup;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PatientProfileEntity(
      {required this.id,
      required this.name,
      this.phone,
      this.email,
      this.dateOfBirth,
      this.bloodGroup,
      this.emergencyContactName,
      this.emergencyContactPhone,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<String>(dateOfBirth);
    }
    if (!nullToAbsent || bloodGroup != null) {
      map['blood_group'] = Variable<String>(bloodGroup);
    }
    if (!nullToAbsent || emergencyContactName != null) {
      map['emergency_contact_name'] = Variable<String>(emergencyContactName);
    }
    if (!nullToAbsent || emergencyContactPhone != null) {
      map['emergency_contact_phone'] = Variable<String>(emergencyContactPhone);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PatientProfilesCompanion toCompanion(bool nullToAbsent) {
    return PatientProfilesCompanion(
      id: Value(id),
      name: Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      bloodGroup: bloodGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodGroup),
      emergencyContactName: emergencyContactName == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContactName),
      emergencyContactPhone: emergencyContactPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContactPhone),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PatientProfileEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PatientProfileEntity(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      dateOfBirth: serializer.fromJson<String?>(json['dateOfBirth']),
      bloodGroup: serializer.fromJson<String?>(json['bloodGroup']),
      emergencyContactName:
          serializer.fromJson<String?>(json['emergencyContactName']),
      emergencyContactPhone:
          serializer.fromJson<String?>(json['emergencyContactPhone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'dateOfBirth': serializer.toJson<String?>(dateOfBirth),
      'bloodGroup': serializer.toJson<String?>(bloodGroup),
      'emergencyContactName': serializer.toJson<String?>(emergencyContactName),
      'emergencyContactPhone':
          serializer.toJson<String?>(emergencyContactPhone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PatientProfileEntity copyWith(
          {String? id,
          String? name,
          Value<String?> phone = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> dateOfBirth = const Value.absent(),
          Value<String?> bloodGroup = const Value.absent(),
          Value<String?> emergencyContactName = const Value.absent(),
          Value<String?> emergencyContactPhone = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PatientProfileEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone.present ? phone.value : this.phone,
        email: email.present ? email.value : this.email,
        dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
        bloodGroup: bloodGroup.present ? bloodGroup.value : this.bloodGroup,
        emergencyContactName: emergencyContactName.present
            ? emergencyContactName.value
            : this.emergencyContactName,
        emergencyContactPhone: emergencyContactPhone.present
            ? emergencyContactPhone.value
            : this.emergencyContactPhone,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PatientProfileEntity copyWithCompanion(PatientProfilesCompanion data) {
    return PatientProfileEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      bloodGroup:
          data.bloodGroup.present ? data.bloodGroup.value : this.bloodGroup,
      emergencyContactName: data.emergencyContactName.present
          ? data.emergencyContactName.value
          : this.emergencyContactName,
      emergencyContactPhone: data.emergencyContactPhone.present
          ? data.emergencyContactPhone.value
          : this.emergencyContactPhone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PatientProfileEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('emergencyContactName: $emergencyContactName, ')
          ..write('emergencyContactPhone: $emergencyContactPhone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      phone,
      email,
      dateOfBirth,
      bloodGroup,
      emergencyContactName,
      emergencyContactPhone,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PatientProfileEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.dateOfBirth == this.dateOfBirth &&
          other.bloodGroup == this.bloodGroup &&
          other.emergencyContactName == this.emergencyContactName &&
          other.emergencyContactPhone == this.emergencyContactPhone &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PatientProfilesCompanion extends UpdateCompanion<PatientProfileEntity> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> dateOfBirth;
  final Value<String?> bloodGroup;
  final Value<String?> emergencyContactName;
  final Value<String?> emergencyContactPhone;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PatientProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.bloodGroup = const Value.absent(),
    this.emergencyContactName = const Value.absent(),
    this.emergencyContactPhone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PatientProfilesCompanion.insert({
    required String id,
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.bloodGroup = const Value.absent(),
    this.emergencyContactName = const Value.absent(),
    this.emergencyContactPhone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<PatientProfileEntity> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? dateOfBirth,
    Expression<String>? bloodGroup,
    Expression<String>? emergencyContactName,
    Expression<String>? emergencyContactPhone,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (bloodGroup != null) 'blood_group': bloodGroup,
      if (emergencyContactName != null)
        'emergency_contact_name': emergencyContactName,
      if (emergencyContactPhone != null)
        'emergency_contact_phone': emergencyContactPhone,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PatientProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? phone,
      Value<String?>? email,
      Value<String?>? dateOfBirth,
      Value<String?>? bloodGroup,
      Value<String?>? emergencyContactName,
      Value<String?>? emergencyContactPhone,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PatientProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone:
          emergencyContactPhone ?? this.emergencyContactPhone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String>(dateOfBirth.value);
    }
    if (bloodGroup.present) {
      map['blood_group'] = Variable<String>(bloodGroup.value);
    }
    if (emergencyContactName.present) {
      map['emergency_contact_name'] =
          Variable<String>(emergencyContactName.value);
    }
    if (emergencyContactPhone.present) {
      map['emergency_contact_phone'] =
          Variable<String>(emergencyContactPhone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('emergencyContactName: $emergencyContactName, ')
          ..write('emergencyContactPhone: $emergencyContactPhone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PrescriptionsTable extends Prescriptions
    with TableInfo<$PrescriptionsTable, PrescriptionEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrescriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _doctorNameMeta =
      const VerificationMeta('doctorName');
  @override
  late final GeneratedColumn<String> doctorName = GeneratedColumn<String>(
      'doctor_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _clinicNameMeta =
      const VerificationMeta('clinicName');
  @override
  late final GeneratedColumn<String> clinicName = GeneratedColumn<String>(
      'clinic_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _prescriptionDateMeta =
      const VerificationMeta('prescriptionDate');
  @override
  late final GeneratedColumn<String> prescriptionDate = GeneratedColumn<String>(
      'prescription_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        patientId,
        doctorName,
        clinicName,
        prescriptionDate,
        notes,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prescriptions';
  @override
  VerificationContext validateIntegrity(Insertable<PrescriptionEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('doctor_name')) {
      context.handle(
          _doctorNameMeta,
          doctorName.isAcceptableOrUnknown(
              data['doctor_name']!, _doctorNameMeta));
    }
    if (data.containsKey('clinic_name')) {
      context.handle(
          _clinicNameMeta,
          clinicName.isAcceptableOrUnknown(
              data['clinic_name']!, _clinicNameMeta));
    }
    if (data.containsKey('prescription_date')) {
      context.handle(
          _prescriptionDateMeta,
          prescriptionDate.isAcceptableOrUnknown(
              data['prescription_date']!, _prescriptionDateMeta));
    } else if (isInserting) {
      context.missing(_prescriptionDateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrescriptionEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrescriptionEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      doctorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}doctor_name']),
      clinicName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}clinic_name']),
      prescriptionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}prescription_date'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PrescriptionsTable createAlias(String alias) {
    return $PrescriptionsTable(attachedDatabase, alias);
  }
}

class PrescriptionEntity extends DataClass
    implements Insertable<PrescriptionEntity> {
  final String id;
  final String patientId;
  final String? doctorName;
  final String? clinicName;
  final String prescriptionDate;
  final String? notes;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PrescriptionEntity(
      {required this.id,
      required this.patientId,
      this.doctorName,
      this.clinicName,
      required this.prescriptionDate,
      this.notes,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    if (!nullToAbsent || doctorName != null) {
      map['doctor_name'] = Variable<String>(doctorName);
    }
    if (!nullToAbsent || clinicName != null) {
      map['clinic_name'] = Variable<String>(clinicName);
    }
    map['prescription_date'] = Variable<String>(prescriptionDate);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PrescriptionsCompanion toCompanion(bool nullToAbsent) {
    return PrescriptionsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      doctorName: doctorName == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorName),
      clinicName: clinicName == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicName),
      prescriptionDate: Value(prescriptionDate),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PrescriptionEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrescriptionEntity(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      doctorName: serializer.fromJson<String?>(json['doctorName']),
      clinicName: serializer.fromJson<String?>(json['clinicName']),
      prescriptionDate: serializer.fromJson<String>(json['prescriptionDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'doctorName': serializer.toJson<String?>(doctorName),
      'clinicName': serializer.toJson<String?>(clinicName),
      'prescriptionDate': serializer.toJson<String>(prescriptionDate),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PrescriptionEntity copyWith(
          {String? id,
          String? patientId,
          Value<String?> doctorName = const Value.absent(),
          Value<String?> clinicName = const Value.absent(),
          String? prescriptionDate,
          Value<String?> notes = const Value.absent(),
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PrescriptionEntity(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        doctorName: doctorName.present ? doctorName.value : this.doctorName,
        clinicName: clinicName.present ? clinicName.value : this.clinicName,
        prescriptionDate: prescriptionDate ?? this.prescriptionDate,
        notes: notes.present ? notes.value : this.notes,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PrescriptionEntity copyWithCompanion(PrescriptionsCompanion data) {
    return PrescriptionEntity(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      doctorName:
          data.doctorName.present ? data.doctorName.value : this.doctorName,
      clinicName:
          data.clinicName.present ? data.clinicName.value : this.clinicName,
      prescriptionDate: data.prescriptionDate.present
          ? data.prescriptionDate.value
          : this.prescriptionDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrescriptionEntity(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('doctorName: $doctorName, ')
          ..write('clinicName: $clinicName, ')
          ..write('prescriptionDate: $prescriptionDate, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, patientId, doctorName, clinicName,
      prescriptionDate, notes, status, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrescriptionEntity &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.doctorName == this.doctorName &&
          other.clinicName == this.clinicName &&
          other.prescriptionDate == this.prescriptionDate &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PrescriptionsCompanion extends UpdateCompanion<PrescriptionEntity> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String?> doctorName;
  final Value<String?> clinicName;
  final Value<String> prescriptionDate;
  final Value<String?> notes;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PrescriptionsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.clinicName = const Value.absent(),
    this.prescriptionDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrescriptionsCompanion.insert({
    required String id,
    required String patientId,
    this.doctorName = const Value.absent(),
    this.clinicName = const Value.absent(),
    required String prescriptionDate,
    this.notes = const Value.absent(),
    required String status,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        patientId = Value(patientId),
        prescriptionDate = Value(prescriptionDate),
        status = Value(status);
  static Insertable<PrescriptionEntity> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? doctorName,
    Expression<String>? clinicName,
    Expression<String>? prescriptionDate,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (doctorName != null) 'doctor_name': doctorName,
      if (clinicName != null) 'clinic_name': clinicName,
      if (prescriptionDate != null) 'prescription_date': prescriptionDate,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrescriptionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<String?>? doctorName,
      Value<String?>? clinicName,
      Value<String>? prescriptionDate,
      Value<String?>? notes,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PrescriptionsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      doctorName: doctorName ?? this.doctorName,
      clinicName: clinicName ?? this.clinicName,
      prescriptionDate: prescriptionDate ?? this.prescriptionDate,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (doctorName.present) {
      map['doctor_name'] = Variable<String>(doctorName.value);
    }
    if (clinicName.present) {
      map['clinic_name'] = Variable<String>(clinicName.value);
    }
    if (prescriptionDate.present) {
      map['prescription_date'] = Variable<String>(prescriptionDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrescriptionsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('doctorName: $doctorName, ')
          ..write('clinicName: $clinicName, ')
          ..write('prescriptionDate: $prescriptionDate, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PrescriptionMedicinesTable extends PrescriptionMedicines
    with TableInfo<$PrescriptionMedicinesTable, PrescriptionMedicineEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrescriptionMedicinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _prescriptionIdMeta =
      const VerificationMeta('prescriptionId');
  @override
  late final GeneratedColumn<String> prescriptionId = GeneratedColumn<String>(
      'prescription_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES prescriptions (id) ON DELETE CASCADE'));
  static const VerificationMeta _medicineNameMeta =
      const VerificationMeta('medicineName');
  @override
  late final GeneratedColumn<String> medicineName = GeneratedColumn<String>(
      'medicine_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
      'dosage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationDaysMeta =
      const VerificationMeta('durationDays');
  @override
  late final GeneratedColumn<int> durationDays = GeneratedColumn<int>(
      'duration_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _foodTimingMeta =
      const VerificationMeta('foodTiming');
  @override
  late final GeneratedColumn<String> foodTiming = GeneratedColumn<String>(
      'food_timing', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _instructionsMeta =
      const VerificationMeta('instructions');
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
      'instructions', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        prescriptionId,
        medicineName,
        dosage,
        frequency,
        durationDays,
        foodTiming,
        instructions,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prescription_medicines';
  @override
  VerificationContext validateIntegrity(
      Insertable<PrescriptionMedicineEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('prescription_id')) {
      context.handle(
          _prescriptionIdMeta,
          prescriptionId.isAcceptableOrUnknown(
              data['prescription_id']!, _prescriptionIdMeta));
    } else if (isInserting) {
      context.missing(_prescriptionIdMeta);
    }
    if (data.containsKey('medicine_name')) {
      context.handle(
          _medicineNameMeta,
          medicineName.isAcceptableOrUnknown(
              data['medicine_name']!, _medicineNameMeta));
    } else if (isInserting) {
      context.missing(_medicineNameMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(_dosageMeta,
          dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta));
    } else if (isInserting) {
      context.missing(_dosageMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('duration_days')) {
      context.handle(
          _durationDaysMeta,
          durationDays.isAcceptableOrUnknown(
              data['duration_days']!, _durationDaysMeta));
    }
    if (data.containsKey('food_timing')) {
      context.handle(
          _foodTimingMeta,
          foodTiming.isAcceptableOrUnknown(
              data['food_timing']!, _foodTimingMeta));
    }
    if (data.containsKey('instructions')) {
      context.handle(
          _instructionsMeta,
          instructions.isAcceptableOrUnknown(
              data['instructions']!, _instructionsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrescriptionMedicineEntity map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrescriptionMedicineEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      prescriptionId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}prescription_id'])!,
      medicineName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medicine_name'])!,
      dosage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosage'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      durationDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_days']),
      foodTiming: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_timing']),
      instructions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instructions']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PrescriptionMedicinesTable createAlias(String alias) {
    return $PrescriptionMedicinesTable(attachedDatabase, alias);
  }
}

class PrescriptionMedicineEntity extends DataClass
    implements Insertable<PrescriptionMedicineEntity> {
  final String id;
  final String prescriptionId;
  final String medicineName;
  final String dosage;
  final String frequency;
  final int? durationDays;
  final String? foodTiming;
  final String? instructions;
  final DateTime createdAt;
  const PrescriptionMedicineEntity(
      {required this.id,
      required this.prescriptionId,
      required this.medicineName,
      required this.dosage,
      required this.frequency,
      this.durationDays,
      this.foodTiming,
      this.instructions,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['prescription_id'] = Variable<String>(prescriptionId);
    map['medicine_name'] = Variable<String>(medicineName);
    map['dosage'] = Variable<String>(dosage);
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || durationDays != null) {
      map['duration_days'] = Variable<int>(durationDays);
    }
    if (!nullToAbsent || foodTiming != null) {
      map['food_timing'] = Variable<String>(foodTiming);
    }
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PrescriptionMedicinesCompanion toCompanion(bool nullToAbsent) {
    return PrescriptionMedicinesCompanion(
      id: Value(id),
      prescriptionId: Value(prescriptionId),
      medicineName: Value(medicineName),
      dosage: Value(dosage),
      frequency: Value(frequency),
      durationDays: durationDays == null && nullToAbsent
          ? const Value.absent()
          : Value(durationDays),
      foodTiming: foodTiming == null && nullToAbsent
          ? const Value.absent()
          : Value(foodTiming),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
      createdAt: Value(createdAt),
    );
  }

  factory PrescriptionMedicineEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrescriptionMedicineEntity(
      id: serializer.fromJson<String>(json['id']),
      prescriptionId: serializer.fromJson<String>(json['prescriptionId']),
      medicineName: serializer.fromJson<String>(json['medicineName']),
      dosage: serializer.fromJson<String>(json['dosage']),
      frequency: serializer.fromJson<String>(json['frequency']),
      durationDays: serializer.fromJson<int?>(json['durationDays']),
      foodTiming: serializer.fromJson<String?>(json['foodTiming']),
      instructions: serializer.fromJson<String?>(json['instructions']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'prescriptionId': serializer.toJson<String>(prescriptionId),
      'medicineName': serializer.toJson<String>(medicineName),
      'dosage': serializer.toJson<String>(dosage),
      'frequency': serializer.toJson<String>(frequency),
      'durationDays': serializer.toJson<int?>(durationDays),
      'foodTiming': serializer.toJson<String?>(foodTiming),
      'instructions': serializer.toJson<String?>(instructions),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PrescriptionMedicineEntity copyWith(
          {String? id,
          String? prescriptionId,
          String? medicineName,
          String? dosage,
          String? frequency,
          Value<int?> durationDays = const Value.absent(),
          Value<String?> foodTiming = const Value.absent(),
          Value<String?> instructions = const Value.absent(),
          DateTime? createdAt}) =>
      PrescriptionMedicineEntity(
        id: id ?? this.id,
        prescriptionId: prescriptionId ?? this.prescriptionId,
        medicineName: medicineName ?? this.medicineName,
        dosage: dosage ?? this.dosage,
        frequency: frequency ?? this.frequency,
        durationDays:
            durationDays.present ? durationDays.value : this.durationDays,
        foodTiming: foodTiming.present ? foodTiming.value : this.foodTiming,
        instructions:
            instructions.present ? instructions.value : this.instructions,
        createdAt: createdAt ?? this.createdAt,
      );
  PrescriptionMedicineEntity copyWithCompanion(
      PrescriptionMedicinesCompanion data) {
    return PrescriptionMedicineEntity(
      id: data.id.present ? data.id.value : this.id,
      prescriptionId: data.prescriptionId.present
          ? data.prescriptionId.value
          : this.prescriptionId,
      medicineName: data.medicineName.present
          ? data.medicineName.value
          : this.medicineName,
      dosage: data.dosage.present ? data.dosage.value : this.dosage,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      durationDays: data.durationDays.present
          ? data.durationDays.value
          : this.durationDays,
      foodTiming:
          data.foodTiming.present ? data.foodTiming.value : this.foodTiming,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrescriptionMedicineEntity(')
          ..write('id: $id, ')
          ..write('prescriptionId: $prescriptionId, ')
          ..write('medicineName: $medicineName, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('durationDays: $durationDays, ')
          ..write('foodTiming: $foodTiming, ')
          ..write('instructions: $instructions, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, prescriptionId, medicineName, dosage,
      frequency, durationDays, foodTiming, instructions, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrescriptionMedicineEntity &&
          other.id == this.id &&
          other.prescriptionId == this.prescriptionId &&
          other.medicineName == this.medicineName &&
          other.dosage == this.dosage &&
          other.frequency == this.frequency &&
          other.durationDays == this.durationDays &&
          other.foodTiming == this.foodTiming &&
          other.instructions == this.instructions &&
          other.createdAt == this.createdAt);
}

class PrescriptionMedicinesCompanion
    extends UpdateCompanion<PrescriptionMedicineEntity> {
  final Value<String> id;
  final Value<String> prescriptionId;
  final Value<String> medicineName;
  final Value<String> dosage;
  final Value<String> frequency;
  final Value<int?> durationDays;
  final Value<String?> foodTiming;
  final Value<String?> instructions;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PrescriptionMedicinesCompanion({
    this.id = const Value.absent(),
    this.prescriptionId = const Value.absent(),
    this.medicineName = const Value.absent(),
    this.dosage = const Value.absent(),
    this.frequency = const Value.absent(),
    this.durationDays = const Value.absent(),
    this.foodTiming = const Value.absent(),
    this.instructions = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrescriptionMedicinesCompanion.insert({
    required String id,
    required String prescriptionId,
    required String medicineName,
    required String dosage,
    required String frequency,
    this.durationDays = const Value.absent(),
    this.foodTiming = const Value.absent(),
    this.instructions = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        prescriptionId = Value(prescriptionId),
        medicineName = Value(medicineName),
        dosage = Value(dosage),
        frequency = Value(frequency);
  static Insertable<PrescriptionMedicineEntity> custom({
    Expression<String>? id,
    Expression<String>? prescriptionId,
    Expression<String>? medicineName,
    Expression<String>? dosage,
    Expression<String>? frequency,
    Expression<int>? durationDays,
    Expression<String>? foodTiming,
    Expression<String>? instructions,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (prescriptionId != null) 'prescription_id': prescriptionId,
      if (medicineName != null) 'medicine_name': medicineName,
      if (dosage != null) 'dosage': dosage,
      if (frequency != null) 'frequency': frequency,
      if (durationDays != null) 'duration_days': durationDays,
      if (foodTiming != null) 'food_timing': foodTiming,
      if (instructions != null) 'instructions': instructions,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrescriptionMedicinesCompanion copyWith(
      {Value<String>? id,
      Value<String>? prescriptionId,
      Value<String>? medicineName,
      Value<String>? dosage,
      Value<String>? frequency,
      Value<int?>? durationDays,
      Value<String?>? foodTiming,
      Value<String?>? instructions,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return PrescriptionMedicinesCompanion(
      id: id ?? this.id,
      prescriptionId: prescriptionId ?? this.prescriptionId,
      medicineName: medicineName ?? this.medicineName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      durationDays: durationDays ?? this.durationDays,
      foodTiming: foodTiming ?? this.foodTiming,
      instructions: instructions ?? this.instructions,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (prescriptionId.present) {
      map['prescription_id'] = Variable<String>(prescriptionId.value);
    }
    if (medicineName.present) {
      map['medicine_name'] = Variable<String>(medicineName.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (durationDays.present) {
      map['duration_days'] = Variable<int>(durationDays.value);
    }
    if (foodTiming.present) {
      map['food_timing'] = Variable<String>(foodTiming.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrescriptionMedicinesCompanion(')
          ..write('id: $id, ')
          ..write('prescriptionId: $prescriptionId, ')
          ..write('medicineName: $medicineName, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('durationDays: $durationDays, ')
          ..write('foodTiming: $foodTiming, ')
          ..write('instructions: $instructions, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MedicineSchedulesTable extends MedicineSchedules
    with TableInfo<$MedicineSchedulesTable, MedicineScheduleEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicineSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _prescriptionIdMeta =
      const VerificationMeta('prescriptionId');
  @override
  late final GeneratedColumn<String> prescriptionId = GeneratedColumn<String>(
      'prescription_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES prescriptions (id) ON DELETE CASCADE'));
  static const VerificationMeta _prescriptionMedicineIdMeta =
      const VerificationMeta('prescriptionMedicineId');
  @override
  late final GeneratedColumn<String> prescriptionMedicineId =
      GeneratedColumn<String>('prescription_medicine_id', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES prescription_medicines (id) ON DELETE CASCADE'));
  static const VerificationMeta _medicineNameMeta =
      const VerificationMeta('medicineName');
  @override
  late final GeneratedColumn<String> medicineName = GeneratedColumn<String>(
      'medicine_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
      'dosage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timesPerDayMeta =
      const VerificationMeta('timesPerDay');
  @override
  late final GeneratedColumn<int> timesPerDay = GeneratedColumn<int>(
      'times_per_day', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        prescriptionId,
        prescriptionMedicineId,
        medicineName,
        dosage,
        frequency,
        timesPerDay,
        startDate,
        endDate,
        isActive,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medicine_schedules';
  @override
  VerificationContext validateIntegrity(
      Insertable<MedicineScheduleEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('prescription_id')) {
      context.handle(
          _prescriptionIdMeta,
          prescriptionId.isAcceptableOrUnknown(
              data['prescription_id']!, _prescriptionIdMeta));
    } else if (isInserting) {
      context.missing(_prescriptionIdMeta);
    }
    if (data.containsKey('prescription_medicine_id')) {
      context.handle(
          _prescriptionMedicineIdMeta,
          prescriptionMedicineId.isAcceptableOrUnknown(
              data['prescription_medicine_id']!, _prescriptionMedicineIdMeta));
    } else if (isInserting) {
      context.missing(_prescriptionMedicineIdMeta);
    }
    if (data.containsKey('medicine_name')) {
      context.handle(
          _medicineNameMeta,
          medicineName.isAcceptableOrUnknown(
              data['medicine_name']!, _medicineNameMeta));
    } else if (isInserting) {
      context.missing(_medicineNameMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(_dosageMeta,
          dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta));
    } else if (isInserting) {
      context.missing(_dosageMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('times_per_day')) {
      context.handle(
          _timesPerDayMeta,
          timesPerDay.isAcceptableOrUnknown(
              data['times_per_day']!, _timesPerDayMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicineScheduleEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicineScheduleEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      prescriptionId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}prescription_id'])!,
      prescriptionMedicineId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}prescription_medicine_id'])!,
      medicineName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medicine_name'])!,
      dosage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosage'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      timesPerDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}times_per_day'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MedicineSchedulesTable createAlias(String alias) {
    return $MedicineSchedulesTable(attachedDatabase, alias);
  }
}

class MedicineScheduleEntity extends DataClass
    implements Insertable<MedicineScheduleEntity> {
  final String id;
  final String prescriptionId;
  final String prescriptionMedicineId;
  final String medicineName;
  final String dosage;
  final String frequency;
  final int timesPerDay;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final DateTime createdAt;
  const MedicineScheduleEntity(
      {required this.id,
      required this.prescriptionId,
      required this.prescriptionMedicineId,
      required this.medicineName,
      required this.dosage,
      required this.frequency,
      required this.timesPerDay,
      required this.startDate,
      this.endDate,
      required this.isActive,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['prescription_id'] = Variable<String>(prescriptionId);
    map['prescription_medicine_id'] = Variable<String>(prescriptionMedicineId);
    map['medicine_name'] = Variable<String>(medicineName);
    map['dosage'] = Variable<String>(dosage);
    map['frequency'] = Variable<String>(frequency);
    map['times_per_day'] = Variable<int>(timesPerDay);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MedicineSchedulesCompanion toCompanion(bool nullToAbsent) {
    return MedicineSchedulesCompanion(
      id: Value(id),
      prescriptionId: Value(prescriptionId),
      prescriptionMedicineId: Value(prescriptionMedicineId),
      medicineName: Value(medicineName),
      dosage: Value(dosage),
      frequency: Value(frequency),
      timesPerDay: Value(timesPerDay),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory MedicineScheduleEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicineScheduleEntity(
      id: serializer.fromJson<String>(json['id']),
      prescriptionId: serializer.fromJson<String>(json['prescriptionId']),
      prescriptionMedicineId:
          serializer.fromJson<String>(json['prescriptionMedicineId']),
      medicineName: serializer.fromJson<String>(json['medicineName']),
      dosage: serializer.fromJson<String>(json['dosage']),
      frequency: serializer.fromJson<String>(json['frequency']),
      timesPerDay: serializer.fromJson<int>(json['timesPerDay']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'prescriptionId': serializer.toJson<String>(prescriptionId),
      'prescriptionMedicineId':
          serializer.toJson<String>(prescriptionMedicineId),
      'medicineName': serializer.toJson<String>(medicineName),
      'dosage': serializer.toJson<String>(dosage),
      'frequency': serializer.toJson<String>(frequency),
      'timesPerDay': serializer.toJson<int>(timesPerDay),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MedicineScheduleEntity copyWith(
          {String? id,
          String? prescriptionId,
          String? prescriptionMedicineId,
          String? medicineName,
          String? dosage,
          String? frequency,
          int? timesPerDay,
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          bool? isActive,
          DateTime? createdAt}) =>
      MedicineScheduleEntity(
        id: id ?? this.id,
        prescriptionId: prescriptionId ?? this.prescriptionId,
        prescriptionMedicineId:
            prescriptionMedicineId ?? this.prescriptionMedicineId,
        medicineName: medicineName ?? this.medicineName,
        dosage: dosage ?? this.dosage,
        frequency: frequency ?? this.frequency,
        timesPerDay: timesPerDay ?? this.timesPerDay,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );
  MedicineScheduleEntity copyWithCompanion(MedicineSchedulesCompanion data) {
    return MedicineScheduleEntity(
      id: data.id.present ? data.id.value : this.id,
      prescriptionId: data.prescriptionId.present
          ? data.prescriptionId.value
          : this.prescriptionId,
      prescriptionMedicineId: data.prescriptionMedicineId.present
          ? data.prescriptionMedicineId.value
          : this.prescriptionMedicineId,
      medicineName: data.medicineName.present
          ? data.medicineName.value
          : this.medicineName,
      dosage: data.dosage.present ? data.dosage.value : this.dosage,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      timesPerDay:
          data.timesPerDay.present ? data.timesPerDay.value : this.timesPerDay,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicineScheduleEntity(')
          ..write('id: $id, ')
          ..write('prescriptionId: $prescriptionId, ')
          ..write('prescriptionMedicineId: $prescriptionMedicineId, ')
          ..write('medicineName: $medicineName, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('timesPerDay: $timesPerDay, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      prescriptionId,
      prescriptionMedicineId,
      medicineName,
      dosage,
      frequency,
      timesPerDay,
      startDate,
      endDate,
      isActive,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicineScheduleEntity &&
          other.id == this.id &&
          other.prescriptionId == this.prescriptionId &&
          other.prescriptionMedicineId == this.prescriptionMedicineId &&
          other.medicineName == this.medicineName &&
          other.dosage == this.dosage &&
          other.frequency == this.frequency &&
          other.timesPerDay == this.timesPerDay &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class MedicineSchedulesCompanion
    extends UpdateCompanion<MedicineScheduleEntity> {
  final Value<String> id;
  final Value<String> prescriptionId;
  final Value<String> prescriptionMedicineId;
  final Value<String> medicineName;
  final Value<String> dosage;
  final Value<String> frequency;
  final Value<int> timesPerDay;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MedicineSchedulesCompanion({
    this.id = const Value.absent(),
    this.prescriptionId = const Value.absent(),
    this.prescriptionMedicineId = const Value.absent(),
    this.medicineName = const Value.absent(),
    this.dosage = const Value.absent(),
    this.frequency = const Value.absent(),
    this.timesPerDay = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicineSchedulesCompanion.insert({
    required String id,
    required String prescriptionId,
    required String prescriptionMedicineId,
    required String medicineName,
    required String dosage,
    required String frequency,
    this.timesPerDay = const Value.absent(),
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        prescriptionId = Value(prescriptionId),
        prescriptionMedicineId = Value(prescriptionMedicineId),
        medicineName = Value(medicineName),
        dosage = Value(dosage),
        frequency = Value(frequency),
        startDate = Value(startDate);
  static Insertable<MedicineScheduleEntity> custom({
    Expression<String>? id,
    Expression<String>? prescriptionId,
    Expression<String>? prescriptionMedicineId,
    Expression<String>? medicineName,
    Expression<String>? dosage,
    Expression<String>? frequency,
    Expression<int>? timesPerDay,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (prescriptionId != null) 'prescription_id': prescriptionId,
      if (prescriptionMedicineId != null)
        'prescription_medicine_id': prescriptionMedicineId,
      if (medicineName != null) 'medicine_name': medicineName,
      if (dosage != null) 'dosage': dosage,
      if (frequency != null) 'frequency': frequency,
      if (timesPerDay != null) 'times_per_day': timesPerDay,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicineSchedulesCompanion copyWith(
      {Value<String>? id,
      Value<String>? prescriptionId,
      Value<String>? prescriptionMedicineId,
      Value<String>? medicineName,
      Value<String>? dosage,
      Value<String>? frequency,
      Value<int>? timesPerDay,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return MedicineSchedulesCompanion(
      id: id ?? this.id,
      prescriptionId: prescriptionId ?? this.prescriptionId,
      prescriptionMedicineId:
          prescriptionMedicineId ?? this.prescriptionMedicineId,
      medicineName: medicineName ?? this.medicineName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      timesPerDay: timesPerDay ?? this.timesPerDay,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (prescriptionId.present) {
      map['prescription_id'] = Variable<String>(prescriptionId.value);
    }
    if (prescriptionMedicineId.present) {
      map['prescription_medicine_id'] =
          Variable<String>(prescriptionMedicineId.value);
    }
    if (medicineName.present) {
      map['medicine_name'] = Variable<String>(medicineName.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (timesPerDay.present) {
      map['times_per_day'] = Variable<int>(timesPerDay.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicineSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('prescriptionId: $prescriptionId, ')
          ..write('prescriptionMedicineId: $prescriptionMedicineId, ')
          ..write('medicineName: $medicineName, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('timesPerDay: $timesPerDay, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DoseEventsTable extends DoseEvents
    with TableInfo<$DoseEventsTable, DoseEventEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoseEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _prescriptionIdMeta =
      const VerificationMeta('prescriptionId');
  @override
  late final GeneratedColumn<String> prescriptionId = GeneratedColumn<String>(
      'prescription_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES prescriptions (id) ON DELETE CASCADE'));
  static const VerificationMeta _prescriptionMedicineIdMeta =
      const VerificationMeta('prescriptionMedicineId');
  @override
  late final GeneratedColumn<String> prescriptionMedicineId =
      GeneratedColumn<String>('prescription_medicine_id', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES prescription_medicines (id) ON DELETE CASCADE'));
  static const VerificationMeta _scheduleIdMeta =
      const VerificationMeta('scheduleId');
  @override
  late final GeneratedColumn<String> scheduleId = GeneratedColumn<String>(
      'schedule_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES medicine_schedules (id) ON DELETE CASCADE'));
  static const VerificationMeta _medicineNameMeta =
      const VerificationMeta('medicineName');
  @override
  late final GeneratedColumn<String> medicineName = GeneratedColumn<String>(
      'medicine_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
      'dosage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scheduledAtMeta =
      const VerificationMeta('scheduledAt');
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
      'scheduled_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _foodTimingMeta =
      const VerificationMeta('foodTiming');
  @override
  late final GeneratedColumn<String> foodTiming = GeneratedColumn<String>(
      'food_timing', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _takenAtMeta =
      const VerificationMeta('takenAt');
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
      'taken_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _skippedAtMeta =
      const VerificationMeta('skippedAt');
  @override
  late final GeneratedColumn<DateTime> skippedAt = GeneratedColumn<DateTime>(
      'skipped_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _skipReasonMeta =
      const VerificationMeta('skipReason');
  @override
  late final GeneratedColumn<String> skipReason = GeneratedColumn<String>(
      'skip_reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        prescriptionId,
        prescriptionMedicineId,
        scheduleId,
        medicineName,
        dosage,
        scheduledAt,
        status,
        foodTiming,
        takenAt,
        skippedAt,
        skipReason,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dose_events';
  @override
  VerificationContext validateIntegrity(Insertable<DoseEventEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('prescription_id')) {
      context.handle(
          _prescriptionIdMeta,
          prescriptionId.isAcceptableOrUnknown(
              data['prescription_id']!, _prescriptionIdMeta));
    } else if (isInserting) {
      context.missing(_prescriptionIdMeta);
    }
    if (data.containsKey('prescription_medicine_id')) {
      context.handle(
          _prescriptionMedicineIdMeta,
          prescriptionMedicineId.isAcceptableOrUnknown(
              data['prescription_medicine_id']!, _prescriptionMedicineIdMeta));
    } else if (isInserting) {
      context.missing(_prescriptionMedicineIdMeta);
    }
    if (data.containsKey('schedule_id')) {
      context.handle(
          _scheduleIdMeta,
          scheduleId.isAcceptableOrUnknown(
              data['schedule_id']!, _scheduleIdMeta));
    }
    if (data.containsKey('medicine_name')) {
      context.handle(
          _medicineNameMeta,
          medicineName.isAcceptableOrUnknown(
              data['medicine_name']!, _medicineNameMeta));
    } else if (isInserting) {
      context.missing(_medicineNameMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(_dosageMeta,
          dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta));
    } else if (isInserting) {
      context.missing(_dosageMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
          _scheduledAtMeta,
          scheduledAt.isAcceptableOrUnknown(
              data['scheduled_at']!, _scheduledAtMeta));
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('food_timing')) {
      context.handle(
          _foodTimingMeta,
          foodTiming.isAcceptableOrUnknown(
              data['food_timing']!, _foodTimingMeta));
    }
    if (data.containsKey('taken_at')) {
      context.handle(_takenAtMeta,
          takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta));
    }
    if (data.containsKey('skipped_at')) {
      context.handle(_skippedAtMeta,
          skippedAt.isAcceptableOrUnknown(data['skipped_at']!, _skippedAtMeta));
    }
    if (data.containsKey('skip_reason')) {
      context.handle(
          _skipReasonMeta,
          skipReason.isAcceptableOrUnknown(
              data['skip_reason']!, _skipReasonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DoseEventEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoseEventEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      prescriptionId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}prescription_id'])!,
      prescriptionMedicineId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}prescription_medicine_id'])!,
      scheduleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}schedule_id']),
      medicineName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medicine_name'])!,
      dosage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosage'])!,
      scheduledAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}scheduled_at'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      foodTiming: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_timing']),
      takenAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}taken_at']),
      skippedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}skipped_at']),
      skipReason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}skip_reason']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DoseEventsTable createAlias(String alias) {
    return $DoseEventsTable(attachedDatabase, alias);
  }
}

class DoseEventEntity extends DataClass implements Insertable<DoseEventEntity> {
  final String id;
  final String prescriptionId;
  final String prescriptionMedicineId;
  final String? scheduleId;
  final String medicineName;
  final String dosage;
  final DateTime scheduledAt;
  final String status;
  final String? foodTiming;
  final DateTime? takenAt;
  final DateTime? skippedAt;
  final String? skipReason;
  final DateTime createdAt;
  const DoseEventEntity(
      {required this.id,
      required this.prescriptionId,
      required this.prescriptionMedicineId,
      this.scheduleId,
      required this.medicineName,
      required this.dosage,
      required this.scheduledAt,
      required this.status,
      this.foodTiming,
      this.takenAt,
      this.skippedAt,
      this.skipReason,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['prescription_id'] = Variable<String>(prescriptionId);
    map['prescription_medicine_id'] = Variable<String>(prescriptionMedicineId);
    if (!nullToAbsent || scheduleId != null) {
      map['schedule_id'] = Variable<String>(scheduleId);
    }
    map['medicine_name'] = Variable<String>(medicineName);
    map['dosage'] = Variable<String>(dosage);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || foodTiming != null) {
      map['food_timing'] = Variable<String>(foodTiming);
    }
    if (!nullToAbsent || takenAt != null) {
      map['taken_at'] = Variable<DateTime>(takenAt);
    }
    if (!nullToAbsent || skippedAt != null) {
      map['skipped_at'] = Variable<DateTime>(skippedAt);
    }
    if (!nullToAbsent || skipReason != null) {
      map['skip_reason'] = Variable<String>(skipReason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DoseEventsCompanion toCompanion(bool nullToAbsent) {
    return DoseEventsCompanion(
      id: Value(id),
      prescriptionId: Value(prescriptionId),
      prescriptionMedicineId: Value(prescriptionMedicineId),
      scheduleId: scheduleId == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleId),
      medicineName: Value(medicineName),
      dosage: Value(dosage),
      scheduledAt: Value(scheduledAt),
      status: Value(status),
      foodTiming: foodTiming == null && nullToAbsent
          ? const Value.absent()
          : Value(foodTiming),
      takenAt: takenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(takenAt),
      skippedAt: skippedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(skippedAt),
      skipReason: skipReason == null && nullToAbsent
          ? const Value.absent()
          : Value(skipReason),
      createdAt: Value(createdAt),
    );
  }

  factory DoseEventEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoseEventEntity(
      id: serializer.fromJson<String>(json['id']),
      prescriptionId: serializer.fromJson<String>(json['prescriptionId']),
      prescriptionMedicineId:
          serializer.fromJson<String>(json['prescriptionMedicineId']),
      scheduleId: serializer.fromJson<String?>(json['scheduleId']),
      medicineName: serializer.fromJson<String>(json['medicineName']),
      dosage: serializer.fromJson<String>(json['dosage']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      status: serializer.fromJson<String>(json['status']),
      foodTiming: serializer.fromJson<String?>(json['foodTiming']),
      takenAt: serializer.fromJson<DateTime?>(json['takenAt']),
      skippedAt: serializer.fromJson<DateTime?>(json['skippedAt']),
      skipReason: serializer.fromJson<String?>(json['skipReason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'prescriptionId': serializer.toJson<String>(prescriptionId),
      'prescriptionMedicineId':
          serializer.toJson<String>(prescriptionMedicineId),
      'scheduleId': serializer.toJson<String?>(scheduleId),
      'medicineName': serializer.toJson<String>(medicineName),
      'dosage': serializer.toJson<String>(dosage),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'status': serializer.toJson<String>(status),
      'foodTiming': serializer.toJson<String?>(foodTiming),
      'takenAt': serializer.toJson<DateTime?>(takenAt),
      'skippedAt': serializer.toJson<DateTime?>(skippedAt),
      'skipReason': serializer.toJson<String?>(skipReason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DoseEventEntity copyWith(
          {String? id,
          String? prescriptionId,
          String? prescriptionMedicineId,
          Value<String?> scheduleId = const Value.absent(),
          String? medicineName,
          String? dosage,
          DateTime? scheduledAt,
          String? status,
          Value<String?> foodTiming = const Value.absent(),
          Value<DateTime?> takenAt = const Value.absent(),
          Value<DateTime?> skippedAt = const Value.absent(),
          Value<String?> skipReason = const Value.absent(),
          DateTime? createdAt}) =>
      DoseEventEntity(
        id: id ?? this.id,
        prescriptionId: prescriptionId ?? this.prescriptionId,
        prescriptionMedicineId:
            prescriptionMedicineId ?? this.prescriptionMedicineId,
        scheduleId: scheduleId.present ? scheduleId.value : this.scheduleId,
        medicineName: medicineName ?? this.medicineName,
        dosage: dosage ?? this.dosage,
        scheduledAt: scheduledAt ?? this.scheduledAt,
        status: status ?? this.status,
        foodTiming: foodTiming.present ? foodTiming.value : this.foodTiming,
        takenAt: takenAt.present ? takenAt.value : this.takenAt,
        skippedAt: skippedAt.present ? skippedAt.value : this.skippedAt,
        skipReason: skipReason.present ? skipReason.value : this.skipReason,
        createdAt: createdAt ?? this.createdAt,
      );
  DoseEventEntity copyWithCompanion(DoseEventsCompanion data) {
    return DoseEventEntity(
      id: data.id.present ? data.id.value : this.id,
      prescriptionId: data.prescriptionId.present
          ? data.prescriptionId.value
          : this.prescriptionId,
      prescriptionMedicineId: data.prescriptionMedicineId.present
          ? data.prescriptionMedicineId.value
          : this.prescriptionMedicineId,
      scheduleId:
          data.scheduleId.present ? data.scheduleId.value : this.scheduleId,
      medicineName: data.medicineName.present
          ? data.medicineName.value
          : this.medicineName,
      dosage: data.dosage.present ? data.dosage.value : this.dosage,
      scheduledAt:
          data.scheduledAt.present ? data.scheduledAt.value : this.scheduledAt,
      status: data.status.present ? data.status.value : this.status,
      foodTiming:
          data.foodTiming.present ? data.foodTiming.value : this.foodTiming,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      skippedAt: data.skippedAt.present ? data.skippedAt.value : this.skippedAt,
      skipReason:
          data.skipReason.present ? data.skipReason.value : this.skipReason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoseEventEntity(')
          ..write('id: $id, ')
          ..write('prescriptionId: $prescriptionId, ')
          ..write('prescriptionMedicineId: $prescriptionMedicineId, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('medicineName: $medicineName, ')
          ..write('dosage: $dosage, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('status: $status, ')
          ..write('foodTiming: $foodTiming, ')
          ..write('takenAt: $takenAt, ')
          ..write('skippedAt: $skippedAt, ')
          ..write('skipReason: $skipReason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      prescriptionId,
      prescriptionMedicineId,
      scheduleId,
      medicineName,
      dosage,
      scheduledAt,
      status,
      foodTiming,
      takenAt,
      skippedAt,
      skipReason,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoseEventEntity &&
          other.id == this.id &&
          other.prescriptionId == this.prescriptionId &&
          other.prescriptionMedicineId == this.prescriptionMedicineId &&
          other.scheduleId == this.scheduleId &&
          other.medicineName == this.medicineName &&
          other.dosage == this.dosage &&
          other.scheduledAt == this.scheduledAt &&
          other.status == this.status &&
          other.foodTiming == this.foodTiming &&
          other.takenAt == this.takenAt &&
          other.skippedAt == this.skippedAt &&
          other.skipReason == this.skipReason &&
          other.createdAt == this.createdAt);
}

class DoseEventsCompanion extends UpdateCompanion<DoseEventEntity> {
  final Value<String> id;
  final Value<String> prescriptionId;
  final Value<String> prescriptionMedicineId;
  final Value<String?> scheduleId;
  final Value<String> medicineName;
  final Value<String> dosage;
  final Value<DateTime> scheduledAt;
  final Value<String> status;
  final Value<String?> foodTiming;
  final Value<DateTime?> takenAt;
  final Value<DateTime?> skippedAt;
  final Value<String?> skipReason;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DoseEventsCompanion({
    this.id = const Value.absent(),
    this.prescriptionId = const Value.absent(),
    this.prescriptionMedicineId = const Value.absent(),
    this.scheduleId = const Value.absent(),
    this.medicineName = const Value.absent(),
    this.dosage = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.status = const Value.absent(),
    this.foodTiming = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.skippedAt = const Value.absent(),
    this.skipReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DoseEventsCompanion.insert({
    required String id,
    required String prescriptionId,
    required String prescriptionMedicineId,
    this.scheduleId = const Value.absent(),
    required String medicineName,
    required String dosage,
    required DateTime scheduledAt,
    required String status,
    this.foodTiming = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.skippedAt = const Value.absent(),
    this.skipReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        prescriptionId = Value(prescriptionId),
        prescriptionMedicineId = Value(prescriptionMedicineId),
        medicineName = Value(medicineName),
        dosage = Value(dosage),
        scheduledAt = Value(scheduledAt),
        status = Value(status);
  static Insertable<DoseEventEntity> custom({
    Expression<String>? id,
    Expression<String>? prescriptionId,
    Expression<String>? prescriptionMedicineId,
    Expression<String>? scheduleId,
    Expression<String>? medicineName,
    Expression<String>? dosage,
    Expression<DateTime>? scheduledAt,
    Expression<String>? status,
    Expression<String>? foodTiming,
    Expression<DateTime>? takenAt,
    Expression<DateTime>? skippedAt,
    Expression<String>? skipReason,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (prescriptionId != null) 'prescription_id': prescriptionId,
      if (prescriptionMedicineId != null)
        'prescription_medicine_id': prescriptionMedicineId,
      if (scheduleId != null) 'schedule_id': scheduleId,
      if (medicineName != null) 'medicine_name': medicineName,
      if (dosage != null) 'dosage': dosage,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (status != null) 'status': status,
      if (foodTiming != null) 'food_timing': foodTiming,
      if (takenAt != null) 'taken_at': takenAt,
      if (skippedAt != null) 'skipped_at': skippedAt,
      if (skipReason != null) 'skip_reason': skipReason,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DoseEventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? prescriptionId,
      Value<String>? prescriptionMedicineId,
      Value<String?>? scheduleId,
      Value<String>? medicineName,
      Value<String>? dosage,
      Value<DateTime>? scheduledAt,
      Value<String>? status,
      Value<String?>? foodTiming,
      Value<DateTime?>? takenAt,
      Value<DateTime?>? skippedAt,
      Value<String?>? skipReason,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return DoseEventsCompanion(
      id: id ?? this.id,
      prescriptionId: prescriptionId ?? this.prescriptionId,
      prescriptionMedicineId:
          prescriptionMedicineId ?? this.prescriptionMedicineId,
      scheduleId: scheduleId ?? this.scheduleId,
      medicineName: medicineName ?? this.medicineName,
      dosage: dosage ?? this.dosage,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      status: status ?? this.status,
      foodTiming: foodTiming ?? this.foodTiming,
      takenAt: takenAt ?? this.takenAt,
      skippedAt: skippedAt ?? this.skippedAt,
      skipReason: skipReason ?? this.skipReason,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (prescriptionId.present) {
      map['prescription_id'] = Variable<String>(prescriptionId.value);
    }
    if (prescriptionMedicineId.present) {
      map['prescription_medicine_id'] =
          Variable<String>(prescriptionMedicineId.value);
    }
    if (scheduleId.present) {
      map['schedule_id'] = Variable<String>(scheduleId.value);
    }
    if (medicineName.present) {
      map['medicine_name'] = Variable<String>(medicineName.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (foodTiming.present) {
      map['food_timing'] = Variable<String>(foodTiming.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    if (skippedAt.present) {
      map['skipped_at'] = Variable<DateTime>(skippedAt.value);
    }
    if (skipReason.present) {
      map['skip_reason'] = Variable<String>(skipReason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoseEventsCompanion(')
          ..write('id: $id, ')
          ..write('prescriptionId: $prescriptionId, ')
          ..write('prescriptionMedicineId: $prescriptionMedicineId, ')
          ..write('scheduleId: $scheduleId, ')
          ..write('medicineName: $medicineName, ')
          ..write('dosage: $dosage, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('status: $status, ')
          ..write('foodTiming: $foodTiming, ')
          ..write('takenAt: $takenAt, ')
          ..write('skippedAt: $skippedAt, ')
          ..write('skipReason: $skipReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppointmentsTable extends Appointments
    with TableInfo<$AppointmentsTable, AppointmentEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppointmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _doctorNameMeta =
      const VerificationMeta('doctorName');
  @override
  late final GeneratedColumn<String> doctorName = GeneratedColumn<String>(
      'doctor_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clinicNameMeta =
      const VerificationMeta('clinicName');
  @override
  late final GeneratedColumn<String> clinicName = GeneratedColumn<String>(
      'clinic_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _appointmentDatetimeMeta =
      const VerificationMeta('appointmentDatetime');
  @override
  late final GeneratedColumn<DateTime> appointmentDatetime =
      GeneratedColumn<DateTime>('appointment_datetime', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _timezoneMeta =
      const VerificationMeta('timezone');
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
      'timezone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        patientId,
        doctorName,
        clinicName,
        appointmentDatetime,
        timezone,
        notes,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appointments';
  @override
  VerificationContext validateIntegrity(Insertable<AppointmentEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('doctor_name')) {
      context.handle(
          _doctorNameMeta,
          doctorName.isAcceptableOrUnknown(
              data['doctor_name']!, _doctorNameMeta));
    } else if (isInserting) {
      context.missing(_doctorNameMeta);
    }
    if (data.containsKey('clinic_name')) {
      context.handle(
          _clinicNameMeta,
          clinicName.isAcceptableOrUnknown(
              data['clinic_name']!, _clinicNameMeta));
    }
    if (data.containsKey('appointment_datetime')) {
      context.handle(
          _appointmentDatetimeMeta,
          appointmentDatetime.isAcceptableOrUnknown(
              data['appointment_datetime']!, _appointmentDatetimeMeta));
    } else if (isInserting) {
      context.missing(_appointmentDatetimeMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(_timezoneMeta,
          timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppointmentEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppointmentEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      doctorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}doctor_name'])!,
      clinicName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}clinic_name']),
      appointmentDatetime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}appointment_datetime'])!,
      timezone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timezone']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AppointmentsTable createAlias(String alias) {
    return $AppointmentsTable(attachedDatabase, alias);
  }
}

class AppointmentEntity extends DataClass
    implements Insertable<AppointmentEntity> {
  final String id;
  final String patientId;
  final String doctorName;
  final String? clinicName;
  final DateTime appointmentDatetime;
  final String? timezone;
  final String? notes;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AppointmentEntity(
      {required this.id,
      required this.patientId,
      required this.doctorName,
      this.clinicName,
      required this.appointmentDatetime,
      this.timezone,
      this.notes,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['doctor_name'] = Variable<String>(doctorName);
    if (!nullToAbsent || clinicName != null) {
      map['clinic_name'] = Variable<String>(clinicName);
    }
    map['appointment_datetime'] = Variable<DateTime>(appointmentDatetime);
    if (!nullToAbsent || timezone != null) {
      map['timezone'] = Variable<String>(timezone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppointmentsCompanion toCompanion(bool nullToAbsent) {
    return AppointmentsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      doctorName: Value(doctorName),
      clinicName: clinicName == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicName),
      appointmentDatetime: Value(appointmentDatetime),
      timezone: timezone == null && nullToAbsent
          ? const Value.absent()
          : Value(timezone),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppointmentEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppointmentEntity(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      doctorName: serializer.fromJson<String>(json['doctorName']),
      clinicName: serializer.fromJson<String?>(json['clinicName']),
      appointmentDatetime:
          serializer.fromJson<DateTime>(json['appointmentDatetime']),
      timezone: serializer.fromJson<String?>(json['timezone']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'doctorName': serializer.toJson<String>(doctorName),
      'clinicName': serializer.toJson<String?>(clinicName),
      'appointmentDatetime': serializer.toJson<DateTime>(appointmentDatetime),
      'timezone': serializer.toJson<String?>(timezone),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppointmentEntity copyWith(
          {String? id,
          String? patientId,
          String? doctorName,
          Value<String?> clinicName = const Value.absent(),
          DateTime? appointmentDatetime,
          Value<String?> timezone = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      AppointmentEntity(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        doctorName: doctorName ?? this.doctorName,
        clinicName: clinicName.present ? clinicName.value : this.clinicName,
        appointmentDatetime: appointmentDatetime ?? this.appointmentDatetime,
        timezone: timezone.present ? timezone.value : this.timezone,
        notes: notes.present ? notes.value : this.notes,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppointmentEntity copyWithCompanion(AppointmentsCompanion data) {
    return AppointmentEntity(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      doctorName:
          data.doctorName.present ? data.doctorName.value : this.doctorName,
      clinicName:
          data.clinicName.present ? data.clinicName.value : this.clinicName,
      appointmentDatetime: data.appointmentDatetime.present
          ? data.appointmentDatetime.value
          : this.appointmentDatetime,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentEntity(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('doctorName: $doctorName, ')
          ..write('clinicName: $clinicName, ')
          ..write('appointmentDatetime: $appointmentDatetime, ')
          ..write('timezone: $timezone, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, patientId, doctorName, clinicName,
      appointmentDatetime, timezone, notes, status, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppointmentEntity &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.doctorName == this.doctorName &&
          other.clinicName == this.clinicName &&
          other.appointmentDatetime == this.appointmentDatetime &&
          other.timezone == this.timezone &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppointmentsCompanion extends UpdateCompanion<AppointmentEntity> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> doctorName;
  final Value<String?> clinicName;
  final Value<DateTime> appointmentDatetime;
  final Value<String?> timezone;
  final Value<String?> notes;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppointmentsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.clinicName = const Value.absent(),
    this.appointmentDatetime = const Value.absent(),
    this.timezone = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppointmentsCompanion.insert({
    required String id,
    required String patientId,
    required String doctorName,
    this.clinicName = const Value.absent(),
    required DateTime appointmentDatetime,
    this.timezone = const Value.absent(),
    this.notes = const Value.absent(),
    required String status,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        patientId = Value(patientId),
        doctorName = Value(doctorName),
        appointmentDatetime = Value(appointmentDatetime),
        status = Value(status);
  static Insertable<AppointmentEntity> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? doctorName,
    Expression<String>? clinicName,
    Expression<DateTime>? appointmentDatetime,
    Expression<String>? timezone,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (doctorName != null) 'doctor_name': doctorName,
      if (clinicName != null) 'clinic_name': clinicName,
      if (appointmentDatetime != null)
        'appointment_datetime': appointmentDatetime,
      if (timezone != null) 'timezone': timezone,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppointmentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<String>? doctorName,
      Value<String?>? clinicName,
      Value<DateTime>? appointmentDatetime,
      Value<String?>? timezone,
      Value<String?>? notes,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return AppointmentsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      doctorName: doctorName ?? this.doctorName,
      clinicName: clinicName ?? this.clinicName,
      appointmentDatetime: appointmentDatetime ?? this.appointmentDatetime,
      timezone: timezone ?? this.timezone,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (doctorName.present) {
      map['doctor_name'] = Variable<String>(doctorName.value);
    }
    if (clinicName.present) {
      map['clinic_name'] = Variable<String>(clinicName.value);
    }
    if (appointmentDatetime.present) {
      map['appointment_datetime'] =
          Variable<DateTime>(appointmentDatetime.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('doctorName: $doctorName, ')
          ..write('clinicName: $clinicName, ')
          ..write('appointmentDatetime: $appointmentDatetime, ')
          ..write('timezone: $timezone, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AllergiesTable extends Allergies
    with TableInfo<$AllergiesTable, AllergyEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AllergiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('p1'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _severityMeta =
      const VerificationMeta('severity');
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
      'severity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reactionMeta =
      const VerificationMeta('reaction');
  @override
  late final GeneratedColumn<String> reaction = GeneratedColumn<String>(
      'reaction', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, patientId, name, severity, reaction, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'allergies';
  @override
  VerificationContext validateIntegrity(Insertable<AllergyEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(_severityMeta,
          severity.isAcceptableOrUnknown(data['severity']!, _severityMeta));
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('reaction')) {
      context.handle(_reactionMeta,
          reaction.isAcceptableOrUnknown(data['reaction']!, _reactionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AllergyEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AllergyEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      severity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}severity'])!,
      reaction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reaction']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AllergiesTable createAlias(String alias) {
    return $AllergiesTable(attachedDatabase, alias);
  }
}

class AllergyEntity extends DataClass implements Insertable<AllergyEntity> {
  final String id;
  final String patientId;
  final String name;
  final String severity;
  final String? reaction;
  final DateTime createdAt;
  const AllergyEntity(
      {required this.id,
      required this.patientId,
      required this.name,
      required this.severity,
      this.reaction,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['name'] = Variable<String>(name);
    map['severity'] = Variable<String>(severity);
    if (!nullToAbsent || reaction != null) {
      map['reaction'] = Variable<String>(reaction);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AllergiesCompanion toCompanion(bool nullToAbsent) {
    return AllergiesCompanion(
      id: Value(id),
      patientId: Value(patientId),
      name: Value(name),
      severity: Value(severity),
      reaction: reaction == null && nullToAbsent
          ? const Value.absent()
          : Value(reaction),
      createdAt: Value(createdAt),
    );
  }

  factory AllergyEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AllergyEntity(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      name: serializer.fromJson<String>(json['name']),
      severity: serializer.fromJson<String>(json['severity']),
      reaction: serializer.fromJson<String?>(json['reaction']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'name': serializer.toJson<String>(name),
      'severity': serializer.toJson<String>(severity),
      'reaction': serializer.toJson<String?>(reaction),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AllergyEntity copyWith(
          {String? id,
          String? patientId,
          String? name,
          String? severity,
          Value<String?> reaction = const Value.absent(),
          DateTime? createdAt}) =>
      AllergyEntity(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        name: name ?? this.name,
        severity: severity ?? this.severity,
        reaction: reaction.present ? reaction.value : this.reaction,
        createdAt: createdAt ?? this.createdAt,
      );
  AllergyEntity copyWithCompanion(AllergiesCompanion data) {
    return AllergyEntity(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      name: data.name.present ? data.name.value : this.name,
      severity: data.severity.present ? data.severity.value : this.severity,
      reaction: data.reaction.present ? data.reaction.value : this.reaction,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AllergyEntity(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('severity: $severity, ')
          ..write('reaction: $reaction, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, patientId, name, severity, reaction, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AllergyEntity &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.name == this.name &&
          other.severity == this.severity &&
          other.reaction == this.reaction &&
          other.createdAt == this.createdAt);
}

class AllergiesCompanion extends UpdateCompanion<AllergyEntity> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> name;
  final Value<String> severity;
  final Value<String?> reaction;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AllergiesCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.name = const Value.absent(),
    this.severity = const Value.absent(),
    this.reaction = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AllergiesCompanion.insert({
    required String id,
    this.patientId = const Value.absent(),
    required String name,
    required String severity,
    this.reaction = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        severity = Value(severity);
  static Insertable<AllergyEntity> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? name,
    Expression<String>? severity,
    Expression<String>? reaction,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (name != null) 'name': name,
      if (severity != null) 'severity': severity,
      if (reaction != null) 'reaction': reaction,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AllergiesCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<String>? name,
      Value<String>? severity,
      Value<String?>? reaction,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return AllergiesCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      name: name ?? this.name,
      severity: severity ?? this.severity,
      reaction: reaction ?? this.reaction,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (reaction.present) {
      map['reaction'] = Variable<String>(reaction.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AllergiesCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('severity: $severity, ')
          ..write('reaction: $reaction, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FamilyMembersTable extends FamilyMembers
    with TableInfo<$FamilyMembersTable, FamilyMemberEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FamilyMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientIdMeta =
      const VerificationMeta('patientId');
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
      'patient_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('p1'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _relationMeta =
      const VerificationMeta('relation');
  @override
  late final GeneratedColumn<String> relation = GeneratedColumn<String>(
      'relation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<String> dateOfBirth = GeneratedColumn<String>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, patientId, name, relation, dateOfBirth, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'family_members';
  @override
  VerificationContext validateIntegrity(Insertable<FamilyMemberEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(_patientIdMeta,
          patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('relation')) {
      context.handle(_relationMeta,
          relation.isAcceptableOrUnknown(data['relation']!, _relationMeta));
    } else if (isInserting) {
      context.missing(_relationMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FamilyMemberEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FamilyMemberEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      patientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      relation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}relation'])!,
      dateOfBirth: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_of_birth']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FamilyMembersTable createAlias(String alias) {
    return $FamilyMembersTable(attachedDatabase, alias);
  }
}

class FamilyMemberEntity extends DataClass
    implements Insertable<FamilyMemberEntity> {
  final String id;
  final String patientId;
  final String name;
  final String relation;
  final String? dateOfBirth;
  final DateTime createdAt;
  const FamilyMemberEntity(
      {required this.id,
      required this.patientId,
      required this.name,
      required this.relation,
      this.dateOfBirth,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['name'] = Variable<String>(name);
    map['relation'] = Variable<String>(relation);
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<String>(dateOfBirth);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FamilyMembersCompanion toCompanion(bool nullToAbsent) {
    return FamilyMembersCompanion(
      id: Value(id),
      patientId: Value(patientId),
      name: Value(name),
      relation: Value(relation),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      createdAt: Value(createdAt),
    );
  }

  factory FamilyMemberEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FamilyMemberEntity(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      name: serializer.fromJson<String>(json['name']),
      relation: serializer.fromJson<String>(json['relation']),
      dateOfBirth: serializer.fromJson<String?>(json['dateOfBirth']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'name': serializer.toJson<String>(name),
      'relation': serializer.toJson<String>(relation),
      'dateOfBirth': serializer.toJson<String?>(dateOfBirth),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FamilyMemberEntity copyWith(
          {String? id,
          String? patientId,
          String? name,
          String? relation,
          Value<String?> dateOfBirth = const Value.absent(),
          DateTime? createdAt}) =>
      FamilyMemberEntity(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        name: name ?? this.name,
        relation: relation ?? this.relation,
        dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
        createdAt: createdAt ?? this.createdAt,
      );
  FamilyMemberEntity copyWithCompanion(FamilyMembersCompanion data) {
    return FamilyMemberEntity(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      name: data.name.present ? data.name.value : this.name,
      relation: data.relation.present ? data.relation.value : this.relation,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FamilyMemberEntity(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('relation: $relation, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, patientId, name, relation, dateOfBirth, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FamilyMemberEntity &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.name == this.name &&
          other.relation == this.relation &&
          other.dateOfBirth == this.dateOfBirth &&
          other.createdAt == this.createdAt);
}

class FamilyMembersCompanion extends UpdateCompanion<FamilyMemberEntity> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> name;
  final Value<String> relation;
  final Value<String?> dateOfBirth;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FamilyMembersCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.name = const Value.absent(),
    this.relation = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FamilyMembersCompanion.insert({
    required String id,
    this.patientId = const Value.absent(),
    required String name,
    required String relation,
    this.dateOfBirth = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        relation = Value(relation);
  static Insertable<FamilyMemberEntity> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? name,
    Expression<String>? relation,
    Expression<String>? dateOfBirth,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (name != null) 'name': name,
      if (relation != null) 'relation': relation,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FamilyMembersCompanion copyWith(
      {Value<String>? id,
      Value<String>? patientId,
      Value<String>? name,
      Value<String>? relation,
      Value<String?>? dateOfBirth,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return FamilyMembersCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      name: name ?? this.name,
      relation: relation ?? this.relation,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (relation.present) {
      map['relation'] = Variable<String>(relation.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String>(dateOfBirth.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FamilyMembersCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('relation: $relation, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PatientProfilesTable patientProfiles =
      $PatientProfilesTable(this);
  late final $PrescriptionsTable prescriptions = $PrescriptionsTable(this);
  late final $PrescriptionMedicinesTable prescriptionMedicines =
      $PrescriptionMedicinesTable(this);
  late final $MedicineSchedulesTable medicineSchedules =
      $MedicineSchedulesTable(this);
  late final $DoseEventsTable doseEvents = $DoseEventsTable(this);
  late final $AppointmentsTable appointments = $AppointmentsTable(this);
  late final $AllergiesTable allergies = $AllergiesTable(this);
  late final $FamilyMembersTable familyMembers = $FamilyMembersTable(this);
  late final Index patientProfilesIdIdx = Index('patient_profiles_id_idx',
      'CREATE INDEX patient_profiles_id_idx ON patient_profiles (id)');
  late final Index prescriptionsPatientIdx = Index('prescriptions_patient_idx',
      'CREATE INDEX prescriptions_patient_idx ON prescriptions (patient_id)');
  late final Index prescriptionsStatusIdx = Index('prescriptions_status_idx',
      'CREATE INDEX prescriptions_status_idx ON prescriptions (status)');
  late final Index prescriptionMedicinesRxIdx = Index(
      'prescription_medicines_rx_idx',
      'CREATE INDEX prescription_medicines_rx_idx ON prescription_medicines (prescription_id)');
  late final Index medicineSchedulesRxIdx = Index('medicine_schedules_rx_idx',
      'CREATE INDEX medicine_schedules_rx_idx ON medicine_schedules (prescription_id)');
  late final Index medicineSchedulesActiveIdx = Index(
      'medicine_schedules_active_idx',
      'CREATE INDEX medicine_schedules_active_idx ON medicine_schedules (is_active)');
  late final Index doseEventsScheduledIdx = Index('dose_events_scheduled_idx',
      'CREATE INDEX dose_events_scheduled_idx ON dose_events (scheduled_at)');
  late final Index doseEventsStatusIdx = Index('dose_events_status_idx',
      'CREATE INDEX dose_events_status_idx ON dose_events (status)');
  late final Index doseEventsRxIdx = Index('dose_events_rx_idx',
      'CREATE INDEX dose_events_rx_idx ON dose_events (prescription_id)');
  late final Index appointmentsDatetimeIdx = Index('appointments_datetime_idx',
      'CREATE INDEX appointments_datetime_idx ON appointments (appointment_datetime)');
  late final Index appointmentsStatusIdx = Index('appointments_status_idx',
      'CREATE INDEX appointments_status_idx ON appointments (status)');
  late final Index allergiesPatientIdx = Index('allergies_patient_idx',
      'CREATE INDEX allergies_patient_idx ON allergies (patient_id)');
  late final Index familyMembersPatientIdx = Index('family_members_patient_idx',
      'CREATE INDEX family_members_patient_idx ON family_members (patient_id)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        patientProfiles,
        prescriptions,
        prescriptionMedicines,
        medicineSchedules,
        doseEvents,
        appointments,
        allergies,
        familyMembers,
        patientProfilesIdIdx,
        prescriptionsPatientIdx,
        prescriptionsStatusIdx,
        prescriptionMedicinesRxIdx,
        medicineSchedulesRxIdx,
        medicineSchedulesActiveIdx,
        doseEventsScheduledIdx,
        doseEventsStatusIdx,
        doseEventsRxIdx,
        appointmentsDatetimeIdx,
        appointmentsStatusIdx,
        allergiesPatientIdx,
        familyMembersPatientIdx
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('prescriptions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('prescription_medicines', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('prescriptions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('medicine_schedules', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('prescription_medicines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('medicine_schedules', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('prescriptions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('dose_events', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('prescription_medicines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('dose_events', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('medicine_schedules',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('dose_events', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$PatientProfilesTableCreateCompanionBuilder = PatientProfilesCompanion
    Function({
  required String id,
  required String name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> dateOfBirth,
  Value<String?> bloodGroup,
  Value<String?> emergencyContactName,
  Value<String?> emergencyContactPhone,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$PatientProfilesTableUpdateCompanionBuilder = PatientProfilesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> dateOfBirth,
  Value<String?> bloodGroup,
  Value<String?> emergencyContactName,
  Value<String?> emergencyContactPhone,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$PatientProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $PatientProfilesTable> {
  $$PatientProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bloodGroup => $composableBuilder(
      column: $table.bloodGroup, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emergencyContactName => $composableBuilder(
      column: $table.emergencyContactName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emergencyContactPhone => $composableBuilder(
      column: $table.emergencyContactPhone,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$PatientProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientProfilesTable> {
  $$PatientProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bloodGroup => $composableBuilder(
      column: $table.bloodGroup, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emergencyContactName => $composableBuilder(
      column: $table.emergencyContactName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emergencyContactPhone => $composableBuilder(
      column: $table.emergencyContactPhone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PatientProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientProfilesTable> {
  $$PatientProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => column);

  GeneratedColumn<String> get bloodGroup => $composableBuilder(
      column: $table.bloodGroup, builder: (column) => column);

  GeneratedColumn<String> get emergencyContactName => $composableBuilder(
      column: $table.emergencyContactName, builder: (column) => column);

  GeneratedColumn<String> get emergencyContactPhone => $composableBuilder(
      column: $table.emergencyContactPhone, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PatientProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PatientProfilesTable,
    PatientProfileEntity,
    $$PatientProfilesTableFilterComposer,
    $$PatientProfilesTableOrderingComposer,
    $$PatientProfilesTableAnnotationComposer,
    $$PatientProfilesTableCreateCompanionBuilder,
    $$PatientProfilesTableUpdateCompanionBuilder,
    (
      PatientProfileEntity,
      BaseReferences<_$AppDatabase, $PatientProfilesTable, PatientProfileEntity>
    ),
    PatientProfileEntity,
    PrefetchHooks Function()> {
  $$PatientProfilesTableTableManager(
      _$AppDatabase db, $PatientProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatientProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatientProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> dateOfBirth = const Value.absent(),
            Value<String?> bloodGroup = const Value.absent(),
            Value<String?> emergencyContactName = const Value.absent(),
            Value<String?> emergencyContactPhone = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PatientProfilesCompanion(
            id: id,
            name: name,
            phone: phone,
            email: email,
            dateOfBirth: dateOfBirth,
            bloodGroup: bloodGroup,
            emergencyContactName: emergencyContactName,
            emergencyContactPhone: emergencyContactPhone,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> dateOfBirth = const Value.absent(),
            Value<String?> bloodGroup = const Value.absent(),
            Value<String?> emergencyContactName = const Value.absent(),
            Value<String?> emergencyContactPhone = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PatientProfilesCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            email: email,
            dateOfBirth: dateOfBirth,
            bloodGroup: bloodGroup,
            emergencyContactName: emergencyContactName,
            emergencyContactPhone: emergencyContactPhone,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PatientProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PatientProfilesTable,
    PatientProfileEntity,
    $$PatientProfilesTableFilterComposer,
    $$PatientProfilesTableOrderingComposer,
    $$PatientProfilesTableAnnotationComposer,
    $$PatientProfilesTableCreateCompanionBuilder,
    $$PatientProfilesTableUpdateCompanionBuilder,
    (
      PatientProfileEntity,
      BaseReferences<_$AppDatabase, $PatientProfilesTable, PatientProfileEntity>
    ),
    PatientProfileEntity,
    PrefetchHooks Function()>;
typedef $$PrescriptionsTableCreateCompanionBuilder = PrescriptionsCompanion
    Function({
  required String id,
  required String patientId,
  Value<String?> doctorName,
  Value<String?> clinicName,
  required String prescriptionDate,
  Value<String?> notes,
  required String status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$PrescriptionsTableUpdateCompanionBuilder = PrescriptionsCompanion
    Function({
  Value<String> id,
  Value<String> patientId,
  Value<String?> doctorName,
  Value<String?> clinicName,
  Value<String> prescriptionDate,
  Value<String?> notes,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$PrescriptionsTableReferences extends BaseReferences<_$AppDatabase,
    $PrescriptionsTable, PrescriptionEntity> {
  $$PrescriptionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PrescriptionMedicinesTable,
      List<PrescriptionMedicineEntity>> _prescriptionMedicinesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.prescriptionMedicines,
          aliasName: $_aliasNameGenerator(
              db.prescriptions.id, db.prescriptionMedicines.prescriptionId));

  $$PrescriptionMedicinesTableProcessedTableManager
      get prescriptionMedicinesRefs {
    final manager = $$PrescriptionMedicinesTableTableManager(
            $_db, $_db.prescriptionMedicines)
        .filter((f) => f.prescriptionId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_prescriptionMedicinesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MedicineSchedulesTable,
      List<MedicineScheduleEntity>> _medicineSchedulesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.medicineSchedules,
          aliasName: $_aliasNameGenerator(
              db.prescriptions.id, db.medicineSchedules.prescriptionId));

  $$MedicineSchedulesTableProcessedTableManager get medicineSchedulesRefs {
    final manager =
        $$MedicineSchedulesTableTableManager($_db, $_db.medicineSchedules)
            .filter((f) => f.prescriptionId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_medicineSchedulesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DoseEventsTable, List<DoseEventEntity>>
      _doseEventsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.doseEvents,
              aliasName: $_aliasNameGenerator(
                  db.prescriptions.id, db.doseEvents.prescriptionId));

  $$DoseEventsTableProcessedTableManager get doseEventsRefs {
    final manager = $$DoseEventsTableTableManager($_db, $_db.doseEvents)
        .filter((f) => f.prescriptionId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_doseEventsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PrescriptionsTableFilterComposer
    extends Composer<_$AppDatabase, $PrescriptionsTable> {
  $$PrescriptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get doctorName => $composableBuilder(
      column: $table.doctorName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clinicName => $composableBuilder(
      column: $table.clinicName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prescriptionDate => $composableBuilder(
      column: $table.prescriptionDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> prescriptionMedicinesRefs(
      Expression<bool> Function($$PrescriptionMedicinesTableFilterComposer f)
          f) {
    final $$PrescriptionMedicinesTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.prescriptionMedicines,
            getReferencedColumn: (t) => t.prescriptionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PrescriptionMedicinesTableFilterComposer(
                  $db: $db,
                  $table: $db.prescriptionMedicines,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> medicineSchedulesRefs(
      Expression<bool> Function($$MedicineSchedulesTableFilterComposer f) f) {
    final $$MedicineSchedulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medicineSchedules,
        getReferencedColumn: (t) => t.prescriptionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicineSchedulesTableFilterComposer(
              $db: $db,
              $table: $db.medicineSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> doseEventsRefs(
      Expression<bool> Function($$DoseEventsTableFilterComposer f) f) {
    final $$DoseEventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.doseEvents,
        getReferencedColumn: (t) => t.prescriptionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DoseEventsTableFilterComposer(
              $db: $db,
              $table: $db.doseEvents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PrescriptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PrescriptionsTable> {
  $$PrescriptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get doctorName => $composableBuilder(
      column: $table.doctorName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clinicName => $composableBuilder(
      column: $table.clinicName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prescriptionDate => $composableBuilder(
      column: $table.prescriptionDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PrescriptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrescriptionsTable> {
  $$PrescriptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get doctorName => $composableBuilder(
      column: $table.doctorName, builder: (column) => column);

  GeneratedColumn<String> get clinicName => $composableBuilder(
      column: $table.clinicName, builder: (column) => column);

  GeneratedColumn<String> get prescriptionDate => $composableBuilder(
      column: $table.prescriptionDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> prescriptionMedicinesRefs<T extends Object>(
      Expression<T> Function($$PrescriptionMedicinesTableAnnotationComposer a)
          f) {
    final $$PrescriptionMedicinesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.prescriptionMedicines,
            getReferencedColumn: (t) => t.prescriptionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PrescriptionMedicinesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.prescriptionMedicines,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> medicineSchedulesRefs<T extends Object>(
      Expression<T> Function($$MedicineSchedulesTableAnnotationComposer a) f) {
    final $$MedicineSchedulesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.medicineSchedules,
            getReferencedColumn: (t) => t.prescriptionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MedicineSchedulesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.medicineSchedules,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> doseEventsRefs<T extends Object>(
      Expression<T> Function($$DoseEventsTableAnnotationComposer a) f) {
    final $$DoseEventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.doseEvents,
        getReferencedColumn: (t) => t.prescriptionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DoseEventsTableAnnotationComposer(
              $db: $db,
              $table: $db.doseEvents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PrescriptionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PrescriptionsTable,
    PrescriptionEntity,
    $$PrescriptionsTableFilterComposer,
    $$PrescriptionsTableOrderingComposer,
    $$PrescriptionsTableAnnotationComposer,
    $$PrescriptionsTableCreateCompanionBuilder,
    $$PrescriptionsTableUpdateCompanionBuilder,
    (PrescriptionEntity, $$PrescriptionsTableReferences),
    PrescriptionEntity,
    PrefetchHooks Function(
        {bool prescriptionMedicinesRefs,
        bool medicineSchedulesRefs,
        bool doseEventsRefs})> {
  $$PrescriptionsTableTableManager(_$AppDatabase db, $PrescriptionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrescriptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrescriptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrescriptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<String?> doctorName = const Value.absent(),
            Value<String?> clinicName = const Value.absent(),
            Value<String> prescriptionDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PrescriptionsCompanion(
            id: id,
            patientId: patientId,
            doctorName: doctorName,
            clinicName: clinicName,
            prescriptionDate: prescriptionDate,
            notes: notes,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String patientId,
            Value<String?> doctorName = const Value.absent(),
            Value<String?> clinicName = const Value.absent(),
            required String prescriptionDate,
            Value<String?> notes = const Value.absent(),
            required String status,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PrescriptionsCompanion.insert(
            id: id,
            patientId: patientId,
            doctorName: doctorName,
            clinicName: clinicName,
            prescriptionDate: prescriptionDate,
            notes: notes,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PrescriptionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {prescriptionMedicinesRefs = false,
              medicineSchedulesRefs = false,
              doseEventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (prescriptionMedicinesRefs) db.prescriptionMedicines,
                if (medicineSchedulesRefs) db.medicineSchedules,
                if (doseEventsRefs) db.doseEvents
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (prescriptionMedicinesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PrescriptionsTableReferences
                            ._prescriptionMedicinesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PrescriptionsTableReferences(db, table, p0)
                                .prescriptionMedicinesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.prescriptionId == item.id),
                        typedResults: items),
                  if (medicineSchedulesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PrescriptionsTableReferences
                            ._medicineSchedulesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PrescriptionsTableReferences(db, table, p0)
                                .medicineSchedulesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.prescriptionId == item.id),
                        typedResults: items),
                  if (doseEventsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PrescriptionsTableReferences
                            ._doseEventsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PrescriptionsTableReferences(db, table, p0)
                                .doseEventsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.prescriptionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PrescriptionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PrescriptionsTable,
    PrescriptionEntity,
    $$PrescriptionsTableFilterComposer,
    $$PrescriptionsTableOrderingComposer,
    $$PrescriptionsTableAnnotationComposer,
    $$PrescriptionsTableCreateCompanionBuilder,
    $$PrescriptionsTableUpdateCompanionBuilder,
    (PrescriptionEntity, $$PrescriptionsTableReferences),
    PrescriptionEntity,
    PrefetchHooks Function(
        {bool prescriptionMedicinesRefs,
        bool medicineSchedulesRefs,
        bool doseEventsRefs})>;
typedef $$PrescriptionMedicinesTableCreateCompanionBuilder
    = PrescriptionMedicinesCompanion Function({
  required String id,
  required String prescriptionId,
  required String medicineName,
  required String dosage,
  required String frequency,
  Value<int?> durationDays,
  Value<String?> foodTiming,
  Value<String?> instructions,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$PrescriptionMedicinesTableUpdateCompanionBuilder
    = PrescriptionMedicinesCompanion Function({
  Value<String> id,
  Value<String> prescriptionId,
  Value<String> medicineName,
  Value<String> dosage,
  Value<String> frequency,
  Value<int?> durationDays,
  Value<String?> foodTiming,
  Value<String?> instructions,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$PrescriptionMedicinesTableReferences extends BaseReferences<
    _$AppDatabase, $PrescriptionMedicinesTable, PrescriptionMedicineEntity> {
  $$PrescriptionMedicinesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PrescriptionsTable _prescriptionIdTable(_$AppDatabase db) =>
      db.prescriptions.createAlias($_aliasNameGenerator(
          db.prescriptionMedicines.prescriptionId, db.prescriptions.id));

  $$PrescriptionsTableProcessedTableManager? get prescriptionId {
    if ($_item.prescriptionId == null) return null;
    final manager = $$PrescriptionsTableTableManager($_db, $_db.prescriptions)
        .filter((f) => f.id($_item.prescriptionId!));
    final item = $_typedResult.readTableOrNull(_prescriptionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MedicineSchedulesTable,
      List<MedicineScheduleEntity>> _medicineSchedulesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.medicineSchedules,
          aliasName: $_aliasNameGenerator(db.prescriptionMedicines.id,
              db.medicineSchedules.prescriptionMedicineId));

  $$MedicineSchedulesTableProcessedTableManager get medicineSchedulesRefs {
    final manager =
        $$MedicineSchedulesTableTableManager($_db, $_db.medicineSchedules)
            .filter((f) => f.prescriptionMedicineId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_medicineSchedulesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DoseEventsTable, List<DoseEventEntity>>
      _doseEventsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.doseEvents,
              aliasName: $_aliasNameGenerator(db.prescriptionMedicines.id,
                  db.doseEvents.prescriptionMedicineId));

  $$DoseEventsTableProcessedTableManager get doseEventsRefs {
    final manager = $$DoseEventsTableTableManager($_db, $_db.doseEvents)
        .filter((f) => f.prescriptionMedicineId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_doseEventsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PrescriptionMedicinesTableFilterComposer
    extends Composer<_$AppDatabase, $PrescriptionMedicinesTable> {
  $$PrescriptionMedicinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicineName => $composableBuilder(
      column: $table.medicineName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationDays => $composableBuilder(
      column: $table.durationDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodTiming => $composableBuilder(
      column: $table.foodTiming, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PrescriptionsTableFilterComposer get prescriptionId {
    final $$PrescriptionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.prescriptionId,
        referencedTable: $db.prescriptions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrescriptionsTableFilterComposer(
              $db: $db,
              $table: $db.prescriptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> medicineSchedulesRefs(
      Expression<bool> Function($$MedicineSchedulesTableFilterComposer f) f) {
    final $$MedicineSchedulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medicineSchedules,
        getReferencedColumn: (t) => t.prescriptionMedicineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicineSchedulesTableFilterComposer(
              $db: $db,
              $table: $db.medicineSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> doseEventsRefs(
      Expression<bool> Function($$DoseEventsTableFilterComposer f) f) {
    final $$DoseEventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.doseEvents,
        getReferencedColumn: (t) => t.prescriptionMedicineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DoseEventsTableFilterComposer(
              $db: $db,
              $table: $db.doseEvents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PrescriptionMedicinesTableOrderingComposer
    extends Composer<_$AppDatabase, $PrescriptionMedicinesTable> {
  $$PrescriptionMedicinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicineName => $composableBuilder(
      column: $table.medicineName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationDays => $composableBuilder(
      column: $table.durationDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodTiming => $composableBuilder(
      column: $table.foodTiming, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instructions => $composableBuilder(
      column: $table.instructions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PrescriptionsTableOrderingComposer get prescriptionId {
    final $$PrescriptionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.prescriptionId,
        referencedTable: $db.prescriptions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrescriptionsTableOrderingComposer(
              $db: $db,
              $table: $db.prescriptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PrescriptionMedicinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrescriptionMedicinesTable> {
  $$PrescriptionMedicinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medicineName => $composableBuilder(
      column: $table.medicineName, builder: (column) => column);

  GeneratedColumn<String> get dosage =>
      $composableBuilder(column: $table.dosage, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get durationDays => $composableBuilder(
      column: $table.durationDays, builder: (column) => column);

  GeneratedColumn<String> get foodTiming => $composableBuilder(
      column: $table.foodTiming, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PrescriptionsTableAnnotationComposer get prescriptionId {
    final $$PrescriptionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.prescriptionId,
        referencedTable: $db.prescriptions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrescriptionsTableAnnotationComposer(
              $db: $db,
              $table: $db.prescriptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> medicineSchedulesRefs<T extends Object>(
      Expression<T> Function($$MedicineSchedulesTableAnnotationComposer a) f) {
    final $$MedicineSchedulesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.medicineSchedules,
            getReferencedColumn: (t) => t.prescriptionMedicineId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MedicineSchedulesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.medicineSchedules,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> doseEventsRefs<T extends Object>(
      Expression<T> Function($$DoseEventsTableAnnotationComposer a) f) {
    final $$DoseEventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.doseEvents,
        getReferencedColumn: (t) => t.prescriptionMedicineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DoseEventsTableAnnotationComposer(
              $db: $db,
              $table: $db.doseEvents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PrescriptionMedicinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PrescriptionMedicinesTable,
    PrescriptionMedicineEntity,
    $$PrescriptionMedicinesTableFilterComposer,
    $$PrescriptionMedicinesTableOrderingComposer,
    $$PrescriptionMedicinesTableAnnotationComposer,
    $$PrescriptionMedicinesTableCreateCompanionBuilder,
    $$PrescriptionMedicinesTableUpdateCompanionBuilder,
    (PrescriptionMedicineEntity, $$PrescriptionMedicinesTableReferences),
    PrescriptionMedicineEntity,
    PrefetchHooks Function(
        {bool prescriptionId,
        bool medicineSchedulesRefs,
        bool doseEventsRefs})> {
  $$PrescriptionMedicinesTableTableManager(
      _$AppDatabase db, $PrescriptionMedicinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrescriptionMedicinesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$PrescriptionMedicinesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrescriptionMedicinesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> prescriptionId = const Value.absent(),
            Value<String> medicineName = const Value.absent(),
            Value<String> dosage = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<int?> durationDays = const Value.absent(),
            Value<String?> foodTiming = const Value.absent(),
            Value<String?> instructions = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PrescriptionMedicinesCompanion(
            id: id,
            prescriptionId: prescriptionId,
            medicineName: medicineName,
            dosage: dosage,
            frequency: frequency,
            durationDays: durationDays,
            foodTiming: foodTiming,
            instructions: instructions,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String prescriptionId,
            required String medicineName,
            required String dosage,
            required String frequency,
            Value<int?> durationDays = const Value.absent(),
            Value<String?> foodTiming = const Value.absent(),
            Value<String?> instructions = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PrescriptionMedicinesCompanion.insert(
            id: id,
            prescriptionId: prescriptionId,
            medicineName: medicineName,
            dosage: dosage,
            frequency: frequency,
            durationDays: durationDays,
            foodTiming: foodTiming,
            instructions: instructions,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PrescriptionMedicinesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {prescriptionId = false,
              medicineSchedulesRefs = false,
              doseEventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (medicineSchedulesRefs) db.medicineSchedules,
                if (doseEventsRefs) db.doseEvents
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (prescriptionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.prescriptionId,
                    referencedTable: $$PrescriptionMedicinesTableReferences
                        ._prescriptionIdTable(db),
                    referencedColumn: $$PrescriptionMedicinesTableReferences
                        ._prescriptionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (medicineSchedulesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PrescriptionMedicinesTableReferences
                            ._medicineSchedulesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PrescriptionMedicinesTableReferences(
                                    db, table, p0)
                                .medicineSchedulesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.prescriptionMedicineId == item.id),
                        typedResults: items),
                  if (doseEventsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PrescriptionMedicinesTableReferences
                            ._doseEventsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PrescriptionMedicinesTableReferences(
                                    db, table, p0)
                                .doseEventsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.prescriptionMedicineId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PrescriptionMedicinesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $PrescriptionMedicinesTable,
        PrescriptionMedicineEntity,
        $$PrescriptionMedicinesTableFilterComposer,
        $$PrescriptionMedicinesTableOrderingComposer,
        $$PrescriptionMedicinesTableAnnotationComposer,
        $$PrescriptionMedicinesTableCreateCompanionBuilder,
        $$PrescriptionMedicinesTableUpdateCompanionBuilder,
        (PrescriptionMedicineEntity, $$PrescriptionMedicinesTableReferences),
        PrescriptionMedicineEntity,
        PrefetchHooks Function(
            {bool prescriptionId,
            bool medicineSchedulesRefs,
            bool doseEventsRefs})>;
typedef $$MedicineSchedulesTableCreateCompanionBuilder
    = MedicineSchedulesCompanion Function({
  required String id,
  required String prescriptionId,
  required String prescriptionMedicineId,
  required String medicineName,
  required String dosage,
  required String frequency,
  Value<int> timesPerDay,
  required DateTime startDate,
  Value<DateTime?> endDate,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$MedicineSchedulesTableUpdateCompanionBuilder
    = MedicineSchedulesCompanion Function({
  Value<String> id,
  Value<String> prescriptionId,
  Value<String> prescriptionMedicineId,
  Value<String> medicineName,
  Value<String> dosage,
  Value<String> frequency,
  Value<int> timesPerDay,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$MedicineSchedulesTableReferences extends BaseReferences<
    _$AppDatabase, $MedicineSchedulesTable, MedicineScheduleEntity> {
  $$MedicineSchedulesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PrescriptionsTable _prescriptionIdTable(_$AppDatabase db) =>
      db.prescriptions.createAlias($_aliasNameGenerator(
          db.medicineSchedules.prescriptionId, db.prescriptions.id));

  $$PrescriptionsTableProcessedTableManager? get prescriptionId {
    if ($_item.prescriptionId == null) return null;
    final manager = $$PrescriptionsTableTableManager($_db, $_db.prescriptions)
        .filter((f) => f.id($_item.prescriptionId!));
    final item = $_typedResult.readTableOrNull(_prescriptionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PrescriptionMedicinesTable _prescriptionMedicineIdTable(
          _$AppDatabase db) =>
      db.prescriptionMedicines.createAlias($_aliasNameGenerator(
          db.medicineSchedules.prescriptionMedicineId,
          db.prescriptionMedicines.id));

  $$PrescriptionMedicinesTableProcessedTableManager?
      get prescriptionMedicineId {
    if ($_item.prescriptionMedicineId == null) return null;
    final manager = $$PrescriptionMedicinesTableTableManager(
            $_db, $_db.prescriptionMedicines)
        .filter((f) => f.id($_item.prescriptionMedicineId!));
    final item =
        $_typedResult.readTableOrNull(_prescriptionMedicineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$DoseEventsTable, List<DoseEventEntity>>
      _doseEventsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.doseEvents,
              aliasName: $_aliasNameGenerator(
                  db.medicineSchedules.id, db.doseEvents.scheduleId));

  $$DoseEventsTableProcessedTableManager get doseEventsRefs {
    final manager = $$DoseEventsTableTableManager($_db, $_db.doseEvents)
        .filter((f) => f.scheduleId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_doseEventsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MedicineSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $MedicineSchedulesTable> {
  $$MedicineSchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicineName => $composableBuilder(
      column: $table.medicineName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timesPerDay => $composableBuilder(
      column: $table.timesPerDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PrescriptionsTableFilterComposer get prescriptionId {
    final $$PrescriptionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.prescriptionId,
        referencedTable: $db.prescriptions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrescriptionsTableFilterComposer(
              $db: $db,
              $table: $db.prescriptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PrescriptionMedicinesTableFilterComposer get prescriptionMedicineId {
    final $$PrescriptionMedicinesTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.prescriptionMedicineId,
            referencedTable: $db.prescriptionMedicines,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PrescriptionMedicinesTableFilterComposer(
                  $db: $db,
                  $table: $db.prescriptionMedicines,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<bool> doseEventsRefs(
      Expression<bool> Function($$DoseEventsTableFilterComposer f) f) {
    final $$DoseEventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.doseEvents,
        getReferencedColumn: (t) => t.scheduleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DoseEventsTableFilterComposer(
              $db: $db,
              $table: $db.doseEvents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MedicineSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicineSchedulesTable> {
  $$MedicineSchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicineName => $composableBuilder(
      column: $table.medicineName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timesPerDay => $composableBuilder(
      column: $table.timesPerDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PrescriptionsTableOrderingComposer get prescriptionId {
    final $$PrescriptionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.prescriptionId,
        referencedTable: $db.prescriptions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrescriptionsTableOrderingComposer(
              $db: $db,
              $table: $db.prescriptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PrescriptionMedicinesTableOrderingComposer get prescriptionMedicineId {
    final $$PrescriptionMedicinesTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.prescriptionMedicineId,
            referencedTable: $db.prescriptionMedicines,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PrescriptionMedicinesTableOrderingComposer(
                  $db: $db,
                  $table: $db.prescriptionMedicines,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$MedicineSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicineSchedulesTable> {
  $$MedicineSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medicineName => $composableBuilder(
      column: $table.medicineName, builder: (column) => column);

  GeneratedColumn<String> get dosage =>
      $composableBuilder(column: $table.dosage, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get timesPerDay => $composableBuilder(
      column: $table.timesPerDay, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PrescriptionsTableAnnotationComposer get prescriptionId {
    final $$PrescriptionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.prescriptionId,
        referencedTable: $db.prescriptions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrescriptionsTableAnnotationComposer(
              $db: $db,
              $table: $db.prescriptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PrescriptionMedicinesTableAnnotationComposer get prescriptionMedicineId {
    final $$PrescriptionMedicinesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.prescriptionMedicineId,
            referencedTable: $db.prescriptionMedicines,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PrescriptionMedicinesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.prescriptionMedicines,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<T> doseEventsRefs<T extends Object>(
      Expression<T> Function($$DoseEventsTableAnnotationComposer a) f) {
    final $$DoseEventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.doseEvents,
        getReferencedColumn: (t) => t.scheduleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DoseEventsTableAnnotationComposer(
              $db: $db,
              $table: $db.doseEvents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MedicineSchedulesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicineSchedulesTable,
    MedicineScheduleEntity,
    $$MedicineSchedulesTableFilterComposer,
    $$MedicineSchedulesTableOrderingComposer,
    $$MedicineSchedulesTableAnnotationComposer,
    $$MedicineSchedulesTableCreateCompanionBuilder,
    $$MedicineSchedulesTableUpdateCompanionBuilder,
    (MedicineScheduleEntity, $$MedicineSchedulesTableReferences),
    MedicineScheduleEntity,
    PrefetchHooks Function(
        {bool prescriptionId,
        bool prescriptionMedicineId,
        bool doseEventsRefs})> {
  $$MedicineSchedulesTableTableManager(
      _$AppDatabase db, $MedicineSchedulesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicineSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicineSchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicineSchedulesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> prescriptionId = const Value.absent(),
            Value<String> prescriptionMedicineId = const Value.absent(),
            Value<String> medicineName = const Value.absent(),
            Value<String> dosage = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<int> timesPerDay = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicineSchedulesCompanion(
            id: id,
            prescriptionId: prescriptionId,
            prescriptionMedicineId: prescriptionMedicineId,
            medicineName: medicineName,
            dosage: dosage,
            frequency: frequency,
            timesPerDay: timesPerDay,
            startDate: startDate,
            endDate: endDate,
            isActive: isActive,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String prescriptionId,
            required String prescriptionMedicineId,
            required String medicineName,
            required String dosage,
            required String frequency,
            Value<int> timesPerDay = const Value.absent(),
            required DateTime startDate,
            Value<DateTime?> endDate = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicineSchedulesCompanion.insert(
            id: id,
            prescriptionId: prescriptionId,
            prescriptionMedicineId: prescriptionMedicineId,
            medicineName: medicineName,
            dosage: dosage,
            frequency: frequency,
            timesPerDay: timesPerDay,
            startDate: startDate,
            endDate: endDate,
            isActive: isActive,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MedicineSchedulesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {prescriptionId = false,
              prescriptionMedicineId = false,
              doseEventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (doseEventsRefs) db.doseEvents],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (prescriptionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.prescriptionId,
                    referencedTable: $$MedicineSchedulesTableReferences
                        ._prescriptionIdTable(db),
                    referencedColumn: $$MedicineSchedulesTableReferences
                        ._prescriptionIdTable(db)
                        .id,
                  ) as T;
                }
                if (prescriptionMedicineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.prescriptionMedicineId,
                    referencedTable: $$MedicineSchedulesTableReferences
                        ._prescriptionMedicineIdTable(db),
                    referencedColumn: $$MedicineSchedulesTableReferences
                        ._prescriptionMedicineIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (doseEventsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$MedicineSchedulesTableReferences
                            ._doseEventsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MedicineSchedulesTableReferences(db, table, p0)
                                .doseEventsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.scheduleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MedicineSchedulesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MedicineSchedulesTable,
    MedicineScheduleEntity,
    $$MedicineSchedulesTableFilterComposer,
    $$MedicineSchedulesTableOrderingComposer,
    $$MedicineSchedulesTableAnnotationComposer,
    $$MedicineSchedulesTableCreateCompanionBuilder,
    $$MedicineSchedulesTableUpdateCompanionBuilder,
    (MedicineScheduleEntity, $$MedicineSchedulesTableReferences),
    MedicineScheduleEntity,
    PrefetchHooks Function(
        {bool prescriptionId,
        bool prescriptionMedicineId,
        bool doseEventsRefs})>;
typedef $$DoseEventsTableCreateCompanionBuilder = DoseEventsCompanion Function({
  required String id,
  required String prescriptionId,
  required String prescriptionMedicineId,
  Value<String?> scheduleId,
  required String medicineName,
  required String dosage,
  required DateTime scheduledAt,
  required String status,
  Value<String?> foodTiming,
  Value<DateTime?> takenAt,
  Value<DateTime?> skippedAt,
  Value<String?> skipReason,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$DoseEventsTableUpdateCompanionBuilder = DoseEventsCompanion Function({
  Value<String> id,
  Value<String> prescriptionId,
  Value<String> prescriptionMedicineId,
  Value<String?> scheduleId,
  Value<String> medicineName,
  Value<String> dosage,
  Value<DateTime> scheduledAt,
  Value<String> status,
  Value<String?> foodTiming,
  Value<DateTime?> takenAt,
  Value<DateTime?> skippedAt,
  Value<String?> skipReason,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$DoseEventsTableReferences
    extends BaseReferences<_$AppDatabase, $DoseEventsTable, DoseEventEntity> {
  $$DoseEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PrescriptionsTable _prescriptionIdTable(_$AppDatabase db) =>
      db.prescriptions.createAlias($_aliasNameGenerator(
          db.doseEvents.prescriptionId, db.prescriptions.id));

  $$PrescriptionsTableProcessedTableManager? get prescriptionId {
    if ($_item.prescriptionId == null) return null;
    final manager = $$PrescriptionsTableTableManager($_db, $_db.prescriptions)
        .filter((f) => f.id($_item.prescriptionId!));
    final item = $_typedResult.readTableOrNull(_prescriptionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PrescriptionMedicinesTable _prescriptionMedicineIdTable(
          _$AppDatabase db) =>
      db.prescriptionMedicines.createAlias($_aliasNameGenerator(
          db.doseEvents.prescriptionMedicineId, db.prescriptionMedicines.id));

  $$PrescriptionMedicinesTableProcessedTableManager?
      get prescriptionMedicineId {
    if ($_item.prescriptionMedicineId == null) return null;
    final manager = $$PrescriptionMedicinesTableTableManager(
            $_db, $_db.prescriptionMedicines)
        .filter((f) => f.id($_item.prescriptionMedicineId!));
    final item =
        $_typedResult.readTableOrNull(_prescriptionMedicineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MedicineSchedulesTable _scheduleIdTable(_$AppDatabase db) =>
      db.medicineSchedules.createAlias($_aliasNameGenerator(
          db.doseEvents.scheduleId, db.medicineSchedules.id));

  $$MedicineSchedulesTableProcessedTableManager? get scheduleId {
    if ($_item.scheduleId == null) return null;
    final manager =
        $$MedicineSchedulesTableTableManager($_db, $_db.medicineSchedules)
            .filter((f) => f.id($_item.scheduleId!));
    final item = $_typedResult.readTableOrNull(_scheduleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DoseEventsTableFilterComposer
    extends Composer<_$AppDatabase, $DoseEventsTable> {
  $$DoseEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicineName => $composableBuilder(
      column: $table.medicineName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
      column: $table.scheduledAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodTiming => $composableBuilder(
      column: $table.foodTiming, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
      column: $table.takenAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get skippedAt => $composableBuilder(
      column: $table.skippedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get skipReason => $composableBuilder(
      column: $table.skipReason, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PrescriptionsTableFilterComposer get prescriptionId {
    final $$PrescriptionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.prescriptionId,
        referencedTable: $db.prescriptions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrescriptionsTableFilterComposer(
              $db: $db,
              $table: $db.prescriptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PrescriptionMedicinesTableFilterComposer get prescriptionMedicineId {
    final $$PrescriptionMedicinesTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.prescriptionMedicineId,
            referencedTable: $db.prescriptionMedicines,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PrescriptionMedicinesTableFilterComposer(
                  $db: $db,
                  $table: $db.prescriptionMedicines,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$MedicineSchedulesTableFilterComposer get scheduleId {
    final $$MedicineSchedulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.scheduleId,
        referencedTable: $db.medicineSchedules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicineSchedulesTableFilterComposer(
              $db: $db,
              $table: $db.medicineSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DoseEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $DoseEventsTable> {
  $$DoseEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicineName => $composableBuilder(
      column: $table.medicineName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosage => $composableBuilder(
      column: $table.dosage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
      column: $table.scheduledAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodTiming => $composableBuilder(
      column: $table.foodTiming, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
      column: $table.takenAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get skippedAt => $composableBuilder(
      column: $table.skippedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get skipReason => $composableBuilder(
      column: $table.skipReason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PrescriptionsTableOrderingComposer get prescriptionId {
    final $$PrescriptionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.prescriptionId,
        referencedTable: $db.prescriptions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrescriptionsTableOrderingComposer(
              $db: $db,
              $table: $db.prescriptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PrescriptionMedicinesTableOrderingComposer get prescriptionMedicineId {
    final $$PrescriptionMedicinesTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.prescriptionMedicineId,
            referencedTable: $db.prescriptionMedicines,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PrescriptionMedicinesTableOrderingComposer(
                  $db: $db,
                  $table: $db.prescriptionMedicines,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$MedicineSchedulesTableOrderingComposer get scheduleId {
    final $$MedicineSchedulesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.scheduleId,
        referencedTable: $db.medicineSchedules,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicineSchedulesTableOrderingComposer(
              $db: $db,
              $table: $db.medicineSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DoseEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DoseEventsTable> {
  $$DoseEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medicineName => $composableBuilder(
      column: $table.medicineName, builder: (column) => column);

  GeneratedColumn<String> get dosage =>
      $composableBuilder(column: $table.dosage, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
      column: $table.scheduledAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get foodTiming => $composableBuilder(
      column: $table.foodTiming, builder: (column) => column);

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  GeneratedColumn<DateTime> get skippedAt =>
      $composableBuilder(column: $table.skippedAt, builder: (column) => column);

  GeneratedColumn<String> get skipReason => $composableBuilder(
      column: $table.skipReason, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PrescriptionsTableAnnotationComposer get prescriptionId {
    final $$PrescriptionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.prescriptionId,
        referencedTable: $db.prescriptions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrescriptionsTableAnnotationComposer(
              $db: $db,
              $table: $db.prescriptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PrescriptionMedicinesTableAnnotationComposer get prescriptionMedicineId {
    final $$PrescriptionMedicinesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.prescriptionMedicineId,
            referencedTable: $db.prescriptionMedicines,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PrescriptionMedicinesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.prescriptionMedicines,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$MedicineSchedulesTableAnnotationComposer get scheduleId {
    final $$MedicineSchedulesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.scheduleId,
            referencedTable: $db.medicineSchedules,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$MedicineSchedulesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.medicineSchedules,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$DoseEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DoseEventsTable,
    DoseEventEntity,
    $$DoseEventsTableFilterComposer,
    $$DoseEventsTableOrderingComposer,
    $$DoseEventsTableAnnotationComposer,
    $$DoseEventsTableCreateCompanionBuilder,
    $$DoseEventsTableUpdateCompanionBuilder,
    (DoseEventEntity, $$DoseEventsTableReferences),
    DoseEventEntity,
    PrefetchHooks Function(
        {bool prescriptionId, bool prescriptionMedicineId, bool scheduleId})> {
  $$DoseEventsTableTableManager(_$AppDatabase db, $DoseEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DoseEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DoseEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DoseEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> prescriptionId = const Value.absent(),
            Value<String> prescriptionMedicineId = const Value.absent(),
            Value<String?> scheduleId = const Value.absent(),
            Value<String> medicineName = const Value.absent(),
            Value<String> dosage = const Value.absent(),
            Value<DateTime> scheduledAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> foodTiming = const Value.absent(),
            Value<DateTime?> takenAt = const Value.absent(),
            Value<DateTime?> skippedAt = const Value.absent(),
            Value<String?> skipReason = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DoseEventsCompanion(
            id: id,
            prescriptionId: prescriptionId,
            prescriptionMedicineId: prescriptionMedicineId,
            scheduleId: scheduleId,
            medicineName: medicineName,
            dosage: dosage,
            scheduledAt: scheduledAt,
            status: status,
            foodTiming: foodTiming,
            takenAt: takenAt,
            skippedAt: skippedAt,
            skipReason: skipReason,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String prescriptionId,
            required String prescriptionMedicineId,
            Value<String?> scheduleId = const Value.absent(),
            required String medicineName,
            required String dosage,
            required DateTime scheduledAt,
            required String status,
            Value<String?> foodTiming = const Value.absent(),
            Value<DateTime?> takenAt = const Value.absent(),
            Value<DateTime?> skippedAt = const Value.absent(),
            Value<String?> skipReason = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DoseEventsCompanion.insert(
            id: id,
            prescriptionId: prescriptionId,
            prescriptionMedicineId: prescriptionMedicineId,
            scheduleId: scheduleId,
            medicineName: medicineName,
            dosage: dosage,
            scheduledAt: scheduledAt,
            status: status,
            foodTiming: foodTiming,
            takenAt: takenAt,
            skippedAt: skippedAt,
            skipReason: skipReason,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DoseEventsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {prescriptionId = false,
              prescriptionMedicineId = false,
              scheduleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (prescriptionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.prescriptionId,
                    referencedTable:
                        $$DoseEventsTableReferences._prescriptionIdTable(db),
                    referencedColumn:
                        $$DoseEventsTableReferences._prescriptionIdTable(db).id,
                  ) as T;
                }
                if (prescriptionMedicineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.prescriptionMedicineId,
                    referencedTable: $$DoseEventsTableReferences
                        ._prescriptionMedicineIdTable(db),
                    referencedColumn: $$DoseEventsTableReferences
                        ._prescriptionMedicineIdTable(db)
                        .id,
                  ) as T;
                }
                if (scheduleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.scheduleId,
                    referencedTable:
                        $$DoseEventsTableReferences._scheduleIdTable(db),
                    referencedColumn:
                        $$DoseEventsTableReferences._scheduleIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DoseEventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DoseEventsTable,
    DoseEventEntity,
    $$DoseEventsTableFilterComposer,
    $$DoseEventsTableOrderingComposer,
    $$DoseEventsTableAnnotationComposer,
    $$DoseEventsTableCreateCompanionBuilder,
    $$DoseEventsTableUpdateCompanionBuilder,
    (DoseEventEntity, $$DoseEventsTableReferences),
    DoseEventEntity,
    PrefetchHooks Function(
        {bool prescriptionId, bool prescriptionMedicineId, bool scheduleId})>;
typedef $$AppointmentsTableCreateCompanionBuilder = AppointmentsCompanion
    Function({
  required String id,
  required String patientId,
  required String doctorName,
  Value<String?> clinicName,
  required DateTime appointmentDatetime,
  Value<String?> timezone,
  Value<String?> notes,
  required String status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$AppointmentsTableUpdateCompanionBuilder = AppointmentsCompanion
    Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> doctorName,
  Value<String?> clinicName,
  Value<DateTime> appointmentDatetime,
  Value<String?> timezone,
  Value<String?> notes,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$AppointmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get doctorName => $composableBuilder(
      column: $table.doctorName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clinicName => $composableBuilder(
      column: $table.clinicName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get appointmentDatetime => $composableBuilder(
      column: $table.appointmentDatetime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AppointmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get doctorName => $composableBuilder(
      column: $table.doctorName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clinicName => $composableBuilder(
      column: $table.clinicName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get appointmentDatetime => $composableBuilder(
      column: $table.appointmentDatetime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AppointmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get doctorName => $composableBuilder(
      column: $table.doctorName, builder: (column) => column);

  GeneratedColumn<String> get clinicName => $composableBuilder(
      column: $table.clinicName, builder: (column) => column);

  GeneratedColumn<DateTime> get appointmentDatetime => $composableBuilder(
      column: $table.appointmentDatetime, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppointmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppointmentsTable,
    AppointmentEntity,
    $$AppointmentsTableFilterComposer,
    $$AppointmentsTableOrderingComposer,
    $$AppointmentsTableAnnotationComposer,
    $$AppointmentsTableCreateCompanionBuilder,
    $$AppointmentsTableUpdateCompanionBuilder,
    (
      AppointmentEntity,
      BaseReferences<_$AppDatabase, $AppointmentsTable, AppointmentEntity>
    ),
    AppointmentEntity,
    PrefetchHooks Function()> {
  $$AppointmentsTableTableManager(_$AppDatabase db, $AppointmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppointmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppointmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppointmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<String> doctorName = const Value.absent(),
            Value<String?> clinicName = const Value.absent(),
            Value<DateTime> appointmentDatetime = const Value.absent(),
            Value<String?> timezone = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppointmentsCompanion(
            id: id,
            patientId: patientId,
            doctorName: doctorName,
            clinicName: clinicName,
            appointmentDatetime: appointmentDatetime,
            timezone: timezone,
            notes: notes,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String patientId,
            required String doctorName,
            Value<String?> clinicName = const Value.absent(),
            required DateTime appointmentDatetime,
            Value<String?> timezone = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required String status,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppointmentsCompanion.insert(
            id: id,
            patientId: patientId,
            doctorName: doctorName,
            clinicName: clinicName,
            appointmentDatetime: appointmentDatetime,
            timezone: timezone,
            notes: notes,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppointmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppointmentsTable,
    AppointmentEntity,
    $$AppointmentsTableFilterComposer,
    $$AppointmentsTableOrderingComposer,
    $$AppointmentsTableAnnotationComposer,
    $$AppointmentsTableCreateCompanionBuilder,
    $$AppointmentsTableUpdateCompanionBuilder,
    (
      AppointmentEntity,
      BaseReferences<_$AppDatabase, $AppointmentsTable, AppointmentEntity>
    ),
    AppointmentEntity,
    PrefetchHooks Function()>;
typedef $$AllergiesTableCreateCompanionBuilder = AllergiesCompanion Function({
  required String id,
  Value<String> patientId,
  required String name,
  required String severity,
  Value<String?> reaction,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$AllergiesTableUpdateCompanionBuilder = AllergiesCompanion Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> name,
  Value<String> severity,
  Value<String?> reaction,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$AllergiesTableFilterComposer
    extends Composer<_$AppDatabase, $AllergiesTable> {
  $$AllergiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get severity => $composableBuilder(
      column: $table.severity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reaction => $composableBuilder(
      column: $table.reaction, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$AllergiesTableOrderingComposer
    extends Composer<_$AppDatabase, $AllergiesTable> {
  $$AllergiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get severity => $composableBuilder(
      column: $table.severity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reaction => $composableBuilder(
      column: $table.reaction, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AllergiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AllergiesTable> {
  $$AllergiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<String> get reaction =>
      $composableBuilder(column: $table.reaction, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AllergiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AllergiesTable,
    AllergyEntity,
    $$AllergiesTableFilterComposer,
    $$AllergiesTableOrderingComposer,
    $$AllergiesTableAnnotationComposer,
    $$AllergiesTableCreateCompanionBuilder,
    $$AllergiesTableUpdateCompanionBuilder,
    (
      AllergyEntity,
      BaseReferences<_$AppDatabase, $AllergiesTable, AllergyEntity>
    ),
    AllergyEntity,
    PrefetchHooks Function()> {
  $$AllergiesTableTableManager(_$AppDatabase db, $AllergiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AllergiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AllergiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AllergiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> severity = const Value.absent(),
            Value<String?> reaction = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AllergiesCompanion(
            id: id,
            patientId: patientId,
            name: name,
            severity: severity,
            reaction: reaction,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String> patientId = const Value.absent(),
            required String name,
            required String severity,
            Value<String?> reaction = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AllergiesCompanion.insert(
            id: id,
            patientId: patientId,
            name: name,
            severity: severity,
            reaction: reaction,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AllergiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AllergiesTable,
    AllergyEntity,
    $$AllergiesTableFilterComposer,
    $$AllergiesTableOrderingComposer,
    $$AllergiesTableAnnotationComposer,
    $$AllergiesTableCreateCompanionBuilder,
    $$AllergiesTableUpdateCompanionBuilder,
    (
      AllergyEntity,
      BaseReferences<_$AppDatabase, $AllergiesTable, AllergyEntity>
    ),
    AllergyEntity,
    PrefetchHooks Function()>;
typedef $$FamilyMembersTableCreateCompanionBuilder = FamilyMembersCompanion
    Function({
  required String id,
  Value<String> patientId,
  required String name,
  required String relation,
  Value<String?> dateOfBirth,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$FamilyMembersTableUpdateCompanionBuilder = FamilyMembersCompanion
    Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> name,
  Value<String> relation,
  Value<String?> dateOfBirth,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$FamilyMembersTableFilterComposer
    extends Composer<_$AppDatabase, $FamilyMembersTable> {
  $$FamilyMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relation => $composableBuilder(
      column: $table.relation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$FamilyMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $FamilyMembersTable> {
  $$FamilyMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientId => $composableBuilder(
      column: $table.patientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relation => $composableBuilder(
      column: $table.relation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$FamilyMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $FamilyMembersTable> {
  $$FamilyMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get relation =>
      $composableBuilder(column: $table.relation, builder: (column) => column);

  GeneratedColumn<String> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FamilyMembersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FamilyMembersTable,
    FamilyMemberEntity,
    $$FamilyMembersTableFilterComposer,
    $$FamilyMembersTableOrderingComposer,
    $$FamilyMembersTableAnnotationComposer,
    $$FamilyMembersTableCreateCompanionBuilder,
    $$FamilyMembersTableUpdateCompanionBuilder,
    (
      FamilyMemberEntity,
      BaseReferences<_$AppDatabase, $FamilyMembersTable, FamilyMemberEntity>
    ),
    FamilyMemberEntity,
    PrefetchHooks Function()> {
  $$FamilyMembersTableTableManager(_$AppDatabase db, $FamilyMembersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FamilyMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FamilyMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FamilyMembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> patientId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> relation = const Value.absent(),
            Value<String?> dateOfBirth = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FamilyMembersCompanion(
            id: id,
            patientId: patientId,
            name: name,
            relation: relation,
            dateOfBirth: dateOfBirth,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String> patientId = const Value.absent(),
            required String name,
            required String relation,
            Value<String?> dateOfBirth = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FamilyMembersCompanion.insert(
            id: id,
            patientId: patientId,
            name: name,
            relation: relation,
            dateOfBirth: dateOfBirth,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FamilyMembersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FamilyMembersTable,
    FamilyMemberEntity,
    $$FamilyMembersTableFilterComposer,
    $$FamilyMembersTableOrderingComposer,
    $$FamilyMembersTableAnnotationComposer,
    $$FamilyMembersTableCreateCompanionBuilder,
    $$FamilyMembersTableUpdateCompanionBuilder,
    (
      FamilyMemberEntity,
      BaseReferences<_$AppDatabase, $FamilyMembersTable, FamilyMemberEntity>
    ),
    FamilyMemberEntity,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PatientProfilesTableTableManager get patientProfiles =>
      $$PatientProfilesTableTableManager(_db, _db.patientProfiles);
  $$PrescriptionsTableTableManager get prescriptions =>
      $$PrescriptionsTableTableManager(_db, _db.prescriptions);
  $$PrescriptionMedicinesTableTableManager get prescriptionMedicines =>
      $$PrescriptionMedicinesTableTableManager(_db, _db.prescriptionMedicines);
  $$MedicineSchedulesTableTableManager get medicineSchedules =>
      $$MedicineSchedulesTableTableManager(_db, _db.medicineSchedules);
  $$DoseEventsTableTableManager get doseEvents =>
      $$DoseEventsTableTableManager(_db, _db.doseEvents);
  $$AppointmentsTableTableManager get appointments =>
      $$AppointmentsTableTableManager(_db, _db.appointments);
  $$AllergiesTableTableManager get allergies =>
      $$AllergiesTableTableManager(_db, _db.allergies);
  $$FamilyMembersTableTableManager get familyMembers =>
      $$FamilyMembersTableTableManager(_db, _db.familyMembers);
}
