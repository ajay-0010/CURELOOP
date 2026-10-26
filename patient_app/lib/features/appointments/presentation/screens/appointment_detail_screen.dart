import 'package:cureloop_patient/core/error/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../data/models/appointment_models.dart';
import '../../data/appointment_repository.dart';
import '../providers/appointment_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../home/presentation/widgets/dashboard_card.dart';

class AppointmentDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const AppointmentDetailScreen({super.key, required this.id});

  @override
  ConsumerState<AppointmentDetailScreen> createState() => _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends ConsumerState<AppointmentDetailScreen> {
  bool _isActionRunning = false;

  Future<void> _complete() async {
    setState(() => _isActionRunning = true);
    try {
      final repo = ref.read(appointmentRepositoryProvider);
      await repo.completeAppointment(widget.id);
      ref.invalidate(upcomingAppointmentsProvider);
      ref.invalidate(pastAppointmentsProvider);
      ref.invalidate(appointmentDetailProvider(widget.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Appointment completed')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppError.fromException(e).message)));
      }
    } finally {
      if (mounted) setState(() => _isActionRunning = false);
    }
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete appointment?', style: AppTypography.h2),
        content: const Text('This appointment will be removed permanently.', style: AppTypography.bodyMedium),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isActionRunning = true);
    try {
      final repo = ref.read(appointmentRepositoryProvider);
      await repo.deleteAppointment(widget.id);
      ref.invalidate(upcomingAppointmentsProvider);
      ref.invalidate(pastAppointmentsProvider);
      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Appointment deleted')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppError.fromException(e).message)));
      }
    } finally {
      if (mounted) setState(() => _isActionRunning = false);
    }
  }

  (Color, Color, String) _getStatusInfo(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.scheduled: return (AppColors.primary, AppColors.primary.withValues(alpha: 0.1), 'Scheduled');
      case AppointmentStatus.completed: return (AppColors.success, AppColors.success.withValues(alpha: 0.1), 'Completed');
      case AppointmentStatus.cancelled: return (AppColors.error, AppColors.error.withValues(alpha: 0.1), 'Cancelled');
      default: return (AppColors.textSecondary, AppColors.border, 'Unknown');
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncAppt = ref.watch(appointmentDetailProvider(widget.id));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Appointment Details'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: asyncAppt.when(
        data: (appt) {
          final localDt = appt.appointmentDatetime.toLocal();
          final isScheduled = appt.status == AppointmentStatus.scheduled;
          final statusInfo = _getStatusInfo(appt.status);

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      DashboardCard(
                        padding: const EdgeInsets.all(24),
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
                                    color: statusInfo.$2,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    statusInfo.$3,
                                    style: TextStyle(color: statusInfo.$1, fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(appt.doctorName, style: AppTypography.h1),
                            const SizedBox(height: 16),
                            const Divider(height: 1, color: AppColors.border),
                            const SizedBox(height: 16),
                            _buildRow(Icons.local_hospital, appt.clinicName ?? 'No location provided'),
                            const SizedBox(height: 12),
                            _buildRow(Icons.calendar_today, '${DateFormat.yMMMd().format(localDt)} at ${DateFormat.jm().format(localDt)}'),
                            if (appt.notes != null && appt.notes!.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              const Divider(height: 1, color: AppColors.border),
                              const SizedBox(height: 16),
                              const Text('Notes', style: AppTypography.h3),
                              const SizedBox(height: 8),
                              Text(appt.notes!, style: AppTypography.bodyMedium),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (isScheduled)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.notifications_active, color: AppColors.primary),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "You'll receive appointment reminders before your visit.",
                                  style: AppTypography.bodyMedium.copyWith(color: AppColors.primaryDark),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      if (isScheduled) ...[
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: _isActionRunning ? null : _complete,
                            icon: const Icon(Icons.check, color: Colors.white),
                            label: const Text('Mark as Completed', style: AppTypography.button),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton.icon(
                          onPressed: _isActionRunning ? null : _delete,
                          icon: const Icon(Icons.delete_outline, color: AppColors.error),
                          label: Text('Delete Appointment', style: AppTypography.button.copyWith(color: AppColors.error)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.error),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),
                    ],
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

  Widget _buildRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary))),
      ],
    );
  }
}
