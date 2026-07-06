import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Baidu Maps.
class BaiduMapsPage extends StatefulWidget {
  /// Creates the Baidu Maps example page.
  const BaiduMapsPage({super.key});

  @override
  State<BaiduMapsPage> createState() => _BaiduMapsPageState();
}

class _BaiduMapsPageState extends State<BaiduMapsPage> {
  final _deeplinkX = DeeplinkX();
  final _latController = TextEditingController(text: '39.915');
  final _lngController = TextEditingController(text: '116.404');
  final _titleController = TextEditingController(text: 'Tiananmen');
  final _searchController = TextEditingController(text: 'coffee');
  final _regionController = TextEditingController(text: 'Beijing');
  final _radiusController = TextEditingController(text: '1000');
  final _lineController = TextEditingController(text: 'Line 1');
  final _originController = TextEditingController(text: 'Beijing Railway Station');
  final _destinationController = TextEditingController(text: 'Tiananmen');
  final _originLatController = TextEditingController(text: '39.9042');
  final _originLngController = TextEditingController(text: '116.4074');
  final _destLatController = TextEditingController(text: '39.915');
  final _destLngController = TextEditingController(text: '116.404');
  var _coordType = BaiduMapsCoordType.bd09ll;
  var _travelMode = BaiduMapsTravelMode.driving;
  var _navigationMode = BaiduMapsNavigationMode.driving;
  bool _fallback = true;
  bool _traffic = false;

