import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Yandex Maps.
class YandexMapsPage extends StatefulWidget {
  /// Creates the Yandex Maps example page.
  const YandexMapsPage({super.key});

  @override
  State<YandexMapsPage> createState() => _YandexMapsPageState();
}

class _YandexMapsPageState extends State<YandexMapsPage> {
  final _deeplinkX = DeeplinkX();
  final _searchController = TextEditingController(text: 'cafe with wi-fi');
  final _organizationController = TextEditingController(text: '1221676748');
  var _mode = YandexMapsTravelMode.driving;
  bool _fallback = true;

  static const _center = Coordinate(latitude: 55.753716, longitude: 37.619902);
  static const _destination = Coordinate(latitude: 55.76009, longitude: 37.648801);
  static const _waypoint = Coordinate(latitude: 55.745719, longitude: 37.604337);

  @override
  void dispose() {
    _searchController.dispose();
    _organizationController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Yandex Maps')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Fallback to App Store:'),
              const SizedBox(width: 8),
              Switch(value: _fallback, onChanged: (final value) => setState(() => _fallback = value)),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async => _deeplinkX.launchApp(YandexMaps.open(fallbackToStore: _fallback)),
            child: const Text('Open Yandex Maps'),
          ),
          const SizedBox(height: 24),
          _ActionButton(
            label: 'Open Map',
            onPressed:
                () async => _deeplinkX.launchAction(
                  YandexMaps.openMap(center: _center, zoom: 11, showTraffic: true, fallbackToStore: _fallback),
                ),
          ),
          _ActionButton(
            label: 'View Map',
            onPressed:
                () async =>
                    _deeplinkX.launchAction(YandexMaps.view(coordinate: _center, zoom: 12, fallbackToStore: _fallback)),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(labelText: 'Search query', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          _ActionButton(
            label: 'Search',
            onPressed:
                () async => _deeplinkX.launchAction(
                  YandexMaps.search(
                    query: _searchController.text,
                    center: _center,
                    zoom: 16,
                    fallbackToStore: _fallback,
                  ),
                ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _organizationController,
            decoration: const InputDecoration(labelText: 'Organization ID', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          _ActionButton(
            label: 'Open Organization',
            onPressed:
                () async => _deeplinkX.launchAction(
                  YandexMaps.organization(objectId: _organizationController.text, fallbackToStore: _fallback),
                ),
          ),
          _ActionButton(
            label: 'What Is Here',
            onPressed:
                () async =>
                    _deeplinkX.launchAction(YandexMaps.whatIsHere(coordinate: _center, fallbackToStore: _fallback)),
          ),
          const SizedBox(height: 16),
          DropdownButton<YandexMapsTravelMode>(
            value: _mode,
            isExpanded: true,
            onChanged: (final mode) => setState(() => _mode = mode ?? YandexMapsTravelMode.driving),
            items: const [
              DropdownMenuItem(value: YandexMapsTravelMode.driving, child: Text('Driving')),
              DropdownMenuItem(value: YandexMapsTravelMode.transit, child: Text('Transit')),
              DropdownMenuItem(value: YandexMapsTravelMode.walking, child: Text('Walking')),
            ],
          ),
          _ActionButton(
            label: 'Directions With Coordinates',
            onPressed:
                () async => _deeplinkX.launchAction(
                  YandexMaps.directionsWithCoords(
                    origin: _center,
                    destination: _destination,
                    waypoints: const [YandexMapsWaypoint(coordinate: _waypoint)],
                    mode: _mode,
                    fallbackToStore: _fallback,
                  ),
                ),
          ),
          _ActionButton(
            label: 'Panorama',
            onPressed:
                () async => _deeplinkX.launchAction(
                  YandexMaps.panorama(
                    coordinate: _center,
                    direction: const YandexMapsPanoramaDirection(azimuth: 228.97, elevation: 6.060547),
                    span: const YandexMapsPanoramaSpan(horizontal: 130, vertical: 71.919192),
                    fallbackToStore: _fallback,
                  ),
                ),
          ),
        ],
      ),
    ),
  );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: ElevatedButton(onPressed: onPressed, child: Text(label)),
  );
}
