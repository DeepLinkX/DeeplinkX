import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Home section title with a trailing "View all N" link.
class SectionHeader extends StatelessWidget {
  /// Creates a section header.
  const SectionHeader({required this.title, required this.linkLabel, required this.onLinkTap, super.key});

  /// Section title.
  final String title;

  /// Trailing link caption, e.g. `View all 23`.
  final String linkLabel;

  /// Link tap handler.
  final VoidCallback onLinkTap;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(
            child: Text(title, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: palette.text)),
          ),
          InkWell(
            onTap: onLinkTap,
            borderRadius: BorderRadius.circular(6),
            child: Text(
              linkLabel,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: palette.accentFg),
            ),
          ),
        ],
      ),
    );
  }
}
