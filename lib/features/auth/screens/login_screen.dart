import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/nav.dart';
import '../../../core/widgets/primary_button.dart';
import '../widgets/auth_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController(text: 'yusuf@example.com');
  final _password = TextEditingController(text: 'password123');
  bool _obscure = true;
  bool _biometric = true;
  String _lang = 'en';

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onbNavyDeep,
      body: AuthBackground(
        child: SafeArea(
          child: mobileClamp(SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LanguagePill(
                      value: _lang,
                      onChanged: (v) => setState(() => _lang = v),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Image.asset(
                  'assets/images/login-logo.png',
                  height: 72,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.mosque,
                    color: AppColors.gold,
                    size: 56,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Secure access across the Athan ecosystem',
                  style:
                      TextStyle(color: AppColors.textGray, fontSize: 13),
                ),
                const SizedBox(height: 28),
                _LabeledField(
                  label: 'Email Address',
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'you@example.com',
                ),
                const SizedBox(height: 16),
                _LabeledField(
                  label: 'Password',
                  controller: _password,
                  obscure: _obscure,
                  hint: 'Enter your password',
                  trailing: GestureDetector(
                    onTap: () => setState(() => _obscure = !_obscure),
                    child: Text(
                      _obscure ? 'Show' : 'Hide',
                      style: TextStyle(
                        color: AppColors.gold.withValues(alpha: 0.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  helper: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      minimumSize: const Size(48, 32),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () =>
                        showComingSoon(context, 'Password reset'),
                    child: Text(
                      'Forgot?',
                      style: TextStyle(
                        color: AppColors.gold.withValues(alpha: 0.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Sign In',
                  onPressed: () => context.go(AppRoutes.home),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.gold.withValues(alpha: 0.18),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or continue with',
                        style: TextStyle(
                          color: AppColors.textGray,
                          fontSize: 11,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.gold.withValues(alpha: 0.18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _SocialButton(
                        label: 'Google',
                        onTap: () =>
                            showComingSoon(context, 'Google sign-in'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SocialButton(
                        label: 'Apple',
                        onTap: () =>
                            showComingSoon(context, 'Apple sign-in'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _BiometricCard(
                  enabled: _biometric,
                  onChanged: (v) => setState(() => _biometric = v),
                ),
                const SizedBox(height: 18),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: AppColors.textGray,
                      fontSize: 13,
                    ),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: 'Create listener account',
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: _pushTap(
                          context,
                          AppRoutes.createAccountContact,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Muadhin / IMAM? Sign in with the credentials your masjid admin sent you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 10.5,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.controller,
    this.hint,
    this.keyboardType,
    this.obscure = false,
    this.trailing,
    this.helper,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final TextInputType? keyboardType;
  final bool obscure;
  final Widget? trailing;
  final Widget? helper;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: AppColors.gold.withValues(alpha: 0.85),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            if (helper != null) helper!,
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: trailing == null
                ? null
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Align(
                      widthFactor: 1,
                      alignment: Alignment.center,
                      child: trailing,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(
          label == 'Apple' ? Icons.apple : Icons.g_mobiledata,
          color: AppColors.textPrimary,
        ),
        label: Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 13.5,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.gold.withValues(alpha: 0.25)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: AppColors.cardBg.withValues(alpha: 0.45),
        ),
      ),
    );
  }
}

class _BiometricCard extends StatelessWidget {
  const _BiometricCard({required this.enabled, required this.onChanged});
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.22)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.fingerprint,
                color: AppColors.gold, size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Login',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Use Face ID or fingerprint',
                  style: TextStyle(
                    color: AppColors.textGray,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: enabled,
            onChanged: onChanged,
            activeThumbColor: AppColors.gold,
          ),
        ],
      ),
    );
  }
}

TapGestureRecognizer _pushTap(BuildContext context, String route) {
  return TapGestureRecognizer()..onTap = () => context.push(route);
}
