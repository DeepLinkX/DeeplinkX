import 'package:flutter/material.dart';

/// Design palette shared by every screen of the example app.
///
/// Tokens mirror the "DeeplinkX App" design file: surfaces (`desk`, `bg`,
/// `card`, `well`), typography colors (`text`, `sub`, `faint`), separators
/// (`line`, `chev`, `frame`), and the accent family.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  /// Creates a palette with every design token.
  const AppPalette({
    required this.desk,
    required this.bg,
    required this.frame,
    required this.card,
    required this.well,
    required this.text,
    required this.sub,
    required this.faint,
    required this.line,
    required this.chev,
    required this.accent,
    required this.accentFg,
    required this.accentSoft,
    required this.snackBg,
    required this.snackFg,
  });

  /// Light palette from the design file.
  static const AppPalette light = AppPalette(
    desk: Color(0xFFE8E6E1),
    bg: Color(0xFFF3F4F6),
    frame: Color(0x0F000000),
    card: Color(0xFFFFFFFF),
    well: Color(0xFFF3F4F6),
    text: Color(0xFF16202B),
    sub: Color(0xFF66707C),
    faint: Color(0xFF8A96A3),
    line: Color(0xFFF0F2F4),
    chev: Color(0xFFC3CAD2),
    accent: Color(0xFF2E7CF6),
    accentFg: Color(0xFF2E7CF6),
    accentSoft: Color(0xFFEAF1FE),
    snackBg: Color(0xFF16202B),
    snackFg: Color(0xFFFFFFFF),
  );

  /// Dark palette from the design file.
  static const AppPalette dark = AppPalette(
    desk: Color(0xFF0A0E14),
    bg: Color(0xFF10161D),
    frame: Color(0x12FFFFFF),
    card: Color(0xFF1A222C),
    well: Color(0xFF242E3A),
    text: Color(0xFFECF1F6),
    sub: Color(0xFF9AA5B1),
    faint: Color(0xFF6B7684),
    line: Color(0xFF232D38),
    chev: Color(0xFF3F4B58),
    accent: Color(0xFF2E7CF6),
    accentFg: Color(0xFF4D8DF8),
    accentSoft: Color(0xFF1B2A42),
    snackBg: Color(0xFFECF1F6),
    snackFg: Color(0xFF16202B),
  );

  /// Status-dot color for an installed app.
  static const Color statusInstalled = Color(0xFF34A853);

  /// Status-dot color for an app that is not installed.
  static const Color statusMissing = Color(0xFFC3CAD2);

  /// Status-dot color for an app without native support on this platform.
  static const Color statusUnsupported = Color(0xFFE8B93C);

  /// Desk background behind the phone frame on wide viewports.
  final Color desk;

  /// Screen background.
  final Color bg;

  /// Hairline border around the phone frame.
  final Color frame;

  /// Card surface.
  final Color card;

  /// Inset field/well surface inside cards.
  final Color well;

  /// Primary text.
  final Color text;

  /// Secondary text.
  final Color sub;

  /// Tertiary/faint text and labels.
  final Color faint;

  /// Row separators.
  final Color line;

  /// Chevrons, drag handles, and disabled toggles.
  final Color chev;

  /// Accent fill (buttons, active chips, toggles).
  final Color accent;

  /// Accent foreground (links and icons on soft surfaces).
  final Color accentFg;

  /// Soft accent surface behind accent icons.
  final Color accentSoft;

  /// Snackbar background.
  final Color snackBg;

  /// Snackbar foreground.
  final Color snackFg;

  @override
  AppPalette copyWith({
    final Color? desk,
    final Color? bg,
    final Color? frame,
    final Color? card,
    final Color? well,
    final Color? text,
    final Color? sub,
    final Color? faint,
    final Color? line,
    final Color? chev,
    final Color? accent,
    final Color? accentFg,
    final Color? accentSoft,
    final Color? snackBg,
    final Color? snackFg,
  }) => AppPalette(
    desk: desk ?? this.desk,
    bg: bg ?? this.bg,
    frame: frame ?? this.frame,
    card: card ?? this.card,
    well: well ?? this.well,
    text: text ?? this.text,
    sub: sub ?? this.sub,
    faint: faint ?? this.faint,
    line: line ?? this.line,
    chev: chev ?? this.chev,
    accent: accent ?? this.accent,
    accentFg: accentFg ?? this.accentFg,
    accentSoft: accentSoft ?? this.accentSoft,
    snackBg: snackBg ?? this.snackBg,
    snackFg: snackFg ?? this.snackFg,
  );

  @override
  AppPalette lerp(final ThemeExtension<AppPalette>? other, final double t) {
    if (other is! AppPalette) {
      return this;
    }
    return AppPalette(
      desk: Color.lerp(desk, other.desk, t)!,
      bg: Color.lerp(bg, other.bg, t)!,
      frame: Color.lerp(frame, other.frame, t)!,
      card: Color.lerp(card, other.card, t)!,
      well: Color.lerp(well, other.well, t)!,
      text: Color.lerp(text, other.text, t)!,
      sub: Color.lerp(sub, other.sub, t)!,
      faint: Color.lerp(faint, other.faint, t)!,
      line: Color.lerp(line, other.line, t)!,
      chev: Color.lerp(chev, other.chev, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentFg: Color.lerp(accentFg, other.accentFg, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      snackBg: Color.lerp(snackBg, other.snackBg, t)!,
      snackFg: Color.lerp(snackFg, other.snackFg, t)!,
    );
  }
}

/// Convenient palette lookup with a light fallback so widgets keep working
/// under bare test `MaterialApp`s that do not install the extension.
extension PaletteX on BuildContext {
  /// The active [AppPalette], falling back to [AppPalette.light].
  AppPalette get palette => Theme.of(this).extension<AppPalette>() ?? AppPalette.light;
}

/// Builds the example [ThemeData] for the given [brightness].
ThemeData buildTheme(final Brightness brightness) {
  final palette = brightness == Brightness.dark ? AppPalette.dark : AppPalette.light;
  final colorScheme = ColorScheme.fromSeed(seedColor: palette.accent, brightness: brightness).copyWith(
    primary: palette.accent,
    onPrimary: Colors.white,
    secondary: palette.accentFg,
    surface: palette.card,
    onSurface: palette.text,
    surfaceContainerHighest: palette.well,
    onSurfaceVariant: palette.sub,
    outline: palette.chev,
  );
  return ThemeData(
    useMaterial3: true,
    fontFamily: 'InstrumentSans',
    colorScheme: colorScheme,
    scaffoldBackgroundColor: palette.bg,
    dividerColor: palette.line,
    dividerTheme: DividerThemeData(color: palette.line, thickness: 1, space: 1),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: palette.snackBg,
      contentTextStyle: TextStyle(
        fontFamily: 'InstrumentSans',
        fontSize: 12.5,
        fontWeight: FontWeight.w500,
        color: palette.snackFg,
      ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(11))),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: palette.bg,
      modalBackgroundColor: palette.bg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      clipBehavior: Clip.antiAlias,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: palette.accent),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: palette.accent,
      selectionColor: palette.accentSoft,
      selectionHandleColor: palette.accent,
    ),
    extensions: [palette],
  );
}

/// Holds the app-wide [ThemeMode] and implements the header toggle.
class ThemeController extends ValueNotifier<ThemeMode> {
  /// Creates a controller that follows the system theme until toggled.
  ThemeController() : super(ThemeMode.system);

  /// The brightness currently in effect for [context].
  Brightness effectiveBrightness(final BuildContext context) => switch (value) {
    ThemeMode.light => Brightness.light,
    ThemeMode.dark => Brightness.dark,
    ThemeMode.system => MediaQuery.platformBrightnessOf(context),
  };

  /// Switches to the opposite of the brightness currently in effect.
  void toggle(final BuildContext context) {
    value = effectiveBrightness(context) == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
  }
}
