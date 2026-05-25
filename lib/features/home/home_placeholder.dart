import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class HomePlaceholder extends StatelessWidget {
  const HomePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.onbNavy,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'Home — coming next.\nAuth flow complete.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
