import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Mappls.
class MapplsPage extends StatefulWidget {
  /// Creates the Mappls example page.
  const MapplsPage({super.key});

  @override
  State<MapplsPage> createState() => _MapplsPageState();
}

class _MapplsPageState extends State<MapplsPage> {
  final _deeplinkX = DeeplinkX();
  final _viewLatController = TextEditingController(text: '28.6139');
  final _viewLngController = TextEditingController(text: '77.2090');
  final _destLatController = TextEditingController(text: '28.6129');
  final _destLngController = TextEditingController(text: '77.2295');
  final _destTitleController = TextEditingController(text: 'India Gate');
  var _mode = MapplsTravelMode.driving;
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
    _destLatController.dispose();
    _destLngController.dispose();
    _destTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Mappls')),
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
            onPressed: () async => _deeplinkX.launchApp(Mappls.open(fallbackToStore: _fallback)),
            child: const Text('Open Mappls'),
          ),
          const SizedBox(height: 24),
          const Text('View Map', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _viewLatController, lngController: _viewLngController),
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

              await _deeplinkX.launchAction(Mappls.view(coordinate: coordinate, fallbackToStore: _fallback));
            },
            child: const Text('Show Location'),
          ),
          const SizedBox(height: 24),
          const Text('Directions With Coordinates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _destTitleController,
            decoration: const InputDecoration(labelText: 'Destination title', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _destLatController, lngController: _destLngController),
          const SizedBox(height: 8),
          DropdownButton<MapplsTravelMode>(
            value: _mode,
            isExpanded: true,
            onChanged: (final mode) => setState(() => _mode = mode ?? MapplsTravelMode.driving),
            items: const [
              DropdownMenuItem(value: MapplsTravelMode.driving, child: Text('Driving')),
              DropdownMenuItem(value: MapplsTravelMode.walking, child: Text('Walking')),
              DropdownMenuItem(value: MapplsTravelMode.bicycling, child: Text('Bicycling')),
              DropdownMenuItem(value: MapplsTravelMode.transit, child: Text('Transit')),
            ],
          ),
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
                Mappls.directionsWithCoords(
                  destination: destination,
                  destinationTitle: _destTitleController.text.isEmpty ? null : _destTitleController.text,
                  mode: _mode,
                  fallbackToStore: _fallback,
                ),
              );
            },
            child: const Text('Start Directions'),
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
