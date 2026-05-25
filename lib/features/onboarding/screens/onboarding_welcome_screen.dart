import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/onboarding_scaffold.dart';

class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      heroAsset: 'assets/images/onboarding-welcome-hero.png',
      heroSemanticLabel:
          'Golden mosque at night with live Athan broadcast signal',
      step: 1,
      totalSteps: 3,
      title: const Column(
        children: [
          Text('Allow location'),
          Text(
            'to better assist you.',
            style: TextStyle(color: AppColors.gold),
          ),
        ],
      ),
      body:
          'We use your location to find the nearest verified masjid and keep the Athan playing as you move.',
      primaryLabel: 'Allow Us',
      onPrimary: () => context.push(AppRoutes.onboardingProximity),
      skipLabel: 'Maybe later',
      onSkip: () => context.go(AppRoutes.login),
    );
  }
}
