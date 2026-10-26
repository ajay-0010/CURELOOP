import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/profile_providers.dart';
import '../../data/models/profile_models.dart';
import '../../data/profile_repository.dart';

class AllergyProfileScreen extends ConsumerStatefulWidget {
  const AllergyProfileScreen({super.key});

  @override
  ConsumerState<AllergyProfileScreen> createState() => _AllergyProfileScreenState();
}

class _AllergyProfileScreenState extends ConsumerState<AllergyProfileScreen> {
  Future<void> _showAddAllergyDialog() async {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final reactionCtrl = TextEditingController();
    String severity = 'Medium';

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add Allergy', style: AppTypography.h2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(labelText: 'Allergy Name *', border: OutlineInputBorder()),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: severity,
                      decoration: const InputDecoration(labelText: 'Severity', border: OutlineInputBorder()),
                      items: ['Low', 'Medium', 'High'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (v) => setDialogState(() => severity = v!),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: reactionCtrl,
                      decoration: const InputDecoration(labelText: 'Reaction (Optional)', border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context, true);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == true) {
      final allergy = Allergy(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameCtrl.text.trim(),
        severity: severity,
        reaction: reactionCtrl.text.trim(),
      );
      await ref.read(profileRepositoryProvider).addAllergy(allergy);
      ref.invalidate(patientAllergiesProvider);
    }
  }

  Future<void> _removeAllergy(String id) async {
    await ref.read(profileRepositoryProvider).removeAllergy(id);
    ref.invalidate(patientAllergiesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final allergiesAsync = ref.watch(patientAllergiesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Allergy Profile'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAllergyDialog,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: allergiesAsync.when(
        data: (allergies) {
          if (allergies.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.health_and_safety_outlined, size: 80, color: AppColors.primary.withValues(alpha: 0.3)),
                    const SizedBox(height: 16),
                    const Text('No Allergies', style: AppTypography.h2),
                    const SizedBox(height: 8),
                    const Text(
                      'You have not added any allergies. Tap + to add one.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: allergies.length,
            itemBuilder: (context, index) {
              final allergy = allergies[index];
              Color severityColor;
              switch (allergy.severity) {
                case 'High': severityColor = AppColors.error; break;
                case 'Medium': severityColor = AppColors.warningText; break;
                default: severityColor = AppColors.primary;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4))
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: severityColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: Icon(Icons.warning_amber_rounded, color: severityColor),
                  ),
                  title: Text(allergy.name, style: AppTypography.h3),
                  subtitle: Text(
                    'Severity: ${allergy.severity}\nReaction: ${allergy.reaction ?? 'Unknown'}',
                    style: AppTypography.bodyMedium,
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: AppColors.error),
                    onPressed: () => _removeAllergy(allergy.id),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
