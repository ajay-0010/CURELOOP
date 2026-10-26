import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/prescription_repository.dart';

class AddPrescriptionChoiceScreen extends ConsumerStatefulWidget {
  const AddPrescriptionChoiceScreen({super.key});

  @override
  ConsumerState<AddPrescriptionChoiceScreen> createState() => _AddPrescriptionChoiceScreenState();
}

class _AddPrescriptionChoiceScreenState extends ConsumerState<AddPrescriptionChoiceScreen> {
  bool _isLoading = false;

  Future<void> _pickAndUploadImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    
    if (pickedFile == null) return;

    setState(() => _isLoading = true);

    try {
      final repo = ref.read(prescriptionRepositoryProvider);
      final response = await repo.uploadOcrImage(File(pickedFile.path));
      
      if (mounted) {
        context.push('/prescriptions/ocr-review', extra: response);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OCR Failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Select Source', style: AppTypography.h2),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: const Icon(Icons.camera_alt, color: AppColors.primary),
                ),
                title: const Text('Camera', style: AppTypography.bodyLarge),
                onTap: () {
                  Navigator.pop(context);
                  _pickAndUploadImage(ImageSource.camera);
                },
              ),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: const Icon(Icons.photo_library, color: AppColors.primary),
                ),
                title: const Text('Gallery', style: AppTypography.bodyLarge),
                onTap: () {
                  Navigator.pop(context);
                  _pickAndUploadImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Add Prescription'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: AppColors.primary),
                  const SizedBox(height: 24),
                  Text('Analyzing prescription...', style: AppTypography.h3.copyWith(color: AppColors.primaryDark)),
                  const SizedBox(height: 8),
                  const Text('Our AI is extracting the medicines.', style: AppTypography.bodyMedium),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'How would you like to add it?',
                    style: AppTypography.h1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose to scan a physical copy or enter the details manually.',
                    style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 32),
                  _buildChoiceCard(
                    icon: Icons.document_scanner,
                    title: 'Scan Prescription',
                    subtitle: 'Use camera or gallery to auto-fill details using our smart OCR.',
                    onTap: _showImageSourceDialog,
                    isPrimary: true,
                  ),
                  const SizedBox(height: 16),
                  _buildChoiceCard(
                    icon: Icons.edit_document,
                    title: 'Manual Entry',
                    subtitle: 'Type in the medicines and dosage instructions manually.',
                    onTap: () => context.push('/prescriptions/add/manual'),
                    isPrimary: false,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildChoiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPrimary ? AppColors.primary : AppColors.border,
          width: isPrimary ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isPrimary ? AppColors.primary.withValues(alpha: 0.1) : AppColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 32,
                    color: isPrimary ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTypography.h3),
                      const SizedBox(height: 4),
                      Text(subtitle, style: AppTypography.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textMuted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
