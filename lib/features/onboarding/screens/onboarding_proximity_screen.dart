import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/onboarding_scaffold.dart';

class OnboardingProximityScreen extends StatelessWidget {
  const OnboardingProximityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      heroAsset: 'assets/images/onboarding-proximity-hero.png',
      heroSemanticLabel:
          'Glowing route from user location to nearest verified Masjid',
      step: 2,
      totalSteps: 3,
      title: const Column(
        children: [
          Text('We find your'),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: 'closest ',
                style: TextStyle(color: AppColors.gold),
              ),
              TextSpan(text: 'masjid for you.'),
            ]),
          ),
        ],
      ),
      body:
          'Our intelligent proximity engine routes you to the broadcast of the nearest verified masjid — automatically, whenever you move.',
      primaryLabel: 'Continue',
      onPrimary: () => context.push(AppRoutes.onboardingVerified),
      onSkip: () => context.go(AppRoutes.login),
    );
  }
}
