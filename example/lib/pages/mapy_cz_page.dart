import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Mapy.cz.
class MapyCzPage extends StatefulWidget {
  /// Creates the Mapy.cz example page.
  const MapyCzPage({super.key});

  @override
  State<MapyCzPage> createState() => _MapyCzPageState();
}

class _MapyCzPageState extends State<MapyCzPage> {
  final _deeplinkX = DeeplinkX();
  final _viewLatController = TextEditingController(text: '50.0755');
  final _viewLngController = TextEditingController(text: '14.4378');
  final _zoomController = TextEditingController(text: '15');
  final _destLatController = TextEditingController(text: '50.0755');
  final _destLngController = TextEditingController(text: '14.4378');
  bool _fallback = true;

  void _showInputError(final String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Coordinate? _readCoordinate({
    required final TextEditingController latController,
    required final TextEditingController lngController,
    required final String emptyMessage,
  }) {
    if (latController.text.isEmpty || lngController.text.isEmpty) {
      _showInputError(emptyMessage);
      return null;
    }

    final latitude = double.tryParse(latController.text);
    final longitude = double.tryParse(lngController.text);

    if (latitude == null || longitude == null) {
      _showInputError('Please enter valid latitude and longitude values.');
      return null;
    }

    return Coordinate(latitude: latitude, longitude: longitude);
  }

  @override
  void dispose() {
    _viewLatController.dispose();
    _viewLngController.dispose();
    _zoomController.dispose();
    _destLatController.dispose();
    _destLngController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Mapy.cz')),
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
            onPressed: () async => _deeplinkX.launchApp(MapyCz.open(fallbackToStore: _fallback)),
            child: const Text('Open Mapy.cz'),
          ),
          const SizedBox(height: 24),
          const Text('View Map', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _viewLatController, lngController: _viewLngController),
          const SizedBox(height: 8),
          TextField(
            controller: _zoomController,
            decoration: const InputDecoration(labelText: 'Zoom', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final coordinate = _readCoordinate(
                latController: _viewLatController,
                lngController: _viewLngController,
                emptyMessage: 'Please enter both latitude and longitude.',
              );
              if (coordinate == null) {
                return;
              }

              final zoom = int.tryParse(_zoomController.text);
              if (zoom == null) {
                _showInputError('Please enter a valid zoom value.');
                return;
              }

              await _deeplinkX.launchAction(
                MapyCz.view(coordinate: coordinate, zoom: zoom, fallbackToStore: _fallback),
              );
            },
            child: const Text('Show Location'),
          ),
          const SizedBox(height: 24),
          const Text('Directions With Coordinates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _destLatController, lngController: _destLngController),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final destination = _readCoordinate(
                latController: _destLatController,
                lngController: _destLngController,
                emptyMessage: 'Please enter destination latitude and longitude.',
              );
              if (destination == null) {
                return;
              }

              await _deeplinkX.launchAction(
                MapyCz.directionsWithCoords(destination: destination, fallbackToStore: _fallback),
              );
            },
            child: const Text('Open Destination'),
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
