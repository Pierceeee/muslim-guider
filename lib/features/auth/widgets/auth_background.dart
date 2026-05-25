import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/permissions-bg.png',
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.onbNavyDeep.withValues(alpha: 0.55),
                  AppColors.onbNavy.withValues(alpha: 0.85),
                  AppColors.onbNavyDeep,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Opacity(
            opacity: 0.18,
            child: Image.asset(
              'assets/images/mosque-silhouette.png',
              fit: BoxFit.cover,
              height: 180,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class LanguagePill extends StatelessWidget {
  const LanguagePill({super.key, required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _pill('EN', value == 'en'),
          _pill('AR', value == 'ar'),
        ],
      ),
    );
  }

  Widget _pill(String label, bool active) {
    return GestureDetector(
      onTap: () => onChanged(label.toLowerCase()),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.gold : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? AppColors.navy : AppColors.textGray,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 0.6,
          ),
        ),
      ),
    );
  }
}
