import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../providers/prescription_providers.dart';
import '../../data/models/prescription_models.dart';
import '../../data/prescription_repository.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PrescriptionReviewScreen extends ConsumerStatefulWidget {
  final String id;
  const PrescriptionReviewScreen({super.key, required this.id});

  @override
  ConsumerState<PrescriptionReviewScreen> createState() => _PrescriptionReviewScreenState();
}

class _PrescriptionReviewScreenState extends ConsumerState<PrescriptionReviewScreen> {
  bool _isSubmitting = false;

  Future<void> _submitForConfirmation() async {
    setState(() => _isSubmitting = true);
    try {
      final repo = ref.read(prescriptionRepositoryProvider);
      await repo.submitForConfirmation(widget.id);
      if (mounted) {
        context.push('/prescriptions/${widget.id}/safety');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Some medication details are incomplete. Please edit to fix them.'),
            backgroundColor: AppColors.error,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final prescriptionAsync = ref.watch(prescriptionDetailProvider(widget.id));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Prescription Detail'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: prescriptionAsync.when(
        data: (p) {
          final isDraft = p.status == PrescriptionStatus.draft || p.status == PrescriptionStatus.pendingConfirmation;
          DateTime date;
          try {
            date = DateTime.parse(p.prescriptionDate);
          } catch (_) {
            date = DateTime.now();
          }
          final dateStr = DateFormat.yMMMd().format(date);

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      _buildHeaderCard(p, dateStr, isDraft),
                      const SizedBox(height: 32),
                      const Text('Medicines', style: AppTypography.h2),
                      const SizedBox(height: 16),
                      ...p.medicines.map((m) => _buildMedicineCard(m)),
                    ],
                  ),
                ),
                if (isDraft)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isSubmitting ? null : _submitForConfirmation,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: _isSubmitting 
                            ? const CircularProgressIndicator(color: Colors.white) 
                            : const Text('Continue to Safety Check', style: AppTypography.button),
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

  Widget _buildHeaderCard(Prescription p, String dateStr, bool isDraft) {
    Color statusColor = isDraft ? AppColors.warningText : AppColors.success;
    String statusText = isDraft ? 'Draft - Needs Review' : 'Confirmed';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: AppColors.primary, size: 32),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(p.doctorName ?? 'Unknown Provider', style: AppTypography.h1),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.local_hospital, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(p.clinicName ?? 'General Clinic', style: AppTypography.bodyMedium),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(dateStr, style: AppTypography.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineCard(PrescriptionMedicine m) {
    final isUnresolved = m.medicineName == null || m.dosage == null || m.frequency == null || m.durationDays == null;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isUnresolved ? AppColors.warningFill : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isUnresolved ? AppColors.warningBorder : AppColors.border, width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.medication_liquid, color: AppColors.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.medicineName ?? 'UNRESOLVED', style: AppTypography.h3),
                    const SizedBox(height: 4),
                    Text(m.dosage ?? 'UNRESOLVED', style: AppTypography.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMedicineInfoBlock('Frequency', m.frequency ?? 'N/A'),
              _buildMedicineInfoBlock('Duration', m.durationDays != null ? '${m.durationDays} days' : 'N/A'),
              _buildMedicineInfoBlock('Timing', m.foodTiming?.name.replaceAll('Food', ' Food') ?? 'N/A'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMedicineInfoBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.bodySmall),
        const SizedBox(height: 4),
        Text(value, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

