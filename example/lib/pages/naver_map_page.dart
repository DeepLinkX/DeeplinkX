import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for NAVER Map.
class NaverMapPage extends StatefulWidget {
  /// Creates the NAVER Map example page.
  const NaverMapPage({super.key});

  @override
  State<NaverMapPage> createState() => _NaverMapPageState();
}

class _NaverMapPageState extends State<NaverMapPage> {
  final _deeplinkX = DeeplinkX();
  final _viewLatController = TextEditingController(text: '37.5547');
  final _viewLngController = TextEditingController(text: '126.9706');
  final _titleController = TextEditingController(text: 'Seoul Station');
  final _originLatController = TextEditingController(text: '37.5665');
  final _originLngController = TextEditingController(text: '126.9780');
  final _originTitleController = TextEditingController(text: 'City Hall');
  final _destLatController = TextEditingController(text: '37.5547');
  final _destLngController = TextEditingController(text: '126.9706');
  final _destTitleController = TextEditingController(text: 'Seoul Station');
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
    _titleController.dispose();
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
    appBar: AppBar(title: const Text('NAVER Map')),
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
            onPressed: () async => _deeplinkX.launchApp(NaverMap.open(fallbackToStore: _fallback)),
            child: const Text('Open NAVER Map'),
          ),
          const SizedBox(height: 24),
          const Text('View Map', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _viewLatController, lngController: _viewLngController),
          const SizedBox(height: 8),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _launchView, child: const Text('Show Coordinate')),
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
            decoration: const InputDecoration(labelText: 'Origin title', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _destLatController, lngController: _destLngController, labelPrefix: 'Dest '),
          const SizedBox(height: 8),
          TextField(
            controller: _destTitleController,
            decoration: const InputDecoration(labelText: 'Destination title', border: OutlineInputBorder()),
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
      NaverMap.view(
        coordinate: coordinate,
        title: _titleController.text.isEmpty ? null : _titleController.text,
        fallbackToStore: _fallback,
      ),
    );
  }

  Future<void> _launchDirections() async {
    final destination = _readRequiredCoordinate(_destLatController, _destLngController);
    final origin = _readRequiredCoordinate(_originLatController, _originLngController);
    if (destination == null || origin == null) {
      return;
    }

    await _deeplinkX.launchAction(
      NaverMap.directionsWithCoords(
        destination: destination,
        origin: origin,
        destinationTitle: _destTitleController.text.isEmpty ? null : _destTitleController.text,
        originTitle: _originTitleController.text.isEmpty ? null : _originTitleController.text,
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
