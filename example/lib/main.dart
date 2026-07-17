import 'package:deeplink_x_example/splash.dart';
import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:deeplink_x_example/widgets/desk_frame.dart';
import 'package:flutter/material.dart';

/// Entry point for the DeeplinkX example application.
void main() {
  runApp(const MyApp());
}

/// Root widget that sets up theming and the initial page.
class MyApp extends StatefulWidget {
  /// Creates the app widget.
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController _themeController = ThemeController();

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => ValueListenableBuilder<ThemeMode>(
    valueListenable: _themeController,
    builder:
        (final context, final themeMode, _) => MaterialApp(
          title: 'DeeplinkX Example',
          debugShowCheckedModeBanner: false,
          theme: buildTheme(Brightness.light),
          darkTheme: buildTheme(Brightness.dark),
          themeMode: themeMode,
          builder: (final context, final child) => DeskFrame(child: child ?? const SizedBox.shrink()),
          home: SplashPage(themeController: _themeController),
        ),
  );
}
