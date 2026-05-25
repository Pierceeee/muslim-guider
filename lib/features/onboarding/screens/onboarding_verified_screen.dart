import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/onboarding_scaffold.dart';

class OnboardingVerifiedScreen extends StatelessWidget {
  const OnboardingVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      heroAsset: 'assets/images/onboarding-verified-hero.png',
      heroSemanticLabel:
          'Verified broadcast shield with Masjid Board, Imam, Muadhin, and community trust layers',
      step: 3,
      totalSteps: 3,
      title: const Text.rich(
        TextSpan(children: [
          TextSpan(text: 'Every broadcast. '),
          TextSpan(
            text: 'Verified.',
            style: TextStyle(color: AppColors.gold),
          ),
        ]),
      ),
      body:
          'Four layers of verification — Masjid Board, Imam, Muadhin, and 20+ community scans inside the masjid — ensure every call is authentic.',
      primaryLabel: 'Get started',
      primaryTrailing: const Icon(Icons.chevron_right,
          color: AppColors.navy, size: 22),
      onPrimary: () => context.push(AppRoutes.permissions),
      onSkip: () => context.go(AppRoutes.login),
    );
  }
}
