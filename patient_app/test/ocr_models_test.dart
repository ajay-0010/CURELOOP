import 'package:flutter_test/flutter_test.dart';
import 'package:cureloop_patient/features/prescriptions/data/models/prescription_models.dart';

void main() {
  group('OCR Models Test', () {
    test('ExtractedField parses correctly', () {
      final json = {'value': 'Amoxicillin', 'confidence': 'HIGH'};
      final field = ExtractedField.fromJson(json);
      expect(field.value, 'Amoxicillin');
      expect(field.confidence, 'HIGH');
    });

    test('OCRExtractionResponse parses correctly', () {
      final json = {
        'prescription_id': '123-abc',
        'document_key': 'file.png',
        'doctor_name': 'Dr. Test',
        'provider_name': 'MockOCRProvider',
        'raw_text': 'raw string',
        'medicines': [
          {
            'medicine_name': {'value': 'Med', 'confidence': 'HIGH'},
            'dosage': {'value': '10mg', 'confidence': 'LOW'},
            'frequency': {'value': '1-0-1', 'confidence': 'HIGH'},
            'duration_days': {'value': '5', 'confidence': 'MEDIUM'},
            'food_timing': {'value': 'AFTER_FOOD', 'confidence': 'UNKNOWN'}
          }
        ]
      };
      final response = OCRExtractionResponse.fromJson(json);
      expect(response.prescriptionId, '123-abc');
      expect(response.medicines.first.medicineName.confidence, 'HIGH');
      expect(response.medicines.first.dosage.confidence, 'LOW');
    });
  });
}
