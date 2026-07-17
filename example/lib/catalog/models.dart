import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Section a catalog entry belongs to.
enum CatalogCategory {
  /// Social and communication apps.
  social,

  /// Maps and navigation apps.
  maps,

  /// App stores.
  stores,
}

/// Validation applied to an [ActionField] before launching.
enum FieldValidator {
  /// Value must parse as a latitude between -90 and 90.
  latitude,

  /// Value must parse as a longitude between -180 and 180.
  longitude,
}

/// Declarative description of one text input of an [ActionSpec].
class ActionField {
  /// Creates a field description.
  const ActionField({
    required this.key,
    required this.label,
    this.defaultValue = '',
    this.placeholder,
    this.optional = false,
    this.validator,
  });

  /// Identifier used to read the field's value inside builders.
  final String key;

  /// User-facing label, rendered uppercase.
  final String label;

  /// Initial text.
  final String defaultValue;

  /// Optional hint shown while the field is empty.
  final String? placeholder;

  /// Whether the field may be left empty.
  final bool optional;

  /// Optional value validation.
  final FieldValidator? validator;
}

/// Read-only view over the entered field values, keyed by [ActionField.key].
class ActionValues {
  /// Creates a view over the given raw field values.
  const ActionValues(this._values);

  final Map<String, String> _values;

  /// The trimmed value for [key] (empty string when absent).
  String value(final String key) => (_values[key] ?? '').trim();

  /// The trimmed value for [key], or null when empty.
  String? optionalValue(final String key) {
    final text = value(key);
    return text.isEmpty ? null : text;
  }

  /// Builds a [Coordinate] from two required numeric fields.
  Coordinate coordinate(final String latKey, final String lngKey) =>
      Coordinate(latitude: double.parse(value(latKey)), longitude: double.parse(value(lngKey)));

  /// Builds a [Coordinate] when both fields are filled, or null otherwise.
  Coordinate? optionalCoordinate(final String latKey, final String lngKey) {
    if (optionalValue(latKey) == null || optionalValue(lngKey) == null) {
      return null;
    }
    return coordinate(latKey, lngKey);
  }
}

/// Cross-field check ensuring an optional coordinate pair is filled together.
String? validateOptionalPair(final ActionValues values, final String latKey, final String lngKey, final String label) {
  final hasLat = values.optionalValue(latKey) != null;
  final hasLng = values.optionalValue(lngKey) != null;
  if (hasLat != hasLng) {
    return 'Enter both $label latitude and longitude, or leave both empty.';
  }
  return null;
}

/// Builds the launchable object for an [ActionSpec].
sealed class ActionRunner {
  const ActionRunner();
}

/// Runner for whole-app "Open app" actions, launched via `DeeplinkX.launchApp`.
class OpenAppRunner extends ActionRunner {
  /// Creates an open-app runner.
  const OpenAppRunner(this.build);

  /// Builds the [App] to launch. Store builders ignore [build]'s flag.
  final App Function({required bool fallbackToStore}) build;
}

/// Runner for typed deeplink actions, launched via `DeeplinkX.launchAction`.
class AppActionRunner extends ActionRunner {
  /// Creates an app-action runner.
  const AppActionRunner(this.build);

  /// Builds the [AppAction] to launch from the entered values.
  final AppAction Function(ActionValues values, {required bool fallbackToStore}) build;
}

/// Declarative description of one action card on a detail screen.
class ActionSpec {
  /// Creates an action description.
  const ActionSpec({
    required this.icon,
    required this.title,
    required this.apiLabel,
    required this.buttonLabel,
    required this.runner,
    this.fields = const [],
    this.validate,
  });

  /// Leading icon.
  final IconData icon;

  /// Card title.
  final String title;

  /// Exact public API signature shown under the title.
  final String apiLabel;

  /// Caption of the run button.
  final String buttonLabel;

  /// Builds the launchable object.
  final ActionRunner runner;

  /// Input fields, in display order.
  final List<ActionField> fields;

  /// Optional cross-field validation; returns an error message or null.
  final String? Function(ActionValues values)? validate;
}

/// Declarative description of one app or store in the example gallery.
class AppSpec {
  /// Creates an app description.
  const AppSpec({
    required this.id,
    required this.name,
    required this.assetName,
    required this.category,
    required this.actions,
  });

  /// Stable identifier.
  final String id;

  /// Display name.
  final String name;

  /// Bundled logo asset path.
  final String assetName;

  /// Gallery section.
  final CatalogCategory category;

  /// Action cards on the detail screen, first action rendered filled.
  final List<ActionSpec> actions;

  /// Detail-screen subtitle.
  String get tagline {
    final count = '${actions.length} ${actions.length == 1 ? 'action' : 'actions'}';
    return category == CatalogCategory.stores ? '$count · store deeplinks' : '$count · native + web fallbacks';
  }
}
