import 'dart:async';

import 'package:deeplink_x_example/home.dart';
import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Splash screen that displays the DeeplinkX logo before showing the home page.
class SplashPage extends StatefulWidget {
  /// Creates the splash page.
  const SplashPage({this.themeController, super.key});

  /// Controller handed to [HomePage] for the header theme toggle.
  final ThemeController? themeController;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute<void>(builder: (_) => HomePage(themeController: widget.themeController)));
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset('assets/deeplink_x_logo.jpg', width: 120, height: 120),
      ),
    ),
  );
}
