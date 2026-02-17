import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Apple Maps.
class AppleMapsPage extends StatefulWidget {
  /// Creates the Apple Maps example page.
  const AppleMapsPage({super.key});

  @override
  State<AppleMapsPage> createState() => _AppleMapsPageState();
}

class _AppleMapsPageState extends State<AppleMapsPage> {
  final _deeplinkX = DeeplinkX();
  final _latController = TextEditingController(text: '37.7749');
  final _lngController = TextEditingController(text: '-122.4194');
  final _zoomController = TextEditingController(text: '14');
  final _queryController = TextEditingController();
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final _originLatController = TextEditingController();
  final _originLngController = TextEditingController();
  final _destLatController = TextEditingController();
  final _destLngController = TextEditingController();
  AppleMapsTransportType? _mode;
  AppleMapsTransportType? _coordsMode;
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
    _zoomController.dispose();
    _queryController.dispose();
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
    appBar: AppBar(title: const Text('Apple Maps')),
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
            onPressed: () async {
              await _deeplinkX.launchApp(AppleMaps.open(fallbackToStore: _fallback));
            },
            child: const Text('Open Apple Maps'),
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
          TextField(
            controller: _zoomController,
            decoration: const InputDecoration(labelText: 'Zoom (optional)', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_latController.text.isEmpty || _lngController.text.isEmpty) {
                _showInputError('Please enter both latitude and longitude.');
                return;
              }

              final latitude = double.tryParse(_latController.text);
              final longitude = double.tryParse(_lngController.text);
              final zoom = _zoomController.text.isNotEmpty ? double.tryParse(_zoomController.text) : null;

              if (latitude == null || longitude == null) {
                _showInputError('Please enter valid latitude and longitude values.');
                return;
              }

              if (_zoomController.text.isNotEmpty && zoom == null) {
                _showInputError('Please enter a valid zoom value.');
                return;
              }

              await _deeplinkX.launchAction(
                AppleMaps.view(
                  coordinate: Coordinate(latitude: latitude, longitude: longitude),
                  zoom: zoom,
                  fallbackToStore: _fallback,
                ),
              );
            },
            child: const Text('View Map'),
          ),
          const SizedBox(height: 16),
          const Text('Search', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _queryController,
            decoration: const InputDecoration(
              labelText: 'Query',
              hintText: 'Enter location or coordinates',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_queryController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  AppleMaps.search(query: _queryController.text, fallbackToStore: _fallback),
                );
              }
            },
            child: const Text('Search Location'),
          ),
          const SizedBox(height: 16),
          const Text('Directions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _originController,
            decoration: const InputDecoration(labelText: 'Origin (optional)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _destinationController,
            decoration: const InputDecoration(labelText: 'Destination', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          DropdownButton<AppleMapsTransportType>(
            value: _mode,
            isExpanded: true,
            hint: const Text('Travel mode'),
            onChanged: (final m) => setState(() => _mode = m),
            items: [
              const DropdownMenuItem<AppleMapsTransportType>(child: Text('None')),
              ...AppleMapsTransportType.values.map((final m) => DropdownMenuItem(value: m, child: Text(m.name))),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_destinationController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  AppleMaps.directions(
                    origin: _originController.text.isNotEmpty ? _originController.text : null,
                    destination: _destinationController.text,
                    mode: _mode,
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Get Directions'),
          ),
          const SizedBox(height: 16),
          const Text('Directions with Coordinates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _originLatController,
                  decoration: const InputDecoration(labelText: 'Origin Lat (optional)', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _originLngController,
                  decoration: const InputDecoration(labelText: 'Origin Lng (optional)', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _destLatController,
                  decoration: const InputDecoration(labelText: 'Destination Lat', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _destLngController,
                  decoration: const InputDecoration(labelText: 'Destination Lng', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          DropdownButton<AppleMapsTransportType>(
            value: _coordsMode,
            isExpanded: true,
            hint: const Text('Travel mode'),
            onChanged: (final m) => setState(() => _coordsMode = m),
            items: [
              const DropdownMenuItem<AppleMapsTransportType>(child: Text('None')),
              ...AppleMapsTransportType.values.map((final m) => DropdownMenuItem(value: m, child: Text(m.name))),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_destLatController.text.isEmpty || _destLngController.text.isEmpty) {
                _showInputError('Please enter destination latitude and longitude.');
                return;
              }

              final hasOriginLat = _originLatController.text.isNotEmpty;
              final hasOriginLng = _originLngController.text.isNotEmpty;

              if (hasOriginLat != hasOriginLng) {
                _showInputError('Please enter both origin latitude and longitude, or leave both empty.');
                return;
              }

              final destinationLat = double.tryParse(_destLatController.text);
              final destinationLng = double.tryParse(_destLngController.text);

              if (destinationLat == null || destinationLng == null) {
                _showInputError('Please enter valid destination coordinates.');
                return;
              }

              Coordinate? origin;
              if (hasOriginLat && hasOriginLng) {
                final originLat = double.tryParse(_originLatController.text);
                final originLng = double.tryParse(_originLngController.text);

                if (originLat == null || originLng == null) {
                  _showInputError('Please enter valid origin coordinates.');
                  return;
                }

                origin = Coordinate(latitude: originLat, longitude: originLng);
              }

              await _deeplinkX.launchAction(
                AppleMaps.directionsWithCoords(
                  origin: origin,
                  destination: Coordinate(latitude: destinationLat, longitude: destinationLng),
                  mode: _coordsMode,
                  fallbackToStore: _fallback,
                ),
              );
            },
            child: const Text('Get Directions with Coordinates'),
          ),
        ],
      ),
    ),
  );
}
