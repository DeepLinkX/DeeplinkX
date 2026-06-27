import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for 2GIS.
class TwoGisPage extends StatefulWidget {
  /// Creates the 2GIS example page.
  const TwoGisPage({super.key});

  @override
  State<TwoGisPage> createState() => _TwoGisPageState();
}

class _TwoGisPageState extends State<TwoGisPage> {
  final _deeplinkX = DeeplinkX();
  final _viewLatController = TextEditingController(text: '55.76009');
  final _viewLngController = TextEditingController(text: '37.648801');
  final _originLatController = TextEditingController(text: '55.751244');
  final _originLngController = TextEditingController(text: '37.618423');
  final _destLatController = TextEditingController(text: '55.76009');
  final _destLngController = TextEditingController(text: '37.648801');
  var _mode = TwoGisTravelMode.auto;
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
    _originLatController.dispose();
    _originLngController.dispose();
    _destLatController.dispose();
    _destLngController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('2GIS')),
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
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async => _deeplinkX.launchApp(TwoGis.open(fallbackToStore: _fallback)),
            child: const Text('Open 2GIS'),
          ),
          const SizedBox(height: 24),
          const Text('View Map', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _viewLatController, lngController: _viewLngController),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _launchView, child: const Text('Show Location')),
          const SizedBox(height: 24),
          const Text('Directions With Coordinates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(
            latController: _originLatController,
            lngController: _originLngController,
            labelPrefix: 'Origin ',
          ),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _destLatController, lngController: _destLngController, labelPrefix: 'Dest '),
          const SizedBox(height: 8),
          DropdownButton<TwoGisTravelMode>(
            value: _mode,
            isExpanded: true,
            onChanged: (final mode) => setState(() => _mode = mode ?? TwoGisTravelMode.auto),
            items: const [
              DropdownMenuItem(value: TwoGisTravelMode.auto, child: Text('Auto')),
              DropdownMenuItem(value: TwoGisTravelMode.driving, child: Text('Driving')),
              DropdownMenuItem(value: TwoGisTravelMode.transit, child: Text('Transit')),
              DropdownMenuItem(value: TwoGisTravelMode.walking, child: Text('Walking')),
            ],
          ),
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

    await _deeplinkX.launchAction(TwoGis.view(coordinate: coordinate, fallbackToStore: _fallback));
  }

  Future<void> _launchDirections() async {
    final origin = _readRequiredCoordinate(_originLatController, _originLngController);
    final destination = _readRequiredCoordinate(_destLatController, _destLngController);
    if (origin == null || destination == null) {
      return;
    }

    await _deeplinkX.launchAction(
      TwoGis.directionsWithCoords(origin: origin, destination: destination, mode: _mode, fallbackToStore: _fallback),
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
