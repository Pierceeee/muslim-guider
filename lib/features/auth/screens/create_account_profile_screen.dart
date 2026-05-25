import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/nav.dart';
import '../../../core/widgets/primary_button.dart';
import '../widgets/auth_background.dart';

class CreateAccountProfileScreen extends StatefulWidget {
  const CreateAccountProfileScreen({super.key});

  @override
  State<CreateAccountProfileScreen> createState() =>
      _CreateAccountProfileScreenState();
}

class _CreateAccountProfileScreenState
    extends State<CreateAccountProfileScreen> {
  final _nameController = TextEditingController();
  String _gender = 'male';
  String _lang = 'en';
  String? _location;
  String? _method;

  @override
  void dispose() {
    _nameController.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left,
                          color: AppColors.textPrimary),
                      onPressed: () => safeBack(
                        context,
                        fallback: AppRoutes.createAccountOtp,
                      ),
                    ),
                    const Spacer(),
                    LanguagePill(
                      value: _lang,
                      onChanged: (v) => setState(() => _lang = v),
                    ),
                  ],
                ),
                Center(
                  child: Image.asset(
                    'assets/images/login-logo.png',
                    height: 52,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.mosque,
                      color: AppColors.gold,
                      size: 44,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Profile Setup',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Center(
                  child: Text(
                    'Complete your profile to personalize\nyour Athan Live experience',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textGray,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Center(
                  child: GestureDetector(
                    onTap: () => showComingSoon(context, 'Photo upload'),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 88,
                              height: 88,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.cardBg
                                    .withValues(alpha: 0.6),
                                border: Border.all(
                                  color: AppColors.gold
                                      .withValues(alpha: 0.4),
                                  width: 1.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: AppColors.gold,
                                size: 28,
                              ),
                            ),
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.gold,
                                border: Border.all(
                                  color: AppColors.onbNavyDeep,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(Icons.add,
                                  color: AppColors.navy, size: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Add Photo',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _ProfileField(
                  label: 'Display Name',
                  child: TextField(
                    controller: _nameController,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      hintText: 'Enter your display name',
                      prefixIcon:
                          Icon(Icons.person_outline, color: AppColors.gold),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                _SelectRow(
                  label: 'Home Location',
                  icon: Icons.location_on_outlined,
                  value: _location,
                  placeholder: 'Select your home location',
                  onTap: () => _pickLocation(),
                ),
                const SizedBox(height: 14),
                _SelectRow(
                  label: 'Calculation Method',
                  icon: Icons.calendar_today_outlined,
                  value: _method,
                  placeholder: 'Select calculation method',
                  onTap: () => _pickMethod(),
                ),
                const SizedBox(height: 14),
                _LabelSmall('Gender (Optional)'),
                const SizedBox(height: 8),
                _GenderControl(
                  selected: _gender,
                  onChanged: (v) => setState(() => _gender = v),
                ),
                const SizedBox(height: 22),
                PrimaryButton(
                  label: 'Finish Setup',
                  onPressed: () => context.go(AppRoutes.home),
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.verified_user_outlined,
                        size: 14, color: AppColors.textGray),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        'By tapping "Finish Setup", you agree to our Terms of Service and Privacy Policy.',
                        style: TextStyle(
                          color: AppColors.textGray,
                          fontSize: 11,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future<void> _pickLocation() async {
    final options = const ['New York, US', 'London, UK', 'Kuala Lumpur, MY'];
    final picked = await _bottomPicker('Home Location', options);
    if (picked != null) setState(() => _location = picked);
  }

  Future<void> _pickMethod() async {
    final options = const [
      'Muslim World League',
      'ISNA',
      'Egyptian',
      'Umm al-Qura',
      'Karachi',
    ];
    final picked = await _bottomPicker('Calculation Method', options);
    if (picked != null) setState(() => _method = picked);
  }

  Future<String?> _bottomPicker(String title, List<String> options) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.textMuted,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.gold,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              ...options.map(
                (o) => ListTile(
                  title: Text(
                    o,
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                  onTap: () => Navigator.pop(context, o),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabelSmall(label),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _LabelSmall extends StatelessWidget {
  const _LabelSmall(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: AppColors.gold.withValues(alpha: 0.85),
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _SelectRow extends StatelessWidget {
  const _SelectRow({
    required this.label,
    required this.icon,
    required this.value,
    required this.placeholder,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final String? value;
  final String placeholder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabelSmall(label),
        const SizedBox(height: 6),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.cardBg.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.gold.withValues(alpha: 0.22),
                ),
              ),
              child: Row(
                children: [
                  Icon(icon, color: AppColors.gold, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      value ?? placeholder,
                      style: TextStyle(
                        color: value == null
                            ? AppColors.textMuted
                            : AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right,
                      color: AppColors.textMuted),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GenderControl extends StatelessWidget {
  const _GenderControl({required this.selected, required this.onChanged});
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final opts = [
      ('male', Icons.male, 'Male'),
      ('female', Icons.female, 'Female'),
      ('prefer-not', Icons.help_outline, 'Prefer not\nto say'),
    ];
    return Row(
      children: [
        for (int i = 0; i < opts.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(child: _option(opts[i])),
        ],
      ],
    );
  }

  Widget _option((String, IconData, String) opt) {
    final active = selected == opt.$1;
    return GestureDetector(
      onTap: () => onChanged(opt.$1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active
              ? AppColors.gold.withValues(alpha: 0.14)
              : AppColors.cardBg.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active
                ? AppColors.gold
                : AppColors.gold.withValues(alpha: 0.18),
            width: active ? 1.4 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(opt.$2,
                color: active ? AppColors.gold : AppColors.textGray,
                size: 18),
            const SizedBox(height: 4),
            Text(
              opt.$3,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: active ? AppColors.gold : AppColors.textGray,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
