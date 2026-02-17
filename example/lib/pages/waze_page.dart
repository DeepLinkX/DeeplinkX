import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Waze.
class WazePage extends StatefulWidget {
  /// Creates the Waze example page.
  const WazePage({super.key});

  @override
  State<WazePage> createState() => _WazePageState();
}

class _WazePageState extends State<WazePage> {
  final _deeplinkX = DeeplinkX();
  final _latController = TextEditingController(text: '45.6906304');
  final _lngController = TextEditingController(text: '-120.810983');
  final _searchController = TextEditingController(text: '66 Acacia Avenue');
  final _directionsTextController = TextEditingController(text: '66 Acacia Avenue');
  final _directionsTextZoomController = TextEditingController(text: '8');
  final _destLatController = TextEditingController(text: '45.6906304');
  final _destLngController = TextEditingController(text: '-120.810983');
  final _directionsZoomController = TextEditingController(text: '8');
  bool _fallback = true;

  void _showInputError(final String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();

    _searchController.dispose();
    _directionsTextController.dispose();
    _directionsTextZoomController.dispose();
    _destLatController.dispose();
    _destLngController.dispose();
    _directionsZoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Waze')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Fallback to App Store:'),
              const SizedBox(width: 8),
              Switch(value: _fallback, onChanged: (final v) => setState(() => _fallback = v)),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async => _deeplinkX.launchApp(Waze.open(fallbackToStore: _fallback)),
            child: const Text('Open Waze'),
          ),
          const SizedBox(height: 16),
          const Text('View Map', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _latController,
                  decoration: const InputDecoration(labelText: 'Latitude', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _lngController,
                  decoration: const InputDecoration(labelText: 'Longitude', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_latController.text.isEmpty || _lngController.text.isEmpty) {
                _showInputError('Please enter both latitude and longitude.');
                return;
              }

              final latitude = double.tryParse(_latController.text);
              final longitude = double.tryParse(_lngController.text);

              if (latitude == null || longitude == null) {
                _showInputError('Please enter valid latitude and longitude values.');
                return;
              }

              await _deeplinkX.launchAction(
                Waze.view(coordinate: Coordinate(latitude: latitude, longitude: longitude), fallbackToStore: _fallback),
              );
            },
            child: const Text('View Map'),
          ),
          const SizedBox(height: 16),
          const Text('Search (no web fallback)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(labelText: 'Query (q)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_searchController.text.isNotEmpty) {
                await _deeplinkX.launchAction(Waze.search(query: _searchController.text, fallbackToStore: _fallback));
              }
            },
            child: const Text('Search'),
          ),
          const SizedBox(height: 16),
          const Text('Directions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _directionsTextController,
            decoration: const InputDecoration(labelText: 'Destination (q)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _directionsTextZoomController,
            decoration: const InputDecoration(labelText: 'Zoom (z) optional', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_directionsTextController.text.isNotEmpty) {
                final zoom =
                    _directionsTextZoomController.text.isNotEmpty
                        ? int.tryParse(_directionsTextZoomController.text)
                        : null;

                if (_directionsTextZoomController.text.isNotEmpty && zoom == null) {
                  _showInputError('Please enter a valid zoom value.');
                  return;
                }

                await _deeplinkX.launchAction(
                  Waze.directions(destination: _directionsTextController.text, zoom: zoom, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Get Directions'),
          ),
          const SizedBox(height: 16),
          const Text('Directions With Coordinates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _destLatController,
                  decoration: const InputDecoration(labelText: 'Dest Lat', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _destLngController,
                  decoration: const InputDecoration(labelText: 'Dest Lng', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _directionsZoomController,
            decoration: const InputDecoration(labelText: 'Zoom (z) optional', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_destLatController.text.isEmpty || _destLngController.text.isEmpty) {
                _showInputError('Please enter destination latitude and longitude.');
                return;
              }

              final latitude = double.tryParse(_destLatController.text);
              final longitude = double.tryParse(_destLngController.text);
              final zoom =
                  _directionsZoomController.text.isNotEmpty ? int.tryParse(_directionsZoomController.text) : null;

              if (latitude == null || longitude == null) {
                _showInputError('Please enter valid destination coordinates.');
                return;
              }

              if (_directionsZoomController.text.isNotEmpty && zoom == null) {
                _showInputError('Please enter a valid zoom value.');
                return;
              }

              await _deeplinkX.launchAction(
                Waze.directionsWithCoords(
                  destination: Coordinate(latitude: latitude, longitude: longitude),
                  zoom: zoom,
                  fallbackToStore: _fallback,
                ),
              );
            },
            child: const Text('Get Directions'),
          ),
        ],
      ),
    ),
  );
}
