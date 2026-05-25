import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/nav.dart';
import '../../../core/widgets/primary_button.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  final _allowed = <String, bool>{
    'location': true,
    'notifications': true,
    'microphone': false,
    'storage': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onbNavy,
      appBar: _backAppBar(context),
      body: SafeArea(
        child: mobileClamp(Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'A few quick permissions',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Grant access so we can serve the Athan on time, route you to the closest masjid, and keep the experience seamless.',
                style: TextStyle(
                  color: AppColors.textGray,
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: ListView(
                  children: [
                    _PermissionTile(
                      icon: Icons.location_on_outlined,
                      title: 'Location',
                      subtitle:
                          'Find the nearest verified masjid and auto-switch broadcasts.',
                      value: _allowed['location']!,
                      onChanged: (v) =>
                          setState(() => _allowed['location'] = v),
                    ),
                    _PermissionTile(
                      icon: Icons.notifications_active_outlined,
                      title: 'Notifications',
                      subtitle:
                          'Prayer reminders, live Athan, and community updates.',
                      value: _allowed['notifications']!,
                      onChanged: (v) =>
                          setState(() => _allowed['notifications'] = v),
                    ),
                    _PermissionTile(
                      icon: Icons.mic_none_outlined,
                      title: 'Microphone',
                      subtitle:
                          'Optional — only used by Muadhin role for live broadcast.',
                      value: _allowed['microphone']!,
                      onChanged: (v) =>
                          setState(() => _allowed['microphone'] = v),
                    ),
                    _PermissionTile(
                      icon: Icons.storage_outlined,
                      title: 'Storage',
                      subtitle:
                          'Offline Qur’an pages and cached prayer schedules.',
                      value: _allowed['storage']!,
                      onChanged: (v) =>
                          setState(() => _allowed['storage'] = v),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                label: 'Continue',
                onPressed: () => context.push(AppRoutes.languageRegion),
              ),
              const SizedBox(height: 6),
              GhostButton(
                label: 'Skip for now',
                onPressed: () => context.push(AppRoutes.languageRegion),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  const _PermissionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.18)),
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
            child: Icon(icon, color: AppColors.gold, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textGray,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.gold,
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget _backAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.chevron_left, color: AppColors.textPrimary),
      onPressed: () => safeBack(context, fallback: AppRoutes.splash),
    ),
  );
}
