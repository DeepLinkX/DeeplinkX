import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:deeplink_x_example/widgets/blocks.dart';
import 'package:deeplink_x_example/widgets/list_row.dart';
import 'package:deeplink_x_example/widgets/screen_header.dart';
import 'package:flutter/material.dart';

/// Demonstrates an about-and-support page backed by social deeplinks.
class AboutSupportPage extends StatefulWidget {
  /// Creates the about-and-support use case.
  const AboutSupportPage({this.deeplinkX, super.key});

  /// Optional launcher override used by widget tests.
  final DeeplinkX? deeplinkX;

  @override
  State<AboutSupportPage> createState() => _AboutSupportPageState();
}

class _AboutSupportPageState extends State<AboutSupportPage> {
  late final DeeplinkX _deeplinkX = widget.deeplinkX ?? DeeplinkX();
  bool _launching = false;

  Future<void> _launch(final AppAction action) async {
    if (_launching) {
      return;
    }
    setState(() => _launching = true);
    final result = await _deeplinkX.launchAction(action);
    if (!mounted) {
      return;
    }
    setState(() => _launching = false);
    showLaunchResult(context, succeeded: result);
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const ScreenHeader(title: 'About & Support'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
              children: [
                const CenterCard(
                  assetName: 'assets/deeplink_x_logo.jpg',
                  title: 'DeeplinkX',
                  description: 'Type-safe external app deeplinks with automatic store and web fallbacks.',
                ),
                const SizedBox(height: 12),
                const LabelText('Public demo destinations'),
                const SizedBox(height: 8),
                const NoteText(
                  'These profiles demonstrate support links; they are not official DeeplinkX support accounts.',
                ),
                const SizedBox(height: 12),
                RowsCard(
                  children: [
                    OptionRow(
                      key: const ValueKey('about-telegram'),
                      title: 'Telegram user',
                      statusText: '@durov',
                      assetName: 'assets/telegram.png',
                      trailingIcon: Icons.open_in_new_rounded,
                      enabled: !_launching,
                      onTap: () => _launch(Telegram.openProfile(username: 'durov')),
                    ),
                    OptionRow(
                      key: const ValueKey('about-instagram'),
                      title: 'Instagram page',
                      statusText: '@instagram',
                      assetName: 'assets/instagram.png',
                      trailingIcon: Icons.open_in_new_rounded,
                      enabled: !_launching,
                      onTap: () => _launch(Instagram.openProfile(username: 'instagram')),
                    ),
                    OptionRow(
                      key: const ValueKey('about-linkedin'),
                      title: 'LinkedIn profile',
                      statusText: 'satyanadella',
                      assetName: 'assets/linkedin.png',
                      trailingIcon: Icons.open_in_new_rounded,
                      enabled: !_launching,
                      showDivider: false,
                      onTap: () => _launch(LinkedIn.openProfile(profileId: 'satyanadella')),
                    ),
                  ],
                ),
                if (_launching)
                  const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
