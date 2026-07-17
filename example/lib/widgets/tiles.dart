import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:deeplink_x_example/widgets/icon_box.dart';
import 'package:flutter/material.dart';

/// Compact logo tile used in the home Apps/Stores grids.
class AppTile extends StatelessWidget {
  /// Creates an app tile.
  const AppTile({required this.name, required this.assetName, required this.onTap, super.key});

  /// App display name.
  final String name;

  /// Bundled logo asset path.
  final String assetName;

  /// Tap handler.
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return Material(
      color: palette.card,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetLogo(assetName: assetName, size: 27),
              const SizedBox(height: 7),
              Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: palette.sub, height: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Use-case card with an accent icon, name, and description.
class UseCaseCard extends StatelessWidget {
  /// Creates a use-case card.
  const UseCaseCard({
    required this.name,
    required this.description,
    required this.icon,
    required this.onTap,
    super.key,
  });

  /// Use-case name.
  final String name;

  /// Short description.
  final String description;

  /// Leading icon.
  final IconData icon;

  /// Tap handler.
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return Material(
      color: palette.card,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconBox(
                size: 34,
                radius: 10,
                color: palette.accentSoft,
                child: Icon(icon, size: 18, color: palette.accentFg),
              ),
              const SizedBox(height: 9),
              Text(
                name,
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: palette.text, height: 1.25),
              ),
              const SizedBox(height: 3),
              Text(description, style: TextStyle(fontSize: 11, color: palette.faint, height: 1.35)),
            ],
          ),
        ),
      ),
    );
  }
}
