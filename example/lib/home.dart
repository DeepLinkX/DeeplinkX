import 'package:deeplink_x_example/catalog/catalog.dart';
import 'package:deeplink_x_example/catalog/detail_page.dart';
import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:deeplink_x_example/use_cases/about_support_page.dart';
import 'package:deeplink_x_example/use_cases/fallback_playground_page.dart';
import 'package:deeplink_x_example/use_cases/installed_apps_page.dart';
import 'package:deeplink_x_example/use_cases/map_selector_page.dart';
import 'package:deeplink_x_example/use_cases/meeting_community_page.dart';
import 'package:deeplink_x_example/use_cases/promoted_app_page.dart';
import 'package:deeplink_x_example/use_cases/rate_review_page.dart';
import 'package:deeplink_x_example/use_cases/share_message_page.dart';
import 'package:deeplink_x_example/use_cases/update_app_page.dart';
import 'package:deeplink_x_example/widgets/pill_chip.dart';
import 'package:deeplink_x_example/widgets/screen_header.dart';
import 'package:deeplink_x_example/widgets/section_header.dart';
import 'package:deeplink_x_example/widgets/tiles.dart';
import 'package:flutter/material.dart';

/// Real-world use-case demo entry.
class _UseCaseItem {
  const _UseCaseItem({required this.title, required this.description, required this.icon, required this.builder});

  final String title;
  final String description;
  final IconData icon;
  final WidgetBuilder builder;
}

final _useCases = <_UseCaseItem>[
  _UseCaseItem(
    title: 'Update App',
    description: 'Store selection for app updates',
    icon: Icons.system_update_rounded,
    builder: (_) => const UpdateAppPage(),
  ),
  _UseCaseItem(
    title: 'About & Support',
    description: 'Social links, native + web',
    icon: Icons.contact_support_rounded,
    builder: (_) => const AboutSupportPage(),
  ),
  _UseCaseItem(
    title: 'Map Selector',
    description: 'Directions across 10 providers',
    icon: Icons.map_rounded,
    builder: (_) => const MapSelectorPage(),
  ),
  _UseCaseItem(
    title: 'Rate & Review',
    description: 'Direct rating links',
    icon: Icons.star_rate_rounded,
    builder: (_) => const RateReviewPage(),
  ),
  _UseCaseItem(
    title: 'Share & Message',
    description: 'WhatsApp shares, Telegram messages',
    icon: Icons.share_rounded,
    builder: (_) => const ShareMessagePage(),
  ),
  _UseCaseItem(
    title: 'Installed Apps',
    description: 'Installation checks',
    icon: Icons.install_mobile_rounded,
    builder: (_) => const InstalledAppsPage(),
  ),
  _UseCaseItem(
    title: 'Meeting & Community',
    description: 'Zoom meetings, Slack channels',
    icon: Icons.groups_rounded,
    builder: (_) => const MeetingCommunityPage(),
  ),
  _UseCaseItem(
    title: 'Promoted App CTA',
    description: 'Tracked store redirects',
    icon: Icons.campaign_rounded,
    builder: (_) => const PromotedAppPage(),
  ),
  _UseCaseItem(
    title: 'Fallback Playground',
    description: 'Native, web, store policies',
    icon: Icons.science_rounded,
    builder: (_) => const FallbackPlaygroundPage(),
  ),
];

enum _HomeFilter { useCases, apps, stores }

/// Home gallery listing use cases, apps, and stores with filter chips.
class HomePage extends StatefulWidget {
  /// Creates the home page.
  const HomePage({this.themeController, super.key});

  /// Controller backing the header theme toggle; optional so tests can pump
  /// the page without an app-level controller.
  final ThemeController? themeController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomeFilter? _filter;

  void _toggleFilter(final _HomeFilter filter) => setState(() => _filter = _filter == filter ? null : filter);

