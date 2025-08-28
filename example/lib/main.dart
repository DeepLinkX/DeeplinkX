import 'package:deeplink_x_example/splash.dart';
import 'package:flutter/material.dart';

/// Entry point for the DeeplinkX example application.
void main() {
  runApp(const MyApp());
}

/// Root widget that sets up theming and the initial page.
class MyApp extends StatelessWidget {
  /// Creates the app widget.
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) =>
      MaterialApp(title: 'DeeplinkX Example', theme: ThemeData(useMaterial3: true), home: const SplashPage());
}
