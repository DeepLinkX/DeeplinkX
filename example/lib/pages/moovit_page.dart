import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Moovit.
class MoovitPage extends StatefulWidget {
  /// Creates the Moovit example page.
  const MoovitPage({super.key});

  @override
  State<MoovitPage> createState() => _MoovitPageState();
}

class _MoovitPageState extends State<MoovitPage> {
  final _deeplinkX = DeeplinkX();
  final _viewLatController = TextEditingController(text: '40.7128');
  final _viewLngController = TextEditingController(text: '-74.0060');
  final _originLatController = TextEditingController(text: '40.7580');
  final _originLngController = TextEditingController(text: '-73.9855');
  final _originTitleController = TextEditingController(text: 'Times Square');
  final _destLatController = TextEditingController(text: '40.7527');
  final _destLngController = TextEditingController(text: '-73.9772');
  final _destTitleController = TextEditingController(text: 'Grand Central');
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
    _originTitleController.dispose();
    _destLatController.dispose();
    _destLngController.dispose();
    _destTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Moovit')),
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
            onPressed: () async => _deeplinkX.launchApp(Moovit.open(fallbackToStore: _fallback)),
            child: const Text('Open Moovit'),
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

              await _deeplinkX.launchAction(Moovit.view(coordinate: coordinate, fallbackToStore: _fallback));
            },
            child: const Text('Show Nearby Transit'),
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
            TextField(
              controller: _originTitleController,
              decoration: const InputDecoration(labelText: 'Origin title', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 8),
            _CoordinateRow(latController: _originLatController, lngController: _originLngController),
          ],
          const SizedBox(height: 8),
          TextField(
            controller: _destTitleController,
            decoration: const InputDecoration(labelText: 'Destination title', border: OutlineInputBorder()),
          ),
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
                Moovit.directionsWithCoords(
                  origin: origin,
                  originTitle:
                      _useCurrentLocation || _originTitleController.text.isEmpty ? null : _originTitleController.text,
                  destination: destination,
                  destinationTitle: _destTitleController.text.isEmpty ? null : _destTitleController.text,
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
