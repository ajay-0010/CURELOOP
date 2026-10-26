import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/prescriptions/presentation/screens/add_prescription_choice_screen.dart';
import '../../features/prescriptions/presentation/screens/manual_prescription_screen.dart';
import '../../features/prescriptions/presentation/screens/prescription_review_screen.dart';
import '../../features/prescriptions/presentation/screens/safety_check_screen.dart';
import '../../features/prescriptions/presentation/screens/prescription_confirmation_screen.dart';
import '../../features/prescriptions/presentation/screens/ocr_review_screen.dart';
import '../../features/prescriptions/data/models/prescription_models.dart';
import '../../features/appointments/presentation/screens/add_appointment_screen.dart';
import '../../features/appointments/presentation/screens/appointment_detail_screen.dart';
import '../../features/profile/presentation/screens/profile_setup_screen.dart';
import '../../features/profile/presentation/screens/allergy_profile_screen.dart';
import '../../features/profile/presentation/screens/family_profiles_screen.dart';
import '../../features/profile/presentation/screens/add_family_member_screen.dart';
import '../../features/profile/presentation/screens/emergency_card_screen.dart';
import '../storage/secure_storage.dart';
import '../config/dev_config.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authTokenStorageProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authState.valueOrNull != null || kDevSkipAuth;
      final isGoingToAuth = state.matchedLocation == '/login' || state.matchedLocation == '/otp';
      
      if (authState.isLoading) return null;
      
      if (!isAuthenticated && !isGoingToAuth) {
        return '/login';
      }
      
      if (isAuthenticated && isGoingToAuth && !kDevSkipAuth) {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final phone = state.uri.queryParameters['phone'] ?? '';
          return OtpScreen(phoneNumber: phone);
        },
      ),
      GoRoute(
        path: '/prescriptions/add',
        builder: (context, state) => const AddPrescriptionChoiceScreen(),
      ),
      GoRoute(
        path: '/prescriptions/add/manual',
        builder: (context, state) => const ManualPrescriptionScreen(),
      ),
      GoRoute(
        path: '/prescriptions/ocr-review',
        builder: (context, state) => OcrReviewScreen(ocrResponse: state.extra as OCRExtractionResponse),
      ),
      GoRoute(
        path: '/prescriptions/:id/review',
        builder: (context, state) => PrescriptionReviewScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/prescriptions/:id/safety',
        builder: (context, state) => SafetyCheckScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/prescriptions/:id/confirm',
        builder: (context, state) => PrescriptionConfirmationScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/appointments/add',
        builder: (context, state) => const AddAppointmentScreen(),
      ),
      GoRoute(
        path: '/appointments/:id',
        builder: (context, state) => AppointmentDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/profile/setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: '/profile/allergies',
        builder: (context, state) => const AllergyProfileScreen(),
      ),
      GoRoute(
        path: '/profile/family',
        builder: (context, state) => const FamilyProfilesScreen(),
      ),
      GoRoute(
        path: '/profile/family/add',
        builder: (context, state) => const AddFamilyMemberScreen(),
      ),
      GoRoute(
        path: '/profile/emergency',
        builder: (context, state) => const EmergencyCardScreen(),
      ),
    ],
  );
}
