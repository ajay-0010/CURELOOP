import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../medicines/presentation/providers/medicine_providers.dart';
import '../../appointments/presentation/providers/appointment_providers.dart';
import '../../prescriptions/presentation/providers/prescription_providers.dart';
import '../../medicines/data/models/medicine_models.dart';
import '../../appointments/data/models/appointment_models.dart';
import '../../prescriptions/data/models/prescription_models.dart';

import 'widgets/dashboard_card.dart';
import 'widgets/section_header.dart';
import '../../medicines/presentation/screens/medicines_screen.dart';
import '../../appointments/presentation/screens/appointments_screen.dart';
import '../../prescriptions/presentation/screens/prescription_list_screen.dart';
import '../../profile/presentation/screens/profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _buildBody(),
      ),
      floatingActionButton: _currentIndex == 0 ? FloatingActionButton.extended(
        onPressed: () => context.push('/prescriptions/add'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Prescription', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ) : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textMuted,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Vault'),
            BottomNavigationBarItem(icon: Icon(Icons.medication), label: 'Medicines'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Appts'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0: // Home
        return const _HomeDashboardContent();
      case 1: // Prescriptions
        return const PrescriptionListScreen();
      case 2: // Medicines
        return const MedicinesScreen();
      case 3: // Appointments
        return const AppointmentsScreen();
      case 4: // Profile
        return const ProfileScreen();
      default:
        return const Center(child: Text('Under Construction'));
    }
  }
}

class _HomeDashboardContent extends ConsumerWidget {
  const _HomeDashboardContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosesAsync = ref.watch(todayDosesProvider);
    final apptsAsync = ref.watch(upcomingAppointmentsProvider);
    final rxAsync = ref.watch(prescriptionListProvider);

    final isLoading = dosesAsync.isLoading || apptsAsync.isLoading || rxAsync.isLoading;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final doses = dosesAsync.valueOrNull ?? [];
    final appts = apptsAsync.valueOrNull ?? [];
    final rxs = rxAsync.valueOrNull ?? [];

    final isCompletelyEmpty = doses.isEmpty && appts.isEmpty && rxs.isEmpty;

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(todayDosesProvider);
        ref.invalidate(upcomingAppointmentsProvider);
        ref.invalidate(prescriptionListProvider);
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildHeader(context),
          ),
          if (isCompletelyEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: _buildEmptyState(),
            )
          else
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (doses.isNotEmpty) _buildMedicinesSection(doses),
                    if (appts.isNotEmpty) _buildAppointmentsSection(appts),
                    if (rxs.isNotEmpty) _buildPrescriptionsSection(rxs),
                    const SizedBox(height: 80), // FAB padding
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning,',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 4),
              Text(
                'Demo Patient',
                style: AppTypography.display.copyWith(fontSize: 24),
              ),
            ],
          ),
          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary, size: 28),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => context.push('/onboarding'),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                  child: const Text('DP', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.health_and_safety_outlined, size: 100, color: AppColors.primary.withValues(alpha: 0.3)),
          const SizedBox(height: 32),
          const Text(
            'Your dashboard is empty',
            style: AppTypography.h1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Add a prescription or an appointment to get started tracking your health journey.',
            style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMedicinesSection(List<DoseEvent> doses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Today\'s Medicines'),
        ...doses.take(3).map((dose) => DashboardCard(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: dose.status == DoseStatus.taken ? AppColors.success.withValues(alpha: 0.1) : AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.medication_liquid,
                  color: dose.status == DoseStatus.taken ? AppColors.success : AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dose.medicineName ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    const Text(' • ', style: AppTypography.bodySmall),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat.jm().format(dose.scheduledAt),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                  ),
                  const SizedBox(height: 4),
                  if (dose.status == DoseStatus.taken)
                    const Icon(Icons.check_circle, color: AppColors.success, size: 16)
                  else
                    const Icon(Icons.pending_actions, color: AppColors.warningText, size: 16)
                ],
              )
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildAppointmentsSection(List<Appointment> appts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Upcoming Appointments'),
        ...appts.take(2).map((appt) => DashboardCard(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat.MMM().format(appt.appointmentDatetime),
                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      DateFormat.d().format(appt.appointmentDatetime),
                      style: const TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appt.doctorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(appt.clinicName ?? 'General Visit', style: AppTypography.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildPrescriptionsSection(List<Prescription> rxs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Recent Prescriptions'),
        ...rxs.take(2).map((rx) => DashboardCard(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.textMuted.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.receipt_long, color: AppColors.textSecondary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(rx.doctorName ?? 'Unknown Provider', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    const Text(' Medicines', style: AppTypography.bodySmall),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: rx.status == PrescriptionStatus.confirmed ? AppColors.success.withValues(alpha: 0.1) : AppColors.warningFill,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  rx.status == PrescriptionStatus.confirmed ? 'Confirmed' : 'Draft',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: rx.status == PrescriptionStatus.confirmed ? AppColors.success : AppColors.warningText,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}


