import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/nav.dart';
import 'primary_button.dart';

class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    super.key,
    required this.heroAsset,
    required this.heroSemanticLabel,
    required this.step,
    required this.totalSteps,
    required this.title,
    required this.body,
    required this.primaryLabel,
    required this.onPrimary,
    this.onSkip,
    this.skipLabel = 'Skip',
    this.primaryTrailing,
  });

  final String heroAsset;
  final String heroSemanticLabel;
  final int step;
  final int totalSteps;
  final Widget title;
  final String body;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final VoidCallback? onSkip;
  final String skipLabel;
  final Widget? primaryTrailing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onbNavy,
      body: SafeArea(
        child: mobileClamp(
          LayoutBuilder(
            builder: (context, constraints) {
              final heroHeight =
                  (constraints.maxHeight * 0.42).clamp(220.0, 360.0);
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(
                          height: heroHeight,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                heroAsset,
                                semanticLabel: heroSemanticLabel,
                                fit: BoxFit.cover,
                              ),
                              Positioned.fill(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        AppColors.onbNavy
                                            .withValues(alpha: 0.85),
                                        AppColors.onbNavy,
                                      ],
                                      stops: const [0.55, 0.92, 1.0],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: -1,
                                child: SizedBox(
                                  height: 28,
                                  child: CustomPaint(
                                    painter: _DividerPainter(),
                                    child: Center(
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: AppColors.onbNavy,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.gold
                                                .withValues(alpha: 0.4),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.diamond_outlined,
                                          size: 14,
                                          color: AppColors.gold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(28, 24, 28, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _Dots(active: step - 1, total: totalSteps),
                                const SizedBox(height: 22),
                                DefaultTextStyle.merge(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    height: 1.25,
                                  ),
                                  child: title,
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  body,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.textGray,
                                    fontSize: 14,
                                    height: 1.55,
                                  ),
                                ),
                                const SizedBox(height: 28),
                                const Spacer(),
                                PrimaryButton(
                                  label: primaryLabel,
                                  onPressed: onPrimary,
                                  trailing: primaryTrailing,
                                ),
                                const SizedBox(height: 4),
                                GhostButton(
                                  label: skipLabel,
                                  onPressed: onSkip,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.active, required this.total});
  final int active;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final isActive = i == active;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 22 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.gold
                : AppColors.gold.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}

class _DividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gold.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final path = Path()
      ..moveTo(0, 8)
      ..cubicTo(
        size.width * 0.23, size.height * 1.0,
        size.width * 0.77, size.height * 1.0,
        size.width, 8,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
