import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
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
    appBar: AppBar(title: const Text('About & Support')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset('assets/deeplink_x_logo.jpg', width: 88, height: 88),
                ),
                const SizedBox(height: 16),
                Text('DeeplinkX', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                const Text(
                  'Type-safe external app deeplinks with automatic store and web fallbacks.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text('Public demo destinations', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        const Text('These profiles demonstrate support links; they are not official DeeplinkX support accounts.'),
        const SizedBox(height: 12),
        _SupportTile(
          key: const ValueKey('about-telegram'),
          title: 'Telegram user',
          subtitle: '@durov',
          assetName: 'assets/telegram.png',
          enabled: !_launching,
          onTap: () => _launch(Telegram.openProfile(username: 'durov')),
        ),
        _SupportTile(
          key: const ValueKey('about-instagram'),
          title: 'Instagram page',
          subtitle: '@instagram',
          assetName: 'assets/instagram.png',
          enabled: !_launching,
          onTap: () => _launch(Instagram.openProfile(username: 'instagram')),
        ),
        _SupportTile(
          key: const ValueKey('about-linkedin'),
          title: 'LinkedIn profile',
          subtitle: 'satyanadella',
          assetName: 'assets/linkedin.png',
          enabled: !_launching,
          onTap: () => _launch(LinkedIn.openProfile(profileId: 'satyanadella')),
        ),
        if (_launching) const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
      ],
    ),
  );
}

class _SupportTile extends StatelessWidget {
  const _SupportTile({
    required this.title,
    required this.subtitle,
    required this.assetName,
    required this.enabled,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final String assetName;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) => Card(
    child: ListTile(
      enabled: enabled,
      leading: UseCaseLeading(assetName: assetName),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.open_in_new),
      onTap: onTap,
    ),
  );
}
