import 'dart:async';

import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:flutter/material.dart';

/// Preset actions available in the fallback playground.
enum FallbackPreset {
  /// Telegram public profile action.
  telegram('Telegram profile'),

  /// Instagram public profile action.
  instagram('Instagram profile'),

  /// Google Maps coordinate action.
  googleMaps('Google Maps location');

  const FallbackPreset(this.label);

  /// User-facing label.
  final String label;
}

/// Fallback policies demonstrated by the playground.
enum FallbackPolicy {
  /// Attempt only the native action.
  disabled('Disabled'),

  /// Fall back directly to the action's website.
  web('Web'),

  /// Try the store before the action's website.
  storeThenWeb('Store then web');

  const FallbackPolicy(this.label);

  /// User-facing label.
  final String label;
}

/// Demonstrates the observable effect of fallback configuration.
class FallbackPlaygroundPage extends StatefulWidget {
  /// Creates the fallback playground.
  const FallbackPlaygroundPage({this.deeplinkX, super.key});

  /// Optional launcher override used by widget tests.
  final DeeplinkX? deeplinkX;

  @override
  State<FallbackPlaygroundPage> createState() => _FallbackPlaygroundPageState();
}

class _FallbackPlaygroundPageState extends State<FallbackPlaygroundPage> {
  late final DeeplinkX _deeplinkX = widget.deeplinkX ?? DeeplinkX();
  FallbackPreset _preset = FallbackPreset.telegram;
  FallbackPolicy _policy = FallbackPolicy.web;
  UseCaseAvailability _availability = UseCaseAvailability.loading;
  bool _launching = false;
  bool? _lastResult;

  @override
  void initState() {
    super.initState();
    unawaited(_checkAvailability());
  }

  _FallbackTarget _target() {
    final storeFallback = _policy == FallbackPolicy.storeThenWeb;
    switch (_preset) {
      case FallbackPreset.telegram:
        final action = Telegram.openProfile(username: 'durov', fallbackToStore: storeFallback);
        return _FallbackTarget(action, action);
      case FallbackPreset.instagram:
        final action = Instagram.openProfile(username: 'instagram', fallbackToStore: storeFallback);
        return _FallbackTarget(action, action);
      case FallbackPreset.googleMaps:
        final action = GoogleMaps.view(
          coordinate: const Coordinate(latitude: 35.6892, longitude: 51.3890),
          fallbackToStore: storeFallback,
        );
        return _FallbackTarget(action, action);
    }
  }

  Future<void> _checkAvailability() async {
    setState(() => _availability = UseCaseAvailability.loading);
    final target = _target();
    final availability =
        !target.app.supportedPlatforms.contains(_deeplinkX.currentPlatform)
            ? UseCaseAvailability.unsupported
            : await _deeplinkX.isAppInstalled(target.app)
            ? UseCaseAvailability.installed
            : UseCaseAvailability.notInstalled;
    if (!mounted) {
      return;
    }
    setState(() => _availability = availability);
  }

  Future<void> _launch() async {
    if (_launching) {
      return;
    }
    setState(() => _launching = true);
    final target = _target();
    final result = await _deeplinkX.launchAction(target.action, disableFallback: _policy == FallbackPolicy.disabled);
    if (!mounted) {
      return;
    }
    setState(() {
      _launching = false;
      _lastResult = result;
    });
    showLaunchResult(context, succeeded: result);
  }

  String get _availabilityLabel => switch (_availability) {
    UseCaseAvailability.loading => 'Checking…',
    UseCaseAvailability.installed => 'Installed',
    UseCaseAvailability.notInstalled => 'Not installed',
    UseCaseAvailability.unsupported => 'Not native on this platform',
  };

  String get _policyDescription => switch (_policy) {
    FallbackPolicy.disabled => 'Only the native action is attempted.',
    FallbackPolicy.web => 'The action’s web URL is used when native launch fails.',
    FallbackPolicy.storeThenWeb => 'The matching store is tried before the action’s web URL.',
  };

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Fallback Playground')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        DropdownButtonFormField<FallbackPreset>(
          key: const ValueKey('fallback-preset'),
          initialValue: _preset,
          decoration: const InputDecoration(labelText: 'Action preset', border: OutlineInputBorder()),
          items: [
            for (final preset in FallbackPreset.values) DropdownMenuItem(value: preset, child: Text(preset.label)),
          ],
          onChanged:
              _launching
                  ? null
                  : (final preset) {
                    if (preset == null) {
                      return;
                    }
                    setState(() {
                      _preset = preset;
                      _lastResult = null;
                    });
                    unawaited(_checkAvailability());
                  },
        ),
        const SizedBox(height: 20),
        Text('Fallback policy', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SegmentedButton<FallbackPolicy>(
          key: const ValueKey('fallback-policy'),
          segments: [
            for (final policy in FallbackPolicy.values)
              ButtonSegment(value: policy, label: Text(policy.label), icon: Icon(_policyIcon(policy))),
          ],
          selected: {_policy},
          showSelectedIcon: false,
          onSelectionChanged:
              _launching
                  ? null
                  : (final policies) {
                    setState(() {
                      _policy = policies.single;
                      _lastResult = null;
                    });
                  },
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatusRow(label: 'Platform', value: _deeplinkX.currentPlatform.value),
                _StatusRow(label: 'Native status', value: _availabilityLabel),
                _StatusRow(label: 'Configured policy', value: _policy.label),
                _StatusRow(
                  label: 'Last result',
                  value:
                      _lastResult == null
                          ? 'Not launched'
                          : _lastResult!
                          ? 'Success'
                          : 'Failure',
                ),
                const SizedBox(height: 8),
                Text(_policyDescription),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          key: const ValueKey('launch-fallback-preset'),
          onPressed: _launching ? null : _launch,
          icon:
              _launching
                  ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.rocket_launch),
          label: const Text('Launch configured action'),
        ),
        const SizedBox(height: 12),
        const Text(
          'DeeplinkX returns a final boolean; this page does not infer which internal launch stage succeeded.',
        ),
      ],
    ),
  );

  IconData _policyIcon(final FallbackPolicy policy) => switch (policy) {
    FallbackPolicy.disabled => Icons.block,
    FallbackPolicy.web => Icons.language,
    FallbackPolicy.storeThenWeb => Icons.store,
  };
}

class _FallbackTarget {
  const _FallbackTarget(this.app, this.action);

  final App app;
  final AppAction action;
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
        Expanded(child: Text(value, textAlign: TextAlign.end)),
      ],
    ),
  );
}
