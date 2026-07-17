import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Presents the app inside a centered phone-like card on wide viewports,
/// matching the design file's desk presentation; passes through untouched on
/// narrow (phone) viewports.
///
/// Installed via `MaterialApp.builder`, so every route, bottom sheet, and
/// snackbar stays inside the frame.
class DeskFrame extends StatelessWidget {
  /// Wraps [child] (the app's navigator) in the desk frame.
  const DeskFrame({required this.child, super.key});

  /// Width at or below which the frame is skipped entirely.
  static const double frameBreakpoint = 520;

  /// The navigator subtree to present.
  final Widget child;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return LayoutBuilder(
      builder: (final context, final constraints) {
        if (constraints.maxWidth <= frameBreakpoint) {
          return child;
        }
        return ColoredBox(
          color: palette.desk,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: palette.frame),
                    boxShadow: const [BoxShadow(color: Color(0x24141C28), blurRadius: 40, offset: Offset(0, 12))],
                  ),
                  child: ClipRRect(borderRadius: BorderRadius.circular(26), child: child),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
