import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/storage/secure_storage.dart';
import '../providers/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(patientProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings & Profile'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: profileAsync.when(
        data: (profile) {
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildProfileHeader(context, profile.name, profile.email ?? ''),
              const SizedBox(height: 32),
              
              Text('Medical Profile', style: AppTypography.h3.copyWith(color: AppColors.textSecondary)),
              const SizedBox(height: 16),
              _buildMenuCard([
                _buildMenuItem(context, Icons.person_outline, 'Personal Information', '/profile/setup'),
                _buildMenuItem(context, Icons.health_and_safety_outlined, 'Allergy Profile', '/profile/allergies'),
                _buildMenuItem(context, Icons.family_restroom, 'Family Members', '/profile/family'),
                _buildMenuItem(context, Icons.medical_information_outlined, 'Emergency Card', '/profile/emergency', isLast: true),
              ]),

              const SizedBox(height: 32),
              Text('App Settings', style: AppTypography.h3.copyWith(color: AppColors.textSecondary)),
              const SizedBox(height: 16),
              _buildMenuCard([
                _buildMenuItem(context, Icons.notifications_outlined, 'Notifications', null, trailing: const Icon(Icons.toggle_on, color: AppColors.primary, size: 36)),
                _buildMenuItem(context, Icons.lock_outline, 'Privacy & Security', null),
                _buildMenuItem(context, Icons.help_outline, 'Help & Support', null, isLast: true),
              ]),

              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ref.read(authTokenStorageProvider.notifier).clearTokens();
                    context.go('/login');
                  },
                  icon: const Icon(Icons.logout, color: AppColors.error),
                  label: Text('Log Out', style: AppTypography.button.copyWith(color: AppColors.error)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, String name, String email) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: const Icon(Icons.person, size: 50, color: AppColors.primary),
        ),
        const SizedBox(height: 16),
        Text(name, style: AppTypography.display),
        const SizedBox(height: 4),
        Text(email, style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => context.push('/profile/setup'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('Edit Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, String? route, {bool isLast = false, Widget? trailing}) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          title: Text(title, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
          trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.textMuted),
          onTap: route != null ? () => context.push(route) : null,
        ),
        if (!isLast) const Divider(height: 1, indent: 64, color: AppColors.border),
      ],
    );
  }
}
