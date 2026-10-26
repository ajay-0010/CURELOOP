import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/appointment_models.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../home/presentation/widgets/dashboard_card.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback? onTap;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
  });

  (Color, Color) _getStatusColors() {
    switch (appointment.status) {
      case AppointmentStatus.scheduled: return (AppColors.primary, AppColors.primary.withValues(alpha: 0.1));
      case AppointmentStatus.completed: return (AppColors.success, AppColors.success.withValues(alpha: 0.1));
      case AppointmentStatus.cancelled: return (AppColors.error, AppColors.error.withValues(alpha: 0.1));
      default: return (AppColors.textSecondary, AppColors.border);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localDt = appointment.appointmentDatetime.toLocal();
    final dateStr = DateFormat.yMMMd().format(localDt);
    final timeStr = DateFormat.jm().format(localDt);
    final statusColors = _getStatusColors();

    return DashboardCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: statusColors.$2,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.person, color: statusColors.$1, size: 28),
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
                            child: Text(appointment.doctorName, style: AppTypography.h3),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColors.$2,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              appointment.status.name.toUpperCase(),
                              style: TextStyle(color: statusColors.$1, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (appointment.clinicName != null && appointment.clinicName!.isNotEmpty) ...[
                        Row(
                          children: [
                            const Icon(Icons.local_hospital, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(appointment.clinicName!, style: AppTypography.bodySmall),
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text('$dateStr • $timeStr', style: AppTypography.bodySmall.copyWith(color: AppColors.textPrimary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
