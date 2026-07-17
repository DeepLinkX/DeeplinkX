import 'package:flutter/material.dart';

/// Rounded square surface holding an icon or logo, per the design file.
class IconBox extends StatelessWidget {
  /// Creates an icon box.
  const IconBox({required this.size, required this.radius, required this.color, required this.child, super.key});

  /// Width and height of the box.
  final double size;

  /// Corner radius of the box.
  final double radius;

  /// Background color of the box.
  final Color color;

  /// Centered content, typically an [Icon] or [AssetLogo].
  final Widget child;

  @override
  Widget build(final BuildContext context) => SizedBox.square(
    dimension: size,
    child: DecoratedBox(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(radius)),
      child: Center(child: child),
    ),
  );
}

/// Bundled logo image with a graceful broken-image fallback.
class AssetLogo extends StatelessWidget {
  /// Creates a logo image of [size].
  const AssetLogo({required this.assetName, required this.size, super.key});

  /// Bundled asset path, e.g. `assets/telegram.png`.
  final String assetName;

  /// Width and height of the logo.
  final double size;

  @override
  Widget build(final BuildContext context) => Image.asset(
    assetName,
    width: size,
    height: size,
    fit: BoxFit.contain,
    errorBuilder: (final context, final error, final stackTrace) => Icon(Icons.broken_image_rounded, size: size),
  );
}
