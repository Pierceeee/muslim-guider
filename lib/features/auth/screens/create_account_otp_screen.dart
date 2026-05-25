import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/nav.dart';
import '../../../core/widgets/primary_button.dart';
import '../widgets/auth_background.dart';

class CreateAccountOtpScreen extends StatefulWidget {
  const CreateAccountOtpScreen({super.key});

  @override
  State<CreateAccountOtpScreen> createState() => _CreateAccountOtpScreenState();
}

class _CreateAccountOtpScreenState extends State<CreateAccountOtpScreen> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  String _lang = 'en';
  int _secondsLeft = 42;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = 42);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _focusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  String get _code => _controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    final canResend = _secondsLeft == 0;
    final progress = 0.66;
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
                      onPressed: () => safeBack(
                        context,
                        fallback: AppRoutes.createAccountContact,
                      ),
                    ),
                    const Spacer(),
                    LanguagePill(
                      value: _lang,
                      onChanged: (v) => setState(() => _lang = v),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Image.asset(
                  'assets/images/login-logo.png',
                  height: 52,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.mosque,
                    color: AppColors.gold,
                    size: 44,
                  ),
                ),
                const SizedBox(height: 20),
                _ProgressCard(progress: progress),
                const SizedBox(height: 24),
                const Text(
                  'Enter the 6-digit code',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'We sent it to',
                  style: TextStyle(color: AppColors.textGray, fontSize: 12.5),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'yusuf@example.com',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () => safeBack(
                        context,
                        fallback: AppRoutes.createAccountContact,
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(48, 32),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          color: AppColors.gold,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (i) => _otpCell(i)),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!canResend) ...[
                      const Icon(Icons.access_time,
                          size: 14, color: AppColors.textGray),
                      const SizedBox(width: 6),
                      Text(
                        'Resend code in 0:${_secondsLeft.toString().padLeft(2, "0")}',
                        style: const TextStyle(
                          color: AppColors.textGray,
                          fontSize: 12,
                        ),
                      ),
                    ] else
                      TextButton(
                        onPressed: _startTimer,
                        child: const Text(
                          'Resend code',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                PrimaryButton(
                  label: 'Verify',
                  onPressed: () =>
                      context.push(AppRoutes.createAccountProfile),
                ),
                const SizedBox(height: 28),
                const _TrustFooter(),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget _otpCell(int i) {
    final filled = _controllers[i].text.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        width: 44,
        height: 56,
        child: TextField(
          controller: _controllers[i],
          focusNode: _focusNodes[i],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
            color: AppColors.gold,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: filled
                ? AppColors.gold.withValues(alpha: 0.10)
                : AppColors.cardBg.withValues(alpha: 0.55),
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: filled
                    ? AppColors.gold
                    : AppColors.gold.withValues(alpha: 0.22),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppColors.gold, width: 1.6),
            ),
          ),
          onChanged: (v) {
            if (v.isNotEmpty && i < 5) {
              _focusNodes[i + 1].requestFocus();
            } else if (v.isEmpty && i > 0) {
              _focusNodes[i - 1].requestFocus();
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.55),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.22)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.shield_outlined,
                  color: AppColors.gold, size: 16),
              const SizedBox(width: 8),
              const Text(
                'Verification · Step 2 of 3',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  color: AppColors.gold,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.cardBgLight,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.gold),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrustFooter extends StatelessWidget {
  const _TrustFooter();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: AppColors.gold, size: 10),
            Container(
              width: 30,
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: AppColors.gold.withValues(alpha: 0.5),
            ),
            const Icon(Icons.mosque, color: AppColors.gold, size: 14),
            Container(
              width: 30,
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: AppColors.gold.withValues(alpha: 0.5),
            ),
            const Icon(Icons.star, color: AppColors.gold, size: 10),
          ],
        ),
        const SizedBox(height: 6),
        const Text.rich(
          TextSpan(
            style: TextStyle(color: AppColors.textGray, fontSize: 11),
            children: [
              TextSpan(text: 'Trusted by '),
              TextSpan(
                text: '2M+',
                style: TextStyle(
                  color: AppColors.gold,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(text: ' users worldwide'),
            ],
          ),
        ),
      ],
    );
  }
}
