import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/nav.dart';
import '../../../core/widgets/primary_button.dart';
import '../widgets/auth_background.dart';

class CreateAccountContactScreen extends StatefulWidget {
  const CreateAccountContactScreen({super.key});

  @override
  State<CreateAccountContactScreen> createState() =>
      _CreateAccountContactScreenState();
}

class _CreateAccountContactScreenState
    extends State<CreateAccountContactScreen> {
  String _method = 'email';
  String _lang = 'en';
  bool _agreed = true;
  final _controller = TextEditingController(text: 'yusuf@example.com');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onbNavyDeep,
      body: AuthBackground(
        child: SafeArea(
          child: mobileClamp(SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left,
                          color: AppColors.textPrimary),
                      onPressed: () =>
                          safeBack(context, fallback: AppRoutes.login),
                    ),
                    const Spacer(),
                    LanguagePill(
                      value: _lang,
                      onChanged: (v) => setState(() => _lang = v),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Image.asset(
                  'assets/images/login-logo.png',
                  height: 60,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.mosque,
                    color: AppColors.gold,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Create listener account',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Create your Athan Live account and\ncontinue securely across devices',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textGray,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.06),
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.32),
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline,
                          color: AppColors.gold, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 11.5,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(text: 'This is a '),
                              TextSpan(
                                text: 'listener',
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    " account. Masjids, Muadhins, and IMAMs are added by the Athan Live admin team — they don't self-sign up here.",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _MethodToggle(
                  selected: _method,
                  onChanged: (v) => setState(() => _method = v),
                ),
                const SizedBox(height: 18),
                _ContactField(
                  method: _method,
                  controller: _controller,
                ),
                const SizedBox(height: 14),
                _TermsRow(
                  agreed: _agreed,
                  onTap: () => setState(() => _agreed = !_agreed),
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: 'Send Verification Code',
                  onPressed: _agreed
                      ? () => context.push(AppRoutes.createAccountOtp)
                      : null,
                ),
                const SizedBox(height: 18),
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
                const SizedBox(height: 14),
                const Row(
                  children: [
                    Expanded(child: _SocialMini(label: 'Google')),
                    SizedBox(width: 12),
                    Expanded(child: _SocialMini(label: 'Apple')),
                  ],
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () =>
                      safeBack(context, fallback: AppRoutes.login),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: AppColors.textGray,
                        fontSize: 12.5,
                      ),
                      children: [
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
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

class _MethodToggle extends StatelessWidget {
  const _MethodToggle({required this.selected, required this.onChanged});
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          _option(Icons.mail_outline, 'Email', 'email'),
          _option(Icons.phone_iphone_outlined, 'Phone', 'phone'),
        ],
      ),
    );
  }

  Widget _option(IconData icon, String label, String value) {
    final active = selected == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? AppColors.gold : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: active ? AppColors.navy : AppColors.textGray,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: active ? AppColors.navy : AppColors.textGray,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactField extends StatelessWidget {
  const _ContactField({required this.method, required this.controller});
  final String method;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final isEmail = method == 'email';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEmail ? 'EMAIL ADDRESS' : 'PHONE NUMBER',
          style: TextStyle(
            color: AppColors.gold.withValues(alpha: 0.85),
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.phone,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: isEmail ? 'you@example.com' : '+1 555 000 0000',
            prefixIcon: Icon(
              isEmail ? Icons.mail_outline : Icons.phone_iphone_outlined,
              color: AppColors.gold,
            ),
          ),
        ),
      ],
    );
  }
}

class _TermsRow extends StatelessWidget {
  const _TermsRow({required this.agreed, required this.onTap});
  final bool agreed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: agreed ? AppColors.gold : Colors.transparent,
              border: Border.all(
                color: agreed ? AppColors.gold : AppColors.textMuted,
                width: 1.6,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: agreed
                ? const Icon(Icons.check, color: AppColors.navy, size: 14)
                : null,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  color: AppColors.textGray,
                  fontSize: 12,
                  height: 1.55,
                ),
                children: [
                  TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(color: AppColors.gold),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(color: AppColors.gold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialMini extends StatelessWidget {
  const _SocialMini({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: OutlinedButton.icon(
        onPressed: () => showComingSoon(context, '$label sign-in'),
        icon: Icon(
          label == 'Apple' ? Icons.apple : Icons.g_mobiledata,
          color: AppColors.textPrimary,
        ),
        label: Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.gold.withValues(alpha: 0.25)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColors.cardBg.withValues(alpha: 0.45),
        ),
      ),
    );
  }
}
