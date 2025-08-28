import 'dart:async';

import 'package:deeplink_x_example/home.dart';
import 'package:flutter/material.dart';

/// Splash screen that displays the DeeplinkX logo before showing the home page.
class SplashPage extends StatefulWidget {
  /// Creates the splash page.
  const SplashPage({super.key});

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
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(body: Center(child: Image.asset('assets/deeplink_x_logo.jpg')));
}
