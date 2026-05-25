import 'package:go_router/go_router.dart';

import '../features/auth/screens/create_account_contact_screen.dart';
import '../features/auth/screens/create_account_otp_screen.dart';
import '../features/auth/screens/create_account_profile_screen.dart';
import '../features/auth/screens/language_region_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/permissions_screen.dart';
import '../features/onboarding/screens/onboarding_proximity_screen.dart';
import '../features/onboarding/screens/onboarding_verified_screen.dart';
import '../features/onboarding/screens/onboarding_welcome_screen.dart';
import '../features/onboarding/screens/splash_screen.dart';
import '../features/home/home_placeholder.dart';

class AppRoutes {
  static const splash = '/';
  static const onboardingWelcome = '/onboarding/welcome';
  static const onboardingProximity = '/onboarding/proximity';
  static const onboardingVerified = '/onboarding/verified';
  static const permissions = '/permissions';
  static const languageRegion = '/language-region';
  static const login = '/login';
  static const createAccountContact = '/create-account/contact';
  static const createAccountOtp = '/create-account/otp';
  static const createAccountProfile = '/create-account/profile';
  static const home = '/home';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboardingWelcome,
      builder: (_, __) => const OnboardingWelcomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboardingProximity,
      builder: (_, __) => const OnboardingProximityScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboardingVerified,
      builder: (_, __) => const OnboardingVerifiedScreen(),
    ),
    GoRoute(
      path: AppRoutes.permissions,
      builder: (_, __) => const PermissionsScreen(),
    ),
    GoRoute(
      path: AppRoutes.languageRegion,
      builder: (_, __) => const LanguageRegionScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.createAccountContact,
      builder: (_, __) => const CreateAccountContactScreen(),
    ),
    GoRoute(
      path: AppRoutes.createAccountOtp,
      builder: (_, __) => const CreateAccountOtpScreen(),
    ),
    GoRoute(
      path: AppRoutes.createAccountProfile,
      builder: (_, __) => const CreateAccountProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (_, __) => const HomePlaceholder(),
    ),
  ],
);
