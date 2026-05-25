import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = GoogleFonts.manropeTextTheme(base.textTheme).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.onbNavy,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.gold,
        onPrimary: AppColors.navy,
        secondary: AppColors.sage,
        surface: AppColors.cardBg,
        onSurface: AppColors.textPrimary,
        error: AppColors.danger,
      ),
      textTheme: textTheme,
      iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 20),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBg.withValues(alpha: 0.6),
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        labelStyle: textTheme.labelMedium?.copyWith(color: AppColors.textGray),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.gold.withValues(alpha: 0.22)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.gold.withValues(alpha: 0.22)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
      ),
    );
  }
}
