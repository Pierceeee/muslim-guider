import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/nav.dart';
import '../../../core/widgets/primary_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _mandala;
  late final AnimationController _fade;

  @override
  void initState() {
    super.initState();
    _mandala = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 28),
    )..repeat();
    _fade = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..forward();
  }

  @override
  void dispose() {
    _mandala.dispose();
    _fade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onbNavyDeep,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _BgGlow(),
          FadeTransition(
            opacity: CurvedAnimation(parent: _fade, curve: Curves.easeOut),
            child: SafeArea(
              child: mobileClamp(
                LayoutBuilder(
                  builder: (context, c) => SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: c.maxHeight),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(28, 24, 28, 28),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 16),
                            _Emblem(controller: _mandala),
                            Column(
                              children: [
                                Text(
                                  'Athan Live',
                                  style: TextStyle(
                                    color: AppColors.gold,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2,
                                    shadows: [
                                      Shadow(
                                        color: AppColors.gold
                                            .withValues(alpha: 0.4),
                                        blurRadius: 22,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 1,
                                      color: AppColors.gold
                                          .withValues(alpha: 0.4),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Icon(
                                        Icons.diamond_outlined,
                                        color: AppColors.gold,
                                        size: 12,
                                      ),
                                    ),
                                    Container(
                                      width: 36,
                                      height: 1,
                                      color: AppColors.gold
                                          .withValues(alpha: 0.4),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'A real-time connection to your Masjid',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13.5,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 10,
                                  runSpacing: 6,
                                  children: const [
                                    _FeatureChip('Live Athan'),
                                    _Dot(),
                                    _FeatureChip("Qur'an"),
                                    _Dot(),
                                    _FeatureChip('Prayer Times'),
                                    _Dot(),
                                    _FeatureChip('Community'),
                                  ],
                                ),
                              ],
                            ),
                            PrimaryButton(
                              label: 'Get Started',
                              onPressed: () => context
                                  .push(AppRoutes.onboardingWelcome),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Emblem extends StatelessWidget {
  const _Emblem({required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: controller,
            builder: (_, __) => Transform.rotate(
              angle: controller.value * 2 * math.pi,
              child: CustomPaint(
                size: const Size(220, 220),
                painter: _MandalaPainter(),
              ),
            ),
          ),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [
                  Color(0xFFFFF6D8),
                  Color(0xFFFFE08A),
                  Color(0xFFF6C95C),
                  Color(0xFFC8922E),
                ],
                stops: [0, 0.35, 0.72, 1],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.35),
                  blurRadius: 50,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(28, -22),
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.onbNavyDeep,
              ),
            ),
          ),
          const Icon(Icons.mosque, color: AppColors.navy, size: 52),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textGray,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: 3,
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _BgGlow extends StatelessWidget {
  const _BgGlow();
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -0.4),
          radius: 0.95,
          colors: [
            AppColors.gold.withValues(alpha: 0.10),
            AppColors.onbNavyDeep,
          ],
        ),
      ),
    );
  }
}

class _MandalaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = AppColors.gold.withValues(alpha: 0.35);
    canvas.drawCircle(c, size.width * 0.40, stroke);
    canvas.drawCircle(c, size.width * 0.29, stroke);
    canvas.drawCircle(c, size.width * 0.17, stroke);

    final petal = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6
      ..color = AppColors.gold.withValues(alpha: 0.30);
    for (int i = 0; i < 12; i++) {
      canvas.save();
      canvas.translate(c.dx, c.dy);
      canvas.rotate(i * math.pi / 6);
      final path = Path()
        ..moveTo(0, 0)
        ..cubicTo(-14, -38, -10, -70, 0, -96)
        ..cubicTo(10, -70, 14, -38, 0, 0)
        ..close();
      canvas.drawPath(path, petal);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
