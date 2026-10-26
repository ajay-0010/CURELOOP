import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/appointment_providers.dart';
import '../widgets/appointment_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Appointments'),
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
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUpcomingTab(ref, context),
            _buildPastTab(ref, context),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/appointments/add'),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildUpcomingTab(WidgetRef ref, BuildContext context) {
    final upcomingAsync = ref.watch(upcomingAppointmentsProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(upcomingAppointmentsProvider.future),
      child: upcomingAsync.when(
        data: (appointments) {
          if (appointments.isEmpty) {
            return _buildEmptyState(
              context,
              'No upcoming appointments.',
              'Schedule your next visit to stay on top of your health.',
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appt = appointments[index];
              return AppointmentCard(
                appointment: appt,
                onTap: () => context.push('/appointments/${appt.id}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => _buildError(e, () => ref.refresh(upcomingAppointmentsProvider)),
      ),
    );
  }

  Widget _buildPastTab(WidgetRef ref, BuildContext context) {
    final pastAsync = ref.watch(pastAppointmentsProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(pastAppointmentsProvider.future),
      child: pastAsync.when(
        data: (appointments) {
          if (appointments.isEmpty) {
            return _buildEmptyState(context, 'No past appointments.', '');
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appt = appointments[index];
              return AppointmentCard(
                appointment: appt,
                onTap: () => context.push('/appointments/${appt.id}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, st) => _buildError(e, () => ref.refresh(pastAppointmentsProvider)),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String title, String subtitle) {
    return ListView(
      children: [
        const SizedBox(height: 100),
        Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: const Icon(Icons.event_busy, size: 64, color: AppColors.primary),
              ),
              const SizedBox(height: 24),
              Text(title, style: AppTypography.h2),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(subtitle, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => context.push('/appointments/add'),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Add Appointment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                ),
              ],
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
          const Text('Failed to load appointments.', style: TextStyle(color: AppColors.error)),
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
