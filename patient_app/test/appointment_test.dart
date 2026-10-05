import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cureloop_patient/features/appointments/data/models/appointment_models.dart';
import 'package:cureloop_patient/features/appointments/presentation/widgets/appointment_card.dart';

void main() {
  testWidgets('AppointmentCard renders correctly', (WidgetTester tester) async {
    final appt = Appointment(
      id: 'a1',
      patientId: 'p1',
      doctorName: 'Dr. House',
      clinicName: 'Princeton-Plainsboro',
      appointmentDatetime: DateTime.parse('2026-11-01T14:30:00Z'),
      status: AppointmentStatus.scheduled,
      notes: 'Initial consult',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppointmentCard(appointment: appt),
        ),
      ),
    );

    // Verify properties
    expect(find.text('Dr. House'), findsOneWidget);
    expect(find.text('Princeton-Plainsboro'), findsOneWidget);
    expect(find.text('SCHEDULED'), findsOneWidget);
  });
}
