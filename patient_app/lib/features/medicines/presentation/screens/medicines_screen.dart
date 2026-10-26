import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../data/medicine_repository.dart';
import '../providers/medicine_providers.dart';
import '../widgets/dose_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class MedicinesScreen extends ConsumerStatefulWidget {
  const MedicinesScreen({super.key});

  @override
  ConsumerState<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends ConsumerState<MedicinesScreen> {
  final Set<String> _submittingDoseIds = {};

  Future<void> _handleAction(String doseId, bool isTaken) async {
    if (_submittingDoseIds.contains(doseId)) return;

    if (!isTaken) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Skip Dose', style: AppTypography.h2),
          content: const Text('Mark this dose as skipped?', style: AppTypography.bodyMedium),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), 
              child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.warningText,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Skip', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
      if (confirm != true) return;
    }

    setState(() => _submittingDoseIds.add(doseId));

    try {
      final repo = ref.read(medicineRepositoryProvider);
      if (isTaken) {
        await repo.markDoseTaken(doseId);
      } else {
        await repo.markDoseSkipped(doseId);
      }
      
      ref.invalidate(todayDosesProvider);
      ref.invalidate(upcomingDosesProvider);
      ref.invalidate(historyDosesProvider);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update dose: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _submittingDoseIds.remove(doseId));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Medicines'),
          backgroundColor: AppColors.surface,
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            labelStyle: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            unselectedLabelStyle: AppTypography.bodyLarge,
            tabs: const [
              Tab(text: 'Today'),
              Tab(text: 'Upcoming'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTodayTab(),
            _buildUpcomingTab(),
            _buildHistoryTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayTab() {
    final todayAsync = ref.watch(todayDosesProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(todayDosesProvider.future),
      child: todayAsync.when(
        data: (doses) {
          if (doses.isEmpty) return _buildEmptyState('No doses scheduled for today.');
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: doses.length,
            itemBuilder: (context, index) {
              final dose = doses[index];
              return DoseCard(
                dose: dose,
                isSubmitting: _submittingDoseIds.contains(dose.id),
                onTaken: () => _handleAction(dose.id, true),
                onSkip: () => _handleAction(dose.id, false),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => _buildError(e, () => ref.refresh(todayDosesProvider)),
      ),
    );
  }

  Widget _buildUpcomingTab() {
    final upcomingAsync = ref.watch(upcomingDosesProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(upcomingDosesProvider.future),
      child: upcomingAsync.when(
        data: (doses) {
          if (doses.isEmpty) return _buildEmptyState('No upcoming doses scheduled.');
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: doses.length,
            itemBuilder: (context, index) {
              final dose = doses[index];
              final dateStr = DateFormat.yMMMd().format(dose.scheduledAt.toLocal());
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0 || DateFormat.yMMMd().format(doses[index - 1].scheduledAt.toLocal()) != dateStr)
                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 16, bottom: 8),
                      child: Text(dateStr, style: AppTypography.h3.copyWith(color: AppColors.primaryDark)),
                    ),
                  DoseCard(dose: dose),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => _buildError(e, () => ref.refresh(upcomingDosesProvider)),
      ),
    );
  }

  Widget _buildHistoryTab() {
    final historyAsync = ref.watch(historyDosesProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(historyDosesProvider.future),
      child: historyAsync.when(
        data: (doses) {
          if (doses.isEmpty) return _buildEmptyState('No dose history available.');
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: doses.length,
            itemBuilder: (context, index) {
              final dose = doses[index];
              final dateStr = DateFormat.yMMMd().format(dose.scheduledAt.toLocal());
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0 || DateFormat.yMMMd().format(doses[index - 1].scheduledAt.toLocal()) != dateStr)
                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 16, bottom: 8),
                      child: Text(dateStr, style: AppTypography.h3.copyWith(color: AppColors.textSecondary)),
                    ),
                  DoseCard(dose: dose),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => _buildError(e, () => ref.refresh(historyDosesProvider)),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return ListView(
      children: [
        const SizedBox(height: 100),
        Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: const Icon(Icons.check_circle_outline, size: 64, color: AppColors.primary),
              ),
              const SizedBox(height: 24),
              const Text('All caught up!', style: AppTypography.h2),
              const SizedBox(height: 8),
              Text(message, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildError(Object error, VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Failed to load doses.', style: TextStyle(color: AppColors.error)),
          Text(error.toString(), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
