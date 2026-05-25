import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/router.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(const ProviderScope(child: MuslimGuiderApp()));
}

class MuslimGuiderApp extends StatelessWidget {
  const MuslimGuiderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Muslim Guider',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      routerConfig: appRouter,
    );
  }
}
