import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/medicine_models.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class DoseCard extends StatelessWidget {
  final DoseEvent dose;
  final bool isSubmitting;
  final VoidCallback? onTaken;
  final VoidCallback? onSkip;

  const DoseCard({
    super.key,
    required this.dose,
    this.isSubmitting = false,
    this.onTaken,
    this.onSkip,
  });

  String _formatFoodTiming(FoodTiming? timing) {
    switch (timing) {
      case FoodTiming.beforeFood: return 'Before Food';
      case FoodTiming.afterFood: return 'After Food';
      case FoodTiming.withFood: return 'With Food';
      case FoodTiming.noInstruction:
        case null: return 'No specific instruction';
    }
  }

  (Color, Color, String) _getStatusInfo() {
    switch (dose.status) {
      case DoseStatus.taken: return (AppColors.success, AppColors.success.withValues(alpha: 0.1), 'Taken');
      case DoseStatus.skipped: return (AppColors.warningText, AppColors.warningFill, 'Skipped');
      case DoseStatus.missed: return (AppColors.error, AppColors.error.withValues(alpha: 0.1), 'Missed');
      case DoseStatus.scheduled: return (AppColors.primary, AppColors.primary.withValues(alpha: 0.1), 'Upcoming');
      case DoseStatus.unknown: return (AppColors.textSecondary, AppColors.border, 'Unknown');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localTime = dose.scheduledAt.toLocal();
    final timeStr = DateFormat.jm().format(localTime);
    final isScheduled = dose.status == DoseStatus.scheduled;
    final statusInfo = _getStatusInfo();
    final iconColor = statusInfo.$1;
    final badgeBg = statusInfo.$2;
    final statusText = statusInfo.$3;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(16)),
                  child: Icon(Icons.medication, color: iconColor, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(dose.medicineName ?? 'Unknown Medicine', style: AppTypography.h3),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              statusText,
                              style: TextStyle(color: iconColor, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('$timeStr • ${dose.dosage ?? ''}', style: AppTypography.bodyMedium),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.info_outline, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(_formatFoodTiming(dose.foodTiming), style: AppTypography.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isScheduled && (onTaken != null || onSkip != null)) ...[
            const Divider(height: 1, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  if (onSkip != null)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: isSubmitting ? null : onSkip,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: AppColors.border),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Skip', style: AppTypography.button.copyWith(color: AppColors.textPrimary)),
                      ),
                    ),
                  if (onSkip != null && onTaken != null) const SizedBox(width: 12),
                  if (onTaken != null)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isSubmitting ? null : onTaken,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: isSubmitting
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : Text('Mark Taken', style: AppTypography.button.copyWith(color: Colors.white)),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
