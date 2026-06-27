import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Neshan.
class NeshanPage extends StatefulWidget {
  /// Creates the Neshan example page.
  const NeshanPage({super.key});

  @override
  State<NeshanPage> createState() => _NeshanPageState();
}

class _NeshanPageState extends State<NeshanPage> {
  final _deeplinkX = DeeplinkX();
  final _viewLatController = TextEditingController(text: '35.6892');
  final _viewLngController = TextEditingController(text: '51.3890');
  final _originLatController = TextEditingController(text: '35.6892');
  final _originLngController = TextEditingController(text: '51.3890');
  final _destLatController = TextEditingController(text: '35.7000');
  final _destLngController = TextEditingController(text: '51.4000');
  bool _fallback = true;
  bool _useCurrentLocation = false;

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
    _originLatController.dispose();
    _originLngController.dispose();
    _destLatController.dispose();
    _destLngController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Neshan')),
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
            onPressed: () async => _deeplinkX.launchApp(Neshan.open(fallbackToStore: _fallback)),
            child: const Text('Open Neshan'),
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

              await _deeplinkX.launchAction(Neshan.view(coordinate: coordinate, fallbackToStore: _fallback));
            },
            child: const Text('Show Location'),
          ),
          const SizedBox(height: 24),
          const Text('Directions With Coordinates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Use current location as origin'),
            value: _useCurrentLocation,
            onChanged: (final value) => setState(() => _useCurrentLocation = value),
          ),
          if (!_useCurrentLocation) ...[
            const SizedBox(height: 8),
            _CoordinateRow(latController: _originLatController, lngController: _originLngController),
          ],
          const SizedBox(height: 8),
          _CoordinateRow(latController: _destLatController, lngController: _destLngController),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final origin =
                  _useCurrentLocation
                      ? null
                      : _readCoordinate(
                        latController: _originLatController,
                        lngController: _originLngController,
                        emptyMessage: 'Please enter origin latitude and longitude.',
                      );
              if (!_useCurrentLocation && origin == null) {
                return;
              }

              final destination = _readCoordinate(
                latController: _destLatController,
                lngController: _destLngController,
                emptyMessage: 'Please enter destination latitude and longitude.',
              );
              if (destination == null) {
                return;
              }

              await _deeplinkX.launchAction(
                Neshan.directionsWithCoords(origin: origin, destination: destination, fallbackToStore: _fallback),
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
