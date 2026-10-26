import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/profile_providers.dart';

class EmergencyCardScreen extends ConsumerWidget {
  const EmergencyCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(patientProfileProvider);
    final allergiesAsync = ref.watch(patientAllergiesProvider);

    return Scaffold(
      backgroundColor: AppColors.error,
      appBar: AppBar(
        title: const Text('Emergency Card'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: profileAsync.when(
        data: (profile) {
          return allergiesAsync.when(
            data: (allergies) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 10))
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24),
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                              ),
                              child: Column(
                                children: [
                                  const Icon(Icons.medical_services, color: Colors.white, size: 48),
                                  const SizedBox(height: 16),
                                  Text(profile.name, style: AppTypography.display.copyWith(color: Colors.white)),
                                  const SizedBox(height: 4),
                                  Text('DOB: ${profile.dateOfBirth ?? 'Unknown'}', style: AppTypography.bodyLarge.copyWith(color: Colors.white70)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow(Icons.bloodtype, 'Blood Group', profile.bloodGroup ?? 'Unknown'),
                                  const Divider(height: 32, color: AppColors.border),
                                  _buildInfoRow(Icons.warning, 'Allergies', 
                                      allergies.isEmpty ? 'None known' : allergies.map((a) => a.name).join(', '),
                                      isAlert: allergies.isNotEmpty),
                                  const Divider(height: 32, color: AppColors.border),
                                  Text('Emergency Contact', style: AppTypography.h3.copyWith(color: AppColors.textSecondary)),
                                  const SizedBox(height: 12),
                                  _buildInfoRow(Icons.person, profile.emergencyContactName ?? 'Unknown', profile.emergencyContactPhone ?? ''),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.info_outline, color: Colors.white70, size: 24),
                      const SizedBox(height: 16),
                      const Text(
                        'This information is provided for emergency medical personnel. Please keep it updated.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
            error: (e, st) => Center(child: Text('Error: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String subtitle, {bool isAlert = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: isAlert ? AppColors.error : AppColors.primary, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.bodyMedium.copyWith(color: isAlert ? AppColors.error : AppColors.textSecondary)),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTypography.h3.copyWith(color: isAlert ? AppColors.error : AppColors.textPrimary)),
            ],
          ),
        ),
      ],
    );
  }
}
