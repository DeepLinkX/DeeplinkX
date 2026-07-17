import 'dart:async';

import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/catalog/models.dart';
import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:deeplink_x_example/widgets/buttons.dart';
import 'package:deeplink_x_example/widgets/fallback_pill.dart';
import 'package:deeplink_x_example/widgets/icon_box.dart';
import 'package:deeplink_x_example/widgets/inputs.dart';
import 'package:deeplink_x_example/widgets/list_row.dart';
import 'package:deeplink_x_example/widgets/screen_header.dart';
import 'package:flutter/material.dart';

/// Detail screen rendering every action of a catalog [AppSpec].
class DetailPage extends StatefulWidget {
  /// Creates a detail page for [spec].
  const DetailPage({required this.spec, this.deeplinkX, super.key});

  /// The app or store to present.
  final AppSpec spec;

  /// Injectable DeeplinkX instance, used by tests.
  final DeeplinkX? deeplinkX;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final DeeplinkX _deeplinkX = widget.deeplinkX ?? DeeplinkX();
  final Map<String, TextEditingController> _controllers = {};
  bool _fallbackToStore = true;
  UseCaseAvailability _availability = UseCaseAvailability.loading;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.spec.actions.length; i++) {
      for (final field in widget.spec.actions[i].fields) {
        _controllers[_controllerKey(i, field)] = TextEditingController(text: field.defaultValue);
      }
    }
    unawaited(_checkAvailability());
  }

  /// The plain app instance behind this spec's "Open app" action, used for
  /// the installation indicator.
  App? _availabilityTarget() {
    for (final action in widget.spec.actions) {
      final runner = action.runner;
      if (runner is OpenAppRunner) {
        return runner.build(fallbackToStore: false);
      }
    }
    return null;
  }

  Future<void> _checkAvailability() async {
    final app = _availabilityTarget();
    if (app == null) {
      return;
    }
    final availability =
        !app.supportedPlatforms.contains(_deeplinkX.currentPlatform)
            ? UseCaseAvailability.unsupported
            : await _deeplinkX.isAppInstalled(app)
            ? UseCaseAvailability.installed
            : UseCaseAvailability.notInstalled;
    if (!mounted) {
      return;
    }
    setState(() => _availability = availability);
  }

  String get _statusLabel => switch (_availability) {
    UseCaseAvailability.loading => 'Checking…',
    UseCaseAvailability.installed => 'Installed',
    UseCaseAvailability.notInstalled => 'Not installed',
    UseCaseAvailability.unsupported => 'Unsupported on ${_deeplinkX.currentPlatform.value}',
  };

  Color? get _statusDotColor => switch (_availability) {
    UseCaseAvailability.loading => null,
    UseCaseAvailability.installed => AppPalette.statusInstalled,
    UseCaseAvailability.notInstalled => AppPalette.statusMissing,
    UseCaseAvailability.unsupported => AppPalette.statusUnsupported,
  };

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String _controllerKey(final int actionIndex, final ActionField field) => '$actionIndex-${field.key}';

  TextEditingController _controller(final int actionIndex, final ActionField field) =>
      _controllers[_controllerKey(actionIndex, field)]!;

  Future<void> _run(final int actionIndex) async {
    final action = widget.spec.actions[actionIndex];
    final rawValues = <String, String>{};
    for (final field in action.fields) {
      final text = _controller(actionIndex, field).text.trim();
      if (text.isEmpty) {
        if (!field.optional) {
          showInputError(context, 'Enter ${field.label.toLowerCase()}.');
          return;
        }
        rawValues[field.key] = '';
        continue;
      }
      switch (field.validator) {
        case FieldValidator.latitude:
          final latitude = double.tryParse(text);
          if (latitude == null || latitude < -90 || latitude > 90) {
            showInputError(context, 'Latitude must be between -90 and 90.');
            return;
          }
        case FieldValidator.longitude:
          final longitude = double.tryParse(text);
          if (longitude == null || longitude < -180 || longitude > 180) {
            showInputError(context, 'Longitude must be between -180 and 180.');
            return;
          }
        case null:
          break;
      }
      rawValues[field.key] = text;
    }
    final values = ActionValues(rawValues);
    final crossFieldError = action.validate?.call(values);
    if (crossFieldError != null) {
      showInputError(context, crossFieldError);
      return;
    }
    final succeeded = switch (action.runner) {
      final OpenAppRunner runner => await _deeplinkX.launchApp(runner.build(fallbackToStore: _fallbackToStore)),
      final AppActionRunner runner => await _deeplinkX.launchAction(
        runner.build(values, fallbackToStore: _fallbackToStore),
      ),
    };
    if (!mounted) {
      return;
    }
    showActionResult(context, succeeded: succeeded, apiLabel: action.apiLabel, fallbackEnabled: _fallbackToStore);
  }

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    final spec = widget.spec;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(
              title: spec.name,
              trailing: FallbackPill(
                value: _fallbackToStore,
                onChanged: (final value) => setState(() => _fallbackToStore = value),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 4, 2, 6),
                      child: Row(
                        children: [
                          IconBox(
                            size: 52,
                            radius: 14,
                            color: palette.card,
                            child: AssetLogo(assetName: spec.assetName, size: 32),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  spec.name,
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    fontWeight: FontWeight.w700,
                                    color: palette.text,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(spec.tagline, style: TextStyle(fontSize: 12, color: palette.faint)),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    if (_statusDotColor != null) ...[
                                      StatusDot(color: _statusDotColor!, size: 7),
                                      const SizedBox(width: 6),
                                    ],
                                    Text(
                                      _statusLabel,
                                      style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: palette.sub),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (var i = 0; i < spec.actions.length; i++) ...[
                      const SizedBox(height: 12),
                      _ActionCard(
                        action: spec.actions[i],
                        filled: i == 0,
                        controllerOf: (final field) => _controller(i, field),
                        onRun: () => _run(i),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.action, required this.filled, required this.controllerOf, required this.onRun});

  final ActionSpec action;
  final bool filled;
  final TextEditingController Function(ActionField field) controllerOf;
  final VoidCallback onRun;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(color: palette.card, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconBox(
                  size: 38,
                  radius: 11,
                  color: palette.accentSoft,
                  child: Icon(action.icon, size: 19, color: palette.accentFg),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        action.title,
                        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: palette.text),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        action.apiLabel,
                        style: TextStyle(
                          fontSize: 10.5,
                          color: palette.faint,
                          fontFamily: 'Menlo',
                          fontFamilyFallback: const ['Courier New', 'monospace'],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            for (final field in action.fields) ...[
              const SizedBox(height: 13),
              LabeledField(label: field.label, controller: controllerOf(field), placeholder: field.placeholder),
            ],
            const SizedBox(height: 13),
            AccentButton(label: action.buttonLabel, filled: filled, dense: true, onPressed: onRun),
          ],
        ),
      ),
    );
  }
}
