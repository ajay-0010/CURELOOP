import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/prescription_providers.dart';
import '../../data/models/prescription_models.dart';
import '../../data/prescription_repository.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../home/presentation/widgets/dashboard_card.dart';

class OcrReviewScreen extends ConsumerStatefulWidget {
  final OCRExtractionResponse ocrResponse;
  const OcrReviewScreen({super.key, required this.ocrResponse});

  @override
  ConsumerState<OcrReviewScreen> createState() => _OcrReviewScreenState();
}

class _OcrReviewScreenState extends ConsumerState<OcrReviewScreen> {
  bool _isSubmitting = false;

  Future<void> _submitForConfirmation(String prescriptionId) async {
    setState(() => _isSubmitting = true);
    try {
      final repo = ref.read(prescriptionRepositoryProvider);
      await repo.submitForConfirmation(prescriptionId);
      if (mounted) {
        context.push('/prescriptions/$prescriptionId/safety');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please resolve all fields marked in red before continuing.'),
            backgroundColor: AppColors.error,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Color _getConfidenceColor(String? confidence) {
    switch (confidence) {
      case 'HIGH':
        return AppColors.success;
      case 'MEDIUM':
        return AppColors.warningText;
      case 'LOW':
      case 'UNKNOWN':
      default:
        return AppColors.error;
    }
  }

  void _showEditMedicineDialog(PrescriptionMedicine dbMed, CandidateMedicine ocrMed, String prescriptionId) {
    final nameCtrl = TextEditingController(text: dbMed.medicineName);
    final dosageCtrl = TextEditingController(text: dbMed.dosage);
    final freqCtrl = TextEditingController(text: dbMed.frequency);
    final durationCtrl = TextEditingController(text: dbMed.durationDays?.toString() ?? '');
    FoodTiming foodTiming = dbMed.foodTiming ?? FoodTiming.noInstruction;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Medicine', style: AppTypography.h2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Medicine Name')),
              const SizedBox(height: 8),
              TextField(controller: dosageCtrl, decoration: const InputDecoration(labelText: 'Dosage')),
              const SizedBox(height: 8),
              TextField(controller: freqCtrl, decoration: const InputDecoration(labelText: 'Frequency (e.g. 1-0-1)')),
              const SizedBox(height: 8),
              TextField(controller: durationCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Duration (days)')),
              const SizedBox(height: 8),
              DropdownButtonFormField<FoodTiming>(
                // ignore: deprecated_member_use`n                value: foodTiming,
                decoration: const InputDecoration(labelText: 'Food Timing'),
                items: const [
                  DropdownMenuItem(value: FoodTiming.noInstruction, child: Text('No Instruction')),
                  DropdownMenuItem(value: FoodTiming.beforeFood, child: Text('Before Food')),
                  DropdownMenuItem(value: FoodTiming.withFood, child: Text('With Food')),
                  DropdownMenuItem(value: FoodTiming.afterFood, child: Text('After Food')),
                ],
                onChanged: (val) {
                  if (val != null) foodTiming = val;
                },
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (dbMed.id == null) return;
              try {
                final repo = ref.read(prescriptionRepositoryProvider);
                await repo.updatePrescriptionMedicine(prescriptionId, dbMed.id!, {
                  'medicine_name': nameCtrl.text.trim(),
                  'dosage': dosageCtrl.text.trim(),
                  'frequency': freqCtrl.text.trim(),
                  'duration_days': int.tryParse(durationCtrl.text.trim()),
                  'food_timing': foodTiming.name.toUpperCase(),
                });
                ref.invalidate(prescriptionDetailProvider(prescriptionId));
                if (!context.mounted) return;
                Navigator.pop(context);
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating: $e')));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prescriptionId = widget.ocrResponse.prescriptionId;
    final prescriptionAsync = ref.watch(prescriptionDetailProvider(prescriptionId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Review OCR Results'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: prescriptionAsync.when(
        data: (prescription) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.auto_awesome, color: AppColors.primary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Please review the extracted details. Tap any medicine to fix missing or incorrect values.',
                                style: AppTypography.bodyMedium.copyWith(color: AppColors.primaryDark),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text('Medicines Found', style: AppTypography.h2),
                      const SizedBox(height: 16),
                      ...List.generate(prescription.medicines.length, (index) {
                        final dbMed = prescription.medicines[index];
                        final CandidateMedicine? ocrMed = index < widget.ocrResponse.medicines.length 
                            ? widget.ocrResponse.medicines[index] 
                            : null;
                        
                        return DashboardCard(
                          padding: EdgeInsets.zero,
                          onTap: () => _showEditMedicineDialog(dbMed, ocrMed!, prescriptionId),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.medication, color: AppColors.primary),
                                        SizedBox(width: 8),
                                        Text('Medicine ', style: AppTypography.h3),
                                      ],
                                    ),
                                    Icon(Icons.edit, size: 20, color: AppColors.textSecondary),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _buildFieldRow('Name', dbMed.medicineName, ocrMed?.medicineName.confidence),
                                _buildFieldRow('Dosage', dbMed.dosage, ocrMed?.dosage.confidence),
                                _buildFieldRow('Frequency', dbMed.frequency, ocrMed?.frequency.confidence),
                                _buildFieldRow('Duration (days)', dbMed.durationDays?.toString(), ocrMed?.durationDays.confidence),
                                _buildFieldRow('Food Timing', dbMed.foodTiming?.name.replaceAll('Food', ' Food'), ocrMed?.foodTiming.confidence),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : () => _submitForConfirmation(prescriptionId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: _isSubmitting 
                          ? const CircularProgressIndicator(color: Colors.white) 
                          : const Text('Proceed to Safety Check', style: AppTypography.button),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildFieldRow(String label, String? value, String? confidence) {
    final displayValue = (value == null || value.isEmpty) ? 'UNRESOLVED' : value;
    final color = _getConfidenceColor(confidence);
    final isUnresolved = displayValue == 'UNRESOLVED';
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: AppTypography.bodyMedium),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    displayValue,
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isUnresolved ? AppColors.error : AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

