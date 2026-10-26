import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/prescription_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class SafetyCheckScreen extends ConsumerWidget {
  final String id;
  const SafetyCheckScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safetyAsync = ref.watch(safetyCheckProvider(id));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Safety Check'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: safetyAsync.when(
        data: (safety) {
          final hasWarnings = safety.warnings.isNotEmpty;
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 24),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: (hasWarnings ? AppColors.error : AppColors.success).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              hasWarnings ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                              size: 80,
                              color: hasWarnings ? AppColors.error : AppColors.success,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          hasWarnings ? 'Potential Allergy Conflict' : 'All Clear!',
                          style: AppTypography.display.copyWith(
                            color: hasWarnings ? AppColors.error : AppColors.success,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        if (hasWarnings) ...[
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.error.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.info_outline, color: AppColors.error),
                                    const SizedBox(width: 8),
                                    Text('High Severity Alert', style: AppTypography.h3.copyWith(color: AppColors.error)),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                ...safety.warnings.map((w) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('• ', style: TextStyle(color: AppColors.error, fontSize: 18, fontWeight: FontWeight.bold)),
                                      Expanded(child: Text(w, style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary))),
                                    ],
                                  ),
                                )),
                                const SizedBox(height: 16),
                                if (safety.disclaimer != null)
                                  Text(
                                    safety.disclaimer!,
                                    style: AppTypography.bodySmall.copyWith(fontStyle: FontStyle.italic),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Please verify this medication with a qualified healthcare professional before proceeding.',
                            style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ] else ...[
                          const Text(
                            'No known allergies detected in your profile for this medication.',
                            style: AppTypography.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => context.push('/prescriptions/$id/confirm'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hasWarnings ? AppColors.error : AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        hasWarnings ? 'Acknowledge & Proceed' : 'Proceed to Confirmation',
                        style: AppTypography.button,
                      ),
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
}
