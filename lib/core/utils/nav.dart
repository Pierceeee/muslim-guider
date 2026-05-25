import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';

void safeBack(BuildContext context, {String fallback = '/'}) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go(fallback);
  }
}

void showComingSoon(BuildContext context, String feature) {
  final messenger = ScaffoldMessenger.maybeOf(context);
  messenger?.clearSnackBars();
  messenger?.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.gold.withValues(alpha: 0.4)),
      ),
      content: Row(
        children: [
          const Icon(Icons.access_time, color: AppColors.gold, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$feature — coming soon',
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}

const double kMobileMaxWidth = 480;

Widget mobileClamp(Widget child) {
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: kMobileMaxWidth),
      child: child,
    ),
  );
}
