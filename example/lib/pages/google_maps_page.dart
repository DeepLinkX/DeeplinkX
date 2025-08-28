import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Google Maps.
class GoogleMapsPage extends StatefulWidget {
  /// Creates the Google Maps example page.
  const GoogleMapsPage({super.key});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
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
  GoogleMapsTravelMode? _mode;
  GoogleMapsTravelMode? _coordsMode;
  bool _fallback = true;

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
    appBar: AppBar(title: const Text('Google Maps')),
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
              await _deeplinkX.launchApp(GoogleMaps.open(fallbackToStore: _fallback));
            },
            child: const Text('Open Google Maps'),
          ),
          const SizedBox(height: 16),
          const Text('View Coordinates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
              if (_latController.text.isNotEmpty && _lngController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  GoogleMaps.view(
                    coordinate: Coordinate(
                      latitude: double.parse(_latController.text),
                      longitude: double.parse(_lngController.text),
                    ),
                    zoom: _zoomController.text.isNotEmpty ? double.parse(_zoomController.text) : null,
                    fallbackToStore: _fallback,
                  ),
                );
              }
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
                  GoogleMaps.search(query: _queryController.text, fallbackToStore: _fallback),
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
          DropdownButton<GoogleMapsTravelMode>(
            value: _mode,
            isExpanded: true,
            hint: const Text('Travel mode'),
            onChanged: (final m) => setState(() => _mode = m),
            items: [
              const DropdownMenuItem<GoogleMapsTravelMode>(child: Text('None')),
              ...GoogleMapsTravelMode.values.map((final m) => DropdownMenuItem(value: m, child: Text(m.name))),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_destinationController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  GoogleMaps.directions(
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
          DropdownButton<GoogleMapsTravelMode>(
            value: _coordsMode,
            isExpanded: true,
            hint: const Text('Travel mode'),
            onChanged: (final m) => setState(() => _coordsMode = m),
            items: [
              const DropdownMenuItem<GoogleMapsTravelMode>(child: Text('None')),
              ...GoogleMapsTravelMode.values.map((final m) => DropdownMenuItem(value: m, child: Text(m.name))),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_destLatController.text.isNotEmpty && _destLngController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  GoogleMaps.directionsWithCoords(
                    origin:
                        _originLatController.text.isNotEmpty && _originLngController.text.isNotEmpty
                            ? Coordinate(
                              latitude: double.parse(_originLatController.text),
                              longitude: double.parse(_originLngController.text),
                            )
                            : null,
                    destination: Coordinate(
                      latitude: double.parse(_destLatController.text),
                      longitude: double.parse(_destLngController.text),
                    ),
                    mode: _coordsMode,
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Get Directions with Coordinates'),
          ),
        ],
      ),
    ),
  );
}
