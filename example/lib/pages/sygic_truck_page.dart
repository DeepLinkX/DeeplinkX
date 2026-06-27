import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Sygic Truck.
class SygicTruckPage extends StatefulWidget {
  /// Creates the Sygic Truck example page.
  const SygicTruckPage({super.key});

  @override
  State<SygicTruckPage> createState() => _SygicTruckPageState();
}

class _SygicTruckPageState extends State<SygicTruckPage> {
  final _deeplinkX = DeeplinkX();
  final _viewLatController = TextEditingController(text: '48.1486');
  final _viewLngController = TextEditingController(text: '17.1077');
  final _destLatController = TextEditingController(text: '48.1486');
  final _destLngController = TextEditingController(text: '17.1077');
  bool _fallback = true;

  void _showInputError(final String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _viewLatController.dispose();
    _viewLngController.dispose();
    _destLatController.dispose();
    _destLngController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Sygic Truck')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Fallback to store:'),
              const SizedBox(width: 8),
              Switch(value: _fallback, onChanged: (final value) => setState(() => _fallback = value)),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async => _deeplinkX.launchApp(SygicTruck.open(fallbackToStore: _fallback)),
            child: const Text('Open Sygic Truck'),
          ),
          const SizedBox(height: 24),
          const Text('View Map', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _viewLatController, lngController: _viewLngController),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _launchView, child: const Text('Show Coordinate')),
          const SizedBox(height: 24),
          const Text('Directions With Coordinates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _destLatController, lngController: _destLngController, labelPrefix: 'Dest '),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _launchDirections, child: const Text('Start Navigation')),
        ],
      ),
    ),
  );

  Future<void> _launchView() async {
    final coordinate = _readRequiredCoordinate(_viewLatController, _viewLngController);
    if (coordinate == null) {
      return;
    }

    await _deeplinkX.launchAction(SygicTruck.view(coordinate: coordinate, fallbackToStore: _fallback));
  }

  Future<void> _launchDirections() async {
    final destination = _readRequiredCoordinate(_destLatController, _destLngController);
    if (destination == null) {
      return;
    }

    await _deeplinkX.launchAction(
      SygicTruck.directionsWithCoords(destination: destination, fallbackToStore: _fallback),
    );
  }

  Coordinate? _readRequiredCoordinate(
    final TextEditingController latController,
    final TextEditingController lngController,
  ) {
    if (latController.text.isEmpty || lngController.text.isEmpty) {
      _showInputError('Please enter both latitude and longitude.');
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
}

class _CoordinateRow extends StatelessWidget {
  const _CoordinateRow({required this.latController, required this.lngController, this.labelPrefix = ''});

  final TextEditingController latController;
  final TextEditingController lngController;
  final String labelPrefix;

  @override
  Widget build(final BuildContext context) => Row(
    children: [
      Expanded(
        child: TextField(
          controller: latController,
          decoration: InputDecoration(labelText: '${labelPrefix}Latitude', border: const OutlineInputBorder()),
          keyboardType: TextInputType.number,
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: TextField(
          controller: lngController,
          decoration: InputDecoration(labelText: '${labelPrefix}Longitude', border: const OutlineInputBorder()),
          keyboardType: TextInputType.number,
        ),
      ),
    ],
  );
}