  void _open(final WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: builder));
  }

  Brightness _effectiveBrightness() =>
      widget.themeController?.effectiveBrightness(context) ?? Theme.of(context).brightness;

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    final filter = _filter;
    final showHeaders = filter == null;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.asset('assets/deeplink_x_logo.jpg', width: 34, height: 34, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DeeplinkX',
                            style: TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w700,
                              color: palette.text,
                              letterSpacing: -0.2,
                            ),
                          ),
                          Text('Example gallery', style: TextStyle(fontSize: 11.5, color: palette.faint)),
                        ],
                      ),
                    ),
                    HeaderIconButton(
                      icon:
                          _effectiveBrightness() == Brightness.dark
                              ? Icons.light_mode_rounded
                              : Icons.dark_mode_rounded,
                      color: palette.sub,
                      tooltip: 'Toggle theme',
                      onPressed: () => widget.themeController?.toggle(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 16),
                child: Row(
                  children: [
                    PillChip(
                      key: const ValueKey('filter-use-cases'),
                      label: 'Use cases',
                      selected: filter == _HomeFilter.useCases,
                      onTap: () => _toggleFilter(_HomeFilter.useCases),
                    ),
                    const SizedBox(width: 8),
                    PillChip(
                      key: const ValueKey('filter-apps'),
                      label: 'Apps',
                      selected: filter == _HomeFilter.apps,
                      onTap: () => _toggleFilter(_HomeFilter.apps),
                    ),
                    const SizedBox(width: 8),
                    PillChip(
                      key: const ValueKey('filter-stores'),
                      label: 'Stores',
                      selected: filter == _HomeFilter.stores,
                      onTap: () => _toggleFilter(_HomeFilter.stores),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (filter == null || filter == _HomeFilter.useCases) ...[
                      if (showHeaders) ...[
                        SectionHeader(
                          title: 'Use cases',
                          linkLabel: 'View all ${_useCases.length}',
                          onLinkTap: () => _toggleFilter(_HomeFilter.useCases),
                        ),
                        const SizedBox(height: 10),
                      ],
                      _GridRows(
                        columns: 2,
                        children: [
                          for (final useCase in _useCases.take(showHeaders ? 4 : _useCases.length))
                            UseCaseCard(
                              name: useCase.title,
                              description: useCase.description,
                              icon: useCase.icon,
                              onTap: () => _open(useCase.builder),
                            ),
                        ],
                      ),
                      if (filter == null) const SizedBox(height: 20),
                    ],
                    if (filter == null || filter == _HomeFilter.apps) ...[
                      if (showHeaders) ...[
                        SectionHeader(
                          title: 'Apps',
                          linkLabel: 'View all ${catalogApps.length}',
                          onLinkTap: () => _toggleFilter(_HomeFilter.apps),
                        ),
                        const SizedBox(height: 10),
                      ],
                      _GridRows(
                        columns: 4,
                        children: [
                          for (final spec in catalogApps.take(showHeaders ? 8 : catalogApps.length))
                            AppTile(
                              name: spec.name,
                              assetName: spec.assetName,
                              onTap: () => _open((_) => DetailPage(spec: spec)),
                            ),
                        ],
                      ),
                      if (filter == null) const SizedBox(height: 20),
                    ],
                    if (filter == null || filter == _HomeFilter.stores) ...[
                      if (showHeaders) ...[
                        SectionHeader(
                          title: 'Stores',
                          linkLabel: 'View all ${catalogStores.length}',
                          onLinkTap: () => _toggleFilter(_HomeFilter.stores),
                        ),
                        const SizedBox(height: 10),
                      ],
                      _GridRows(
                        columns: 4,
                        children: [
                          for (final spec in catalogStores.take(showHeaders ? 4 : catalogStores.length))
                            AppTile(
                              name: spec.name,
                              assetName: spec.assetName,
                              onTap: () => _open((_) => DetailPage(spec: spec)),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fixed-column grid built from rows so tiles keep their natural height and
/// stay equal-height per row on any viewport width.
class _GridRows extends StatelessWidget {
  const _GridRows({required this.columns, required this.children});

  final int columns;
  final List<Widget> children;

  @override
  Widget build(final BuildContext context) {
    final rows = <Widget>[];
    for (var start = 0; start < children.length; start += columns) {
      if (start > 0) {
        rows.add(const SizedBox(height: 10));
      }
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var column = 0; column < columns; column++) ...[
                if (column > 0) const SizedBox(width: 10),
                Expanded(child: start + column < children.length ? children[start + column] : const SizedBox.shrink()),
              ],
            ],
          ),
        ),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }
}
