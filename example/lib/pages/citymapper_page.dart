import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Citymapper.
class CitymapperPage extends StatefulWidget {
  /// Creates the Citymapper example page.
  const CitymapperPage({super.key});

  @override
  State<CitymapperPage> createState() => _CitymapperPageState();
}

class _CitymapperPageState extends State<CitymapperPage> {
  final _deeplinkX = DeeplinkX();
  final _viewLatController = TextEditingController(text: '51.503399');
  final _viewLngController = TextEditingController(text: '-0.119519');
  final _viewTitleController = TextEditingController(text: 'London Eye');
  final _originLatController = TextEditingController(text: '51.500729');
  final _originLngController = TextEditingController(text: '-0.124625');
  final _originTitleController = TextEditingController(text: 'Westminster');
  final _destLatController = TextEditingController(text: '51.503399');
  final _destLngController = TextEditingController(text: '-0.119519');
  final _destTitleController = TextEditingController(text: 'London Eye');
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
    _viewTitleController.dispose();
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
    appBar: AppBar(title: const Text('Citymapper')),
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
            onPressed: () async => _deeplinkX.launchApp(Citymapper.open(fallbackToStore: _fallback)),
            child: const Text('Open Citymapper'),
          ),
          const SizedBox(height: 24),
          const Text('View Map', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _viewLatController, lngController: _viewLngController),
          const SizedBox(height: 8),
          TextField(
            controller: _viewTitleController,
            decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
          ),
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
          TextField(
            controller: _originTitleController,
            decoration: const InputDecoration(labelText: 'Origin Title', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _destLatController, lngController: _destLngController, labelPrefix: 'Dest '),
          const SizedBox(height: 8),
          TextField(
            controller: _destTitleController,
            decoration: const InputDecoration(labelText: 'Destination Title', border: OutlineInputBorder()),
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

    await _deeplinkX.launchAction(
      Citymapper.view(
        coordinate: coordinate,
        title: _viewTitleController.text.isEmpty ? null : _viewTitleController.text,
        fallbackToStore: _fallback,
      ),
    );
  }

  Future<void> _launchDirections() async {
    final origin = _readRequiredCoordinate(_originLatController, _originLngController);
    final destination = _readRequiredCoordinate(_destLatController, _destLngController);
    if (origin == null || destination == null) {
      return;
    }

    await _deeplinkX.launchAction(
      Citymapper.directionsWithCoords(
        origin: origin,
        destination: destination,
        originTitle: _originTitleController.text.isEmpty ? null : _originTitleController.text,
        destinationTitle: _destTitleController.text.isEmpty ? null : _destTitleController.text,
        fallbackToStore: _fallback,
      ),
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
