import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:deeplink_x_example/widgets/buttons.dart';
import 'package:deeplink_x_example/widgets/icon_box.dart';
import 'package:flutter/material.dart';

/// Screen intro block: large title plus supporting description.
class TitleBlock extends StatelessWidget {
  /// Creates a title block.
  const TitleBlock({required this.title, required this.description, super.key});

  /// Block title.
  final String title;

  /// Supporting description.
  final String description;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 2, 2, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: palette.text, letterSpacing: -0.3),
          ),
          const SizedBox(height: 5),
          Text(description, style: TextStyle(fontSize: 13, color: palette.sub, height: 1.5)),
        ],
      ),
    );
  }
}

/// Card surface shared by the block widgets.
class BlockCard extends StatelessWidget {
  /// Creates a block card.
  const BlockCard({required this.child, this.padding = const EdgeInsets.all(17), super.key});

  /// Card content.
  final Widget child;

  /// Inner padding.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: context.palette.card, borderRadius: BorderRadius.circular(16)),
    child: Padding(padding: padding, child: child),
  );
}

/// Hero card: logo box, title, description, and a filled action button.
class HeroCard extends StatelessWidget {
  /// Creates a hero card.
  const HeroCard({
    required this.assetName,
    required this.title,
    required this.description,
    required this.buttonIcon,
    required this.buttonLabel,
    required this.onPressed,
    this.buttonKey,
    super.key,
  });

  /// Bundled logo asset path.
  final String assetName;

  /// Card title.
  final String title;

  /// Card description.
  final String description;

  /// Icon on the action button.
  final IconData buttonIcon;

  /// Caption of the action button.
  final String buttonLabel;

  /// Action-button tap handler.
  final VoidCallback onPressed;

  /// Key for the action button, used by tests.
  final Key? buttonKey;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return BlockCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconBox(size: 52, radius: 14, color: palette.well, child: AssetLogo(assetName: assetName, size: 34)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: palette.text)),
                    const SizedBox(height: 3),
                    Text(description, style: TextStyle(fontSize: 12.5, color: palette.sub, height: 1.4)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AccentButton(key: buttonKey, label: buttonLabel, icon: buttonIcon, onPressed: onPressed),
        ],
      ),
    );
  }
}

/// Centered card: large image, title, description, and an optional button.
class CenterCard extends StatelessWidget {
  /// Creates a centered card.
  const CenterCard({
    required this.assetName,
    required this.title,
    required this.description,
    this.buttonIcon,
    this.buttonLabel,
    this.onPressed,
    this.buttonKey,
    super.key,
  });

  /// Bundled image asset path.
  final String assetName;

  /// Card title.
  final String title;

  /// Card description.
  final String description;

  /// Icon on the optional action button.
  final IconData? buttonIcon;

  /// Caption of the optional action button.
  final String? buttonLabel;

  /// Optional action-button tap handler.
  final VoidCallback? onPressed;

  /// Key for the action button, used by tests.
  final Key? buttonKey;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    final buttonLabel = this.buttonLabel;
    return BlockCard(
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(assetName, width: 76, height: 76, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: palette.text),
          ),
          const SizedBox(height: 5),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.5, color: palette.sub, height: 1.45),
              ),
            ),
          ),
          if (buttonLabel != null && onPressed != null) ...[
            const SizedBox(height: 16),
            AccentButton(key: buttonKey, label: buttonLabel, icon: buttonIcon, onPressed: onPressed!),
          ],
        ],
      ),
    );
  }
}

/// Promo card with a soft accent header band and an action button.
class PromoCard extends StatelessWidget {
  /// Creates a promo card.
  const PromoCard({
    required this.assetName,
    required this.title,
    required this.description,
    required this.buttonIcon,
    required this.buttonLabel,
    required this.onPressed,
    this.buttonKey,
    super.key,
  });

  /// Bundled logo asset path.
  final String assetName;

  /// Card title.
  final String title;

  /// Card description.
  final String description;

  /// Icon on the action button.
  final IconData buttonIcon;

  /// Caption of the action button.
  final String buttonLabel;

  /// Action-button tap handler.
  final VoidCallback onPressed;

  /// Key for the action button, used by tests.
  final Key? buttonKey;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: palette.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ColoredBox(
              color: palette.accentSoft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Row(
                  children: [
                    IconBox(
                      size: 64,
                      radius: 16,
                      color: palette.card,
                      child: AssetLogo(assetName: assetName, size: 42),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: palette.text,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(description, style: TextStyle(fontSize: 12.5, color: palette.sub, height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: AccentButton(key: buttonKey, label: buttonLabel, icon: buttonIcon, onPressed: onPressed),
            ),
          ],
        ),
      ),
    );
  }
}

