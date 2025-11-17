import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Sygic GPS Navigation.
class SygicPage extends StatefulWidget {
  /// Creates the Sygic example page.
  const SygicPage({super.key});

  @override
  State<SygicPage> createState() => _SygicPageState();
}

class _SygicPageState extends State<SygicPage> {
  final _deeplinkX = DeeplinkX();
  final _viewLatController = TextEditingController(text: '48.1486');
  final _viewLngController = TextEditingController(text: '17.1077');
  final _navLatController = TextEditingController(text: '48.1486');
  final _navLngController = TextEditingController(text: '17.1077');
  var _mode = SygicTransportMode.drive;
  bool _fallback = true;

  @override
  void dispose() {
    _viewLatController.dispose();
    _viewLngController.dispose();
    _navLatController.dispose();
    _navLngController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Sygic')),
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
            onPressed: () async => _deeplinkX.launchApp(Sygic.open(fallbackToStore: _fallback)),
            child: const Text('Open Sygic'),
          ),
          const SizedBox(height: 24),
          const Text('View Map', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _viewLatController, lngController: _viewLngController),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_viewLatController.text.isNotEmpty && _viewLngController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Sygic.view(
                    coordinate: Coordinate(
                      latitude: double.parse(_viewLatController.text),
                      longitude: double.parse(_viewLngController.text),
                    ),
                    fallbackToStore: _fallback,
                  ),
                );
              }
            },
            child: const Text('Show Location'),
          ),
          const SizedBox(height: 24),
          const Text('Directions With Coordinates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _navLatController, lngController: _navLngController),
          const SizedBox(height: 8),
          DropdownButton<SygicTransportMode>(
            value: _mode,
            isExpanded: true,
            onChanged: (final mode) => setState(() => _mode = mode ?? SygicTransportMode.drive),
            items: const [
              DropdownMenuItem(value: SygicTransportMode.drive, child: Text('Drive')),
              DropdownMenuItem(value: SygicTransportMode.walk, child: Text('Walk')),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_navLatController.text.isNotEmpty && _navLngController.text.isNotEmpty) {
                await _deeplinkX.launchAction(
                  Sygic.directionsWithCoords(
                    destination: Coordinate(
                      latitude: double.parse(_navLatController.text),
                      longitude: double.parse(_navLngController.text),
                    ),
                    mode: _mode,
                    fallbackToStore: _fallback,
                  ),
                );
              }
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
