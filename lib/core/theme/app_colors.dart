import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const gold = Color(0xFFF6C95C);
  static const softGold = Color(0xFFFFE08A);
  static const cream = Color(0xFFFFF4D6);

  static const navy = Color(0xFF0F172A);
  static const deepNavy = Color(0xFF111827);
  static const charcoal = Color(0xFF1E293B);
  static const cardBg = Color(0xFF1E293B);
  static const cardBgLight = Color(0xFF273548);

  static const onbNavy = Color(0xFF0A0F1A);
  static const onbNavyDeep = Color(0xFF060A12);

  static const sage = Color(0xFF5FA889);
  static const mutedMint = Color(0xFFDCEFE7);
  static const pureWhite = Color(0xFFFFFFFF);

  static const textPrimary = Color(0xFFF1F5F9);
  static const textSecondary = Color(0xFFCBD5E1);
  static const textGray = Color(0xFF94A3B8);
  static const textMuted = Color(0xFF64748B);

  static const danger = Color(0xFFEF6461);
  static const success = Color(0xFF4ADE80);
  static const warning = Color(0xFFF59E0B);
  static const info = Color(0xFF3B82F6);

  static const goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [softGold, gold, Color(0xFFC8922E)],
  );

  static Color goldTint(double opacity) =>
      gold.withValues(alpha: opacity);
}