/// Form card: logo box and title, input fields, and an action button.
class FormCard extends StatelessWidget {
  /// Creates a form card.
  const FormCard({
    required this.assetName,
    required this.title,
    required this.fields,
    required this.buttonIcon,
    required this.buttonLabel,
    required this.onPressed,
    this.buttonKey,
    super.key,
  });

  /// Bundled logo asset path.
  final String assetName;

  /// Card title.
  final String title;

  /// Input fields (typically `LabeledField`s).
  final List<Widget> fields;

  /// Icon on the action button.
  final IconData buttonIcon;

  /// Caption of the action button.
  final String buttonLabel;

  /// Action-button tap handler.
  final VoidCallback onPressed;

  /// Key for the action button, used by tests.
  final Key? buttonKey;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return BlockCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconBox(size: 38, radius: 11, color: palette.well, child: AssetLogo(assetName: assetName, size: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title, style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: palette.text)),
              ),
            ],
          ),
          for (final field in fields) ...[const SizedBox(height: 13), field],
          const SizedBox(height: 13),
          AccentButton(key: buttonKey, label: buttonLabel, icon: buttonIcon, dense: true, onPressed: onPressed),
        ],
      ),
    );
  }
}

/// Row of side-by-side input fields on card surfaces.
class InputsRow extends StatelessWidget {
  /// Creates an inputs row.
  const InputsRow({required this.children, super.key});

  /// Fields to lay out; each is expanded equally.
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) => Row(
    children: [
      for (var i = 0; i < children.length; i++) ...[if (i > 0) const SizedBox(width: 12), Expanded(child: children[i])],
    ],
  );
}

/// Small uppercase section label.
class LabelText extends StatelessWidget {
  /// Creates a section label.
  const LabelText(this.text, {super.key});

  /// Label text, rendered uppercase.
  final String text;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(2, 8, 2, 0),
    child: Text(
      text.toUpperCase(),
      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: context.palette.faint),
    ),
  );
}

/// Faint explanatory footnote.
class NoteText extends StatelessWidget {
  /// Creates a note.
  const NoteText(this.text, {super.key});

  /// Note text.
  final String text;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Text(text, style: TextStyle(fontSize: 12, color: context.palette.faint, height: 1.5)),
  );
}

/// Card wrapping a column of `OptionRow`s.
class RowsCard extends StatelessWidget {
  /// Creates a rows card.
  const RowsCard({required this.children, super.key});

  /// Rows to display.
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) => BlockCard(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
  );
}

/// Card box with a small uppercase label above an arbitrary form control.
class SelectCard extends StatelessWidget {
  /// Creates a select card.
  const SelectCard({required this.label, required this.child, super.key});

  /// Label, rendered uppercase.
  final String label;

  /// The wrapped control (e.g. a dropdown).
  final Widget child;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(color: palette.card, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 9, 13, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, letterSpacing: 0.7, color: palette.faint),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

/// One option in a [SegmentedPills] control.
class SegmentedPillOption {
  /// Creates a segment option.
  const SegmentedPillOption({required this.icon, required this.label, required this.selected, required this.onTap});

  /// Segment icon.
  final IconData icon;

  /// Segment caption.
  final String label;

  /// Whether this segment is active.
  final bool selected;

  /// Tap handler.
  final VoidCallback onTap;
}

/// Segmented control rendered as accent pills on a card surface.
class SegmentedPills extends StatelessWidget {
  /// Creates a segmented control.
  const SegmentedPills({required this.options, super.key});

  /// The segments.
  final List<SegmentedPillOption> options;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(color: palette.card, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            for (var i = 0; i < options.length; i++) ...[
              if (i > 0) const SizedBox(width: 6),
              Expanded(
                child: Material(
                  color: options[i].selected ? palette.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  child: InkWell(
                    onTap: options[i].onTap,
                    borderRadius: BorderRadius.circular(9),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(options[i].icon, size: 15, color: options[i].selected ? Colors.white : palette.sub),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              options[i].label,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: options[i].selected ? Colors.white : palette.sub,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// One key/value line in a [StatusCard].
class StatusItem {
  /// Creates a status item.
  const StatusItem({required this.label, required this.value, this.valueColor});

  /// Left-hand label.
  final String label;

  /// Right-hand value.
  final String value;

  /// Optional value color; defaults to the palette's text color.
  final Color? valueColor;
}

/// Card listing key/value status rows separated by hairlines.
class StatusCard extends StatelessWidget {
  /// Creates a status card.
  const StatusCard({required this.items, super.key});

  /// Rows to display.
  final List<StatusItem> items;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return BlockCard(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++)
            DecoratedBox(
              decoration: BoxDecoration(
                border: i < items.length - 1 ? Border(bottom: BorderSide(color: palette.line)) : null,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        items[i].label,
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: palette.sub),
                      ),
                    ),
                    Text(
                      items[i].value,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: items[i].valueColor ?? palette.text,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
