import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/theme/app_theme.dart';
import 'package:deeplink_x_example/use_cases/use_case_support.dart';
import 'package:deeplink_x_example/widgets/blocks.dart';
import 'package:deeplink_x_example/widgets/buttons.dart';
import 'package:deeplink_x_example/widgets/inputs.dart';
import 'package:deeplink_x_example/widgets/screen_header.dart';
import 'package:flutter/material.dart';

/// Demonstrates automatic and manual navigation-app selection.
class MapSelectorPage extends StatefulWidget {
  /// Creates the map-selector use case.
  const MapSelectorPage({this.deeplinkX, super.key});

  /// Optional launcher override used by widget tests.
  final DeeplinkX? deeplinkX;

  @override
  State<MapSelectorPage> createState() => _MapSelectorPageState();
}

class _MapSelectorPageState extends State<MapSelectorPage> {
  late final DeeplinkX _deeplinkX = widget.deeplinkX ?? DeeplinkX();
  final _latitudeController = TextEditingController(text: '35.6892');
  final _longitudeController = TextEditingController(text: '51.3890');

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  Coordinate? _coordinate() {
    final latitude = double.tryParse(_latitudeController.text.trim());
    final longitude = double.tryParse(_longitudeController.text.trim());
    if (latitude == null || longitude == null) {
      showInputError(context, 'Enter valid latitude and longitude values.');
      return null;
    }
    if (latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180) {
      showInputError(context, 'Latitude must be −90…90 and longitude must be −180…180.');
      return null;
    }
    return Coordinate(latitude: latitude, longitude: longitude);
  }

  List<LaunchOption<MapDirectionsWithCoordsAction>> _options(final Coordinate destination) => [
    LaunchOption(
      id: 'google-maps',
      title: 'Google Maps',
      app: GoogleMaps.directionsWithCoords(destination: destination),
      fallbackLabel: 'Google Maps web',
      assetName: 'assets/google_maps.png',
    ),
    LaunchOption(
      id: 'amap',
      title: 'Amap',
      app: Amap.directionsWithCoords(destination: destination),
      fallbackLabel: 'Amap web',
      assetName: 'assets/amap.png',
    ),
    LaunchOption(
      id: 'baidu-maps',
      title: 'Baidu Maps',
      app: BaiduMaps.directionsWithCoords(destination: destination),
      fallbackLabel: 'Baidu Maps web',
      assetName: 'assets/baidu_maps.png',
    ),
    LaunchOption(
      id: 'apple-maps',
      title: 'Apple Maps',
      app: AppleMaps.directionsWithCoords(destination: destination),
      fallbackLabel: 'Apple Maps web',
      assetName: 'assets/apple_maps.png',
    ),
    LaunchOption(
      id: '2gis',
      title: '2GIS',
      app: TwoGis.directionsWithCoords(destination: destination),
      fallbackLabel: '2GIS web',
      assetName: 'assets/2gis.png',
    ),
    LaunchOption(
      id: 'waze',
      title: 'Waze',
      app: Waze.directionsWithCoords(destination: destination),
      fallbackLabel: 'Waze web',
      assetName: 'assets/waze.png',
    ),
    LaunchOption(
      id: 'sygic',
      title: 'Sygic',
      app: Sygic.directionsWithCoords(destination: destination),
      fallbackLabel: 'Sygic website',
      assetName: 'assets/sygic.png',
    ),
    LaunchOption(
      id: 'moovit',
      title: 'Moovit',
      app: Moovit.directionsWithCoords(destination: destination),
      fallbackLabel: 'Moovit web',
      assetName: 'assets/moovit.png',
    ),
    LaunchOption(
      id: 'neshan',
      title: 'Neshan',
      app: Neshan.directionsWithCoords(destination: destination),
      fallbackLabel: 'Neshan web',
      assetName: 'assets/neshan.png',
    ),
    LaunchOption(
      id: 'yandex-maps',
      title: 'Yandex Maps',
      app: YandexMaps.directionsWithCoords(destination: destination),
      fallbackLabel: 'Yandex Maps web',
      assetName: 'assets/yandex_maps.png',
    ),
  ];

  Future<void> _showMaps() async {
    final destination = _coordinate();
    if (destination == null) {
      return;
    }
    final options = _options(destination);
    await showLaunchSelector<MapDirectionsWithCoordsAction>(
      context: context,
      title: 'Choose a navigation app',
      automaticSubtitle: 'Try installed providers in order, then use the first provider’s web fallback.',
      deeplinkX: _deeplinkX,
      options: options,
      onAutomatic:
          () => _deeplinkX.launchMapDirectionsWithCoordsAction(
            actions: options.map((final option) => option.app).toList(),
          ),
      onSelected: _deeplinkX.launchAction,
      pickLabel: 'Or pick a provider',
    );
  }

  @override
  Widget build(final BuildContext context) {
    final palette = context.palette;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ScreenHeader(title: 'Map Selector'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
                children: [
                  const TitleBlock(
                    title: 'Navigate to coordinates',
                    description:
                        'Enter a destination, then choose a map provider or let DeeplinkX select automatically.',
                  ),
                  const SizedBox(height: 12),
                  InputsRow(
                    children: [
                      LabeledField(
                        key: const ValueKey('map-latitude'),
                        label: 'Latitude',
                        controller: _latitudeController,
                        fillColor: palette.card,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                      ),
                      LabeledField(
                        key: const ValueKey('map-longitude'),
                        label: 'Longitude',
                        controller: _longitudeController,
                        fillColor: palette.card,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AccentButton(
                    key: const ValueKey('open-map-selector'),
                    label: 'Choose navigation app',
                    icon: Icons.directions_rounded,
                    onPressed: _showMaps,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
