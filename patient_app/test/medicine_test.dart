import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cureloop_patient/features/medicines/data/models/medicine_models.dart';
import 'package:cureloop_patient/features/medicines/presentation/widgets/dose_card.dart';

void main() {
  testWidgets('DoseCard renders medicine details correctly', (WidgetTester tester) async {
    final dose = DoseEvent(
      id: '123',
      prescriptionId: 'p1',
      prescriptionMedicineId: 'pm1',
      scheduledAt: DateTime.parse('2026-10-02T10:00:00Z'),
      status: DoseStatus.scheduled,
      medicineName: 'Amoxicillin',
      dosage: '500mg',
      foodTiming: FoodTiming.afterFood,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DoseCard(dose: dose),
        ),
      ),
    );

    // Verify it renders correctly
    expect(find.text('Amoxicillin'), findsOneWidget);
    expect(find.textContaining('500mg'), findsOneWidget);
    expect(find.text('After Food'), findsOneWidget);
    expect(find.text('Upcoming'), findsOneWidget);
  });
}