  void _showInputError(final String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Coordinate? _coordinate(
    final TextEditingController latController,
    final TextEditingController lngController,
    final String label,
  ) {
    final latitude = double.tryParse(latController.text);
    final longitude = double.tryParse(lngController.text);
    if (latitude == null || longitude == null) {
      _showInputError('Please enter valid $label latitude and longitude values.');
      return null;
    }

    return Coordinate(latitude: latitude, longitude: longitude);
  }

  int? _optionalInt(final TextEditingController controller, final String label) {
    if (controller.text.isEmpty) {
      return null;
    }

    final value = int.tryParse(controller.text);
    if (value == null) {
      _showInputError('Please enter a valid $label value.');
      return null;
    }

    return value;
  }

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();
    _titleController.dispose();
    _searchController.dispose();
    _regionController.dispose();
    _radiusController.dispose();
    _lineController.dispose();
    _originController.dispose();
    _destinationController.dispose();
    _originLatController.dispose();
    _originLngController.dispose();
    _destLatController.dispose();
    _destLngController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Baidu Maps')),
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
          Row(
            children: [
              const Text('Traffic:'),
              const SizedBox(width: 8),
              Switch(value: _traffic, onChanged: (final value) => setState(() => _traffic = value)),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButton<BaiduMapsCoordType>(
            value: _coordType,
            isExpanded: true,
            onChanged: (final value) => setState(() => _coordType = value ?? BaiduMapsCoordType.bd09ll),
            items:
                BaiduMapsCoordType.values
                    .map((final type) => DropdownMenuItem(value: type, child: Text('Coordinate: ${type.name}')))
                    .toList(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async => _deeplinkX.launchApp(BaiduMaps.open(fallbackToStore: _fallback)),
            child: const Text('Open Baidu Maps'),
          ),
          const SizedBox(height: 24),
          const Text('View Marker', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _latController, lngController: _lngController),
          const SizedBox(height: 8),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Marker title', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final coordinate = _coordinate(_latController, _lngController, 'marker');
              if (coordinate == null) {
                return;
              }

              await _deeplinkX.launchAction(
                BaiduMaps.view(
                  coordinate: coordinate,
                  title: _titleController.text.isEmpty ? null : _titleController.text,
                  coordType: _coordType,
                  traffic: _traffic,
                  fallbackToStore: _fallback,
                ),
              );
            },
            child: const Text('Show Marker'),
          ),
          const SizedBox(height: 24),
          const Text('Search', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(labelText: 'Query', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _regionController,
            decoration: const InputDecoration(labelText: 'Region', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _radiusController,
            decoration: const InputDecoration(labelText: 'Radius', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final radius = _optionalInt(_radiusController, 'radius');
              final center = _coordinate(_latController, _lngController, 'search center');
              if (_radiusController.text.isNotEmpty && radius == null) {
                return;
              }
              if (center == null) {
                return;
              }

              await _deeplinkX.launchAction(
                BaiduMaps.search(
                  query: _searchController.text,
                  region: _regionController.text.isEmpty ? null : _regionController.text,
                  center: center,
                  radius: radius,
                  coordType: _coordType,
                  fallbackToStore: _fallback,
                ),
              );
            },
            child: const Text('Search Places'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final radius = _optionalInt(_radiusController, 'radius');
              final center = _coordinate(_latController, _lngController, 'nearby center');
              if (_radiusController.text.isNotEmpty && radius == null) {
                return;
              }
              if (center == null) {
                return;
              }

              await _deeplinkX.launchAction(
                BaiduMaps.nearbySearch(
                  query: _searchController.text,
                  center: center,
                  radius: radius,
                  coordType: _coordType,
                  fallbackToStore: _fallback,
                ),
              );
            },
            child: const Text('Nearby Search'),
          ),
          const SizedBox(height: 24),
          const Text('Line', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _lineController,
            decoration: const InputDecoration(labelText: 'Line name', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed:
                () async => _deeplinkX.launchAction(
                  BaiduMaps.line(
                    name: _lineController.text,
                    region: _regionController.text.isEmpty ? null : _regionController.text,
                    fallbackToStore: _fallback,
                  ),
                ),
            child: const Text('Open Line'),
          ),
          const SizedBox(height: 24),
          const Text('Directions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButton<BaiduMapsTravelMode>(
            value: _travelMode,
            isExpanded: true,
            onChanged: (final value) => setState(() => _travelMode = value ?? BaiduMapsTravelMode.driving),
            items:
                BaiduMapsTravelMode.values
                    .map((final mode) => DropdownMenuItem(value: mode, child: Text('Route: ${mode.name}')))
                    .toList(),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _originController,
            decoration: const InputDecoration(labelText: 'Origin', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _destinationController,
            decoration: const InputDecoration(labelText: 'Destination', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed:
                () async => _deeplinkX.launchAction(
                  BaiduMaps.directions(
                    origin: _originController.text.isEmpty ? null : _originController.text,
                    destination: _destinationController.text,
                    region: _regionController.text.isEmpty ? null : _regionController.text,
                    mode: _travelMode,
                    coordType: _coordType,
                    fallbackToStore: _fallback,
                  ),
                ),
            child: const Text('Route By Text'),
          ),
          const SizedBox(height: 16),
          _CoordinateRow(latController: _originLatController, lngController: _originLngController),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _destLatController, lngController: _destLngController),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final origin = _coordinate(_originLatController, _originLngController, 'origin');
              final destination = _coordinate(_destLatController, _destLngController, 'destination');
              if (origin == null || destination == null) {
                return;
              }

              await _deeplinkX.launchAction(
                BaiduMaps.directionsWithCoords(
                  origin: origin,
                  originTitle: _originController.text.isEmpty ? null : _originController.text,
                  destination: destination,
                  destinationTitle: _destinationController.text.isEmpty ? null : _destinationController.text,
                  region: _regionController.text.isEmpty ? null : _regionController.text,
                  mode: _travelMode,
                  coordType: _coordType,
                  fallbackToStore: _fallback,
                ),
              );
            },
            child: const Text('Route By Coordinates'),
          ),
          const SizedBox(height: 24),
          const Text('Navigation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButton<BaiduMapsNavigationMode>(
            value: _navigationMode,
            isExpanded: true,
            onChanged: (final value) => setState(() => _navigationMode = value ?? BaiduMapsNavigationMode.driving),
            items:
                BaiduMapsNavigationMode.values
                    .map((final mode) => DropdownMenuItem(value: mode, child: Text('Navigate: ${mode.name}')))
                    .toList(),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final destination = _coordinate(_destLatController, _destLngController, 'navigation destination');
              if (destination == null) {
                return;
              }

              await _deeplinkX.launchAction(
                BaiduMaps.navigate(
                  destination: destination,
                  mode: _navigationMode,
                  coordType: _coordType,
                  fallbackToStore: _fallback,
                ),
              );
            },
            child: const Text('Start Navigation'),
          ),
        ],
      ),
    ),
  );
}

class _CoordinateRow extends StatelessWidget {
  const _CoordinateRow({required this.latController, required this.lngController});

  final TextEditingController latController;
  final TextEditingController lngController;

  @override
  Widget build(final BuildContext context) => Row(
    children: [
      Expanded(
        child: TextField(
          controller: latController,
          decoration: const InputDecoration(labelText: 'Latitude', border: OutlineInputBorder()),
          keyboardType: TextInputType.number,
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: TextField(
          controller: lngController,
          decoration: const InputDecoration(labelText: 'Longitude', border: OutlineInputBorder()),
          keyboardType: TextInputType.number,
        ),
      ),
    ],
  );
}
