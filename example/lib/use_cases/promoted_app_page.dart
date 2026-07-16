import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:flutter/material.dart';

/// Demonstrates a tracked promoted-app call to action.
class PromotedAppPage extends StatefulWidget {
  /// Creates the promoted-app use case.
  const PromotedAppPage({this.deeplinkX, super.key});

  /// Optional launcher override used by widget tests.
  final DeeplinkX? deeplinkX;

  @override
  State<PromotedAppPage> createState() => _PromotedAppPageState();
}

class _PromotedAppPageState extends State<PromotedAppPage> {
  late final DeeplinkX _deeplinkX = widget.deeplinkX ?? DeeplinkX();
  late final List<StoreOpenAppPageAction> _actions = [
    PlayStore.openAppPage(
      packageName: 'com.instagram.android',
      referrer: 'utm_source=deeplink_x&utm_medium=example&utm_campaign=summer_launch',
    ),
    IOSAppStore.openAppPage(
      appId: '389801252',
      appName: 'instagram',
      campaignToken: 'deeplink_x_example',
      providerToken: 'example_provider',
      affiliateToken: 'example_affiliate',
      uniqueOrigin: 'use_cases',
    ),
  ];
  bool _launching = false;

  Future<void> _openPromotion() async {
    if (_launching) {
      return;
    }
    setState(() => _launching = true);
    final result = await _deeplinkX.redirectToStore(storeActions: _actions);
    if (!mounted) {
      return;
    }
    setState(() => _launching = false);
    showLaunchResult(context, succeeded: result);
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Promoted App CTA')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ColoredBox(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Row(
                    children: [
                      const UseCaseLeading(assetName: 'assets/instagram.png', size: 72),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Discover Instagram', style: Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: 6),
                            const Text('A tracked store CTA without platform branches in the widget.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: FilledButton.icon(
                  key: const ValueKey('open-promoted-app'),
                  onPressed: _launching ? null : _openPromotion,
                  icon:
                      _launching
                          ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.campaign),
                  label: const Text('View in store'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Google Play receives a referrer; the iOS App Store receives campaign, provider, affiliate, and origin tokens.',
        ),
      ],
    ),
  );
}
