import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/prescription_repository.dart';
import '../../data/models/prescription_models.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../home/presentation/widgets/dashboard_card.dart';

class ManualPrescriptionScreen extends ConsumerStatefulWidget {
  const ManualPrescriptionScreen({super.key});

  @override
  ConsumerState<ManualPrescriptionScreen> createState() => _ManualPrescriptionScreenState();
}

class _ManualPrescriptionScreenState extends ConsumerState<ManualPrescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _doctorController = TextEditingController();
  final _clinicController = TextEditingController();
  final _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  
  final List<MedicineForm> _medicines = [];
  bool _isLoading = false;

  void _addMedicine() {
    setState(() {
      _medicines.add(MedicineForm());
    });
  }

  void _removeMedicine(int index) {
    setState(() {
      _medicines.removeAt(index);
    });
  }

  Future<void> _saveDraft() async {
    if (!_formKey.currentState!.validate()) return;
    if (_medicines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add at least one medicine')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final repo = ref.read(prescriptionRepositoryProvider);
      final data = {
        'doctor_name': _doctorController.text.trim(),
        'clinic_name': _clinicController.text.trim(),
        'prescription_date': _dateController.text.trim(),
        'medicines': _medicines.map((m) => {
          'medicine_name': m.nameCtrl.text.trim(),
          'dosage': m.dosageCtrl.text.trim(),
          'frequency': m.freqCtrl.text.trim(),
          'duration_days': int.tryParse(m.durationCtrl.text.trim()),
          'food_timing': m.foodTiming.name.toUpperCase(),
        }).toList(),
      };

      final prescription = await repo.createManualPrescription(data);
      if (mounted) {
        context.replace('/prescriptions/${prescription.id}/review');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save draft: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Manual Entry'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text('Doctor Information', style: AppTypography.h2),
              const SizedBox(height: 16),
              DashboardCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _doctorController,
                      decoration: const InputDecoration(labelText: 'Doctor Name', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _clinicController,
                      decoration: const InputDecoration(labelText: 'Clinic Name', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(labelText: 'Prescription Date (YYYY-MM-DD)', border: OutlineInputBorder()),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Medicines', style: AppTypography.h2),
              const SizedBox(height: 16),
              ..._medicines.asMap().entries.map((e) => _buildMedicineCard(e.key, e.value)),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _addMedicine,
                icon: const Icon(Icons.add, color: AppColors.primary),
                label: Text('Add Medicine', style: AppTypography.button.copyWith(color: AppColors.primary)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  side: const BorderSide(color: AppColors.primary, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveDraft,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.white) 
                      : const Text('Save & Continue', style: AppTypography.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedicineCard(int index, MedicineForm form) {
    return DashboardCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Medicine ', style: AppTypography.h3),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                onPressed: () => _removeMedicine(index),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: form.nameCtrl,
            decoration: const InputDecoration(labelText: 'Medicine Name', border: OutlineInputBorder()),
            validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: form.dosageCtrl,
                  decoration: const InputDecoration(labelText: 'Dosage', border: OutlineInputBorder()),
                  validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: form.freqCtrl,
                  decoration: const InputDecoration(labelText: 'Freq (e.g. 1-0-1)', border: OutlineInputBorder()),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Required';
                    if (!RegExp(r'^\d(-\d)+$').hasMatch(v.trim())) return 'Invalid';
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: form.durationCtrl,
                  decoration: const InputDecoration(labelText: 'Duration (days)', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<FoodTiming>(
                  // ignore: deprecated_member_use`n                  value: form.foodTiming,
                  decoration: const InputDecoration(labelText: 'Timing', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: FoodTiming.noInstruction, child: Text('None')),
                    DropdownMenuItem(value: FoodTiming.beforeFood, child: Text('Before')),
                    DropdownMenuItem(value: FoodTiming.withFood, child: Text('With')),
                    DropdownMenuItem(value: FoodTiming.afterFood, child: Text('After')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => form.foodTiming = val);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MedicineForm {
  final nameCtrl = TextEditingController();
  final dosageCtrl = TextEditingController();
  final freqCtrl = TextEditingController();
  final durationCtrl = TextEditingController();
  FoodTiming foodTiming = FoodTiming.noInstruction;
}

