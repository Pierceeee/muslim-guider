import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/nav.dart';
import '../../../core/widgets/primary_button.dart';

class LanguageRegionScreen extends StatefulWidget {
  const LanguageRegionScreen({super.key});

  @override
  State<LanguageRegionScreen> createState() => _LanguageRegionScreenState();
}

class _LanguageRegionScreenState extends State<LanguageRegionScreen> {
  String _language = 'en';
  String _region = 'us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onbNavy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppColors.textPrimary),
          onPressed: () => safeBack(context, fallback: AppRoutes.permissions),
        ),
      ),
      body: SafeArea(
        child: mobileClamp(Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Language & Region',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose how you read and where you pray — you can change these anytime.',
                style: TextStyle(
                  color: AppColors.textGray,
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              const _SectionLabel('Language'),
              const SizedBox(height: 10),
              _OptionTile(
                title: 'English',
                trailing: 'EN',
                selected: _language == 'en',
                onTap: () => setState(() => _language = 'en'),
              ),
              _OptionTile(
                title: 'العربية',
                trailing: 'AR',
                selected: _language == 'ar',
                onTap: () => setState(() => _language = 'ar'),
              ),
              _OptionTile(
                title: 'Bahasa Melayu',
                trailing: 'MS',
                selected: _language == 'ms',
                onTap: () => setState(() => _language = 'ms'),
              ),
              const SizedBox(height: 24),
              const _SectionLabel('Region'),
              const SizedBox(height: 10),
              _OptionTile(
                title: 'United States',
                trailing: '🇺🇸',
                selected: _region == 'us',
                onTap: () => setState(() => _region = 'us'),
              ),
              _OptionTile(
                title: 'United Kingdom',
                trailing: '🇬🇧',
                selected: _region == 'uk',
                onTap: () => setState(() => _region = 'uk'),
              ),
              _OptionTile(
                title: 'Malaysia',
                trailing: '🇲🇾',
                selected: _region == 'my',
                onTap: () => setState(() => _region = 'my'),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Continue',
                onPressed: () => context.go(AppRoutes.login),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        color: AppColors.gold.withValues(alpha: 0.9),
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.title,
    required this.trailing,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String trailing;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.gold.withValues(alpha: 0.10)
                  : AppColors.cardBg.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected
                    ? AppColors.gold
                    : AppColors.gold.withValues(alpha: 0.16),
                width: selected ? 1.4 : 1,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected
                          ? AppColors.gold
                          : AppColors.textMuted,
                      width: 1.6,
                    ),
                    color: selected
                        ? AppColors.gold
                        : Colors.transparent,
                  ),
                  child: selected
                      ? const Icon(Icons.check,
                          color: AppColors.navy, size: 12)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  trailing,
                  style: const TextStyle(
                    color: AppColors.textGray,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
