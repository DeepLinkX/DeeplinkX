import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for HERE WeGo.
class HereWeGoPage extends StatefulWidget {
  /// Creates the HERE WeGo example page.
  const HereWeGoPage({super.key});

  @override
  State<HereWeGoPage> createState() => _HereWeGoPageState();
}

class _HereWeGoPageState extends State<HereWeGoPage> {
  final _deeplinkX = DeeplinkX();
  final _viewLatController = TextEditingController(text: '52.5163');
  final _viewLngController = TextEditingController(text: '13.3777');
  final _titleController = TextEditingController(text: 'Brandenburg Gate');
  final _zoomController = TextEditingController(text: '15');
  final _originLatController = TextEditingController(text: '52.5308');
  final _originLngController = TextEditingController(text: '13.3847');
  final _originTitleController = TextEditingController(text: 'Berlin Central Station');
  final _destLatController = TextEditingController(text: '52.5163');
  final _destLngController = TextEditingController(text: '13.3777');
  final _destTitleController = TextEditingController(text: 'Brandenburg Gate');
  var _mode = HereWeGoTravelMode.driving;
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
    _zoomController.dispose();
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
    appBar: AppBar(title: const Text('HERE WeGo')),
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
            onPressed: () async => _deeplinkX.launchApp(HereWeGo.open(fallbackToStore: _fallback)),
            child: const Text('Open HERE WeGo'),
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
          TextField(
            controller: _zoomController,
            decoration: const InputDecoration(labelText: 'Zoom', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
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
          DropdownButton<HereWeGoTravelMode>(
            value: _mode,
            isExpanded: true,
            onChanged: (final mode) => setState(() => _mode = mode ?? HereWeGoTravelMode.driving),
            items: const [
              DropdownMenuItem(value: HereWeGoTravelMode.driving, child: Text('Driving')),
              DropdownMenuItem(value: HereWeGoTravelMode.transit, child: Text('Transit')),
              DropdownMenuItem(value: HereWeGoTravelMode.walking, child: Text('Walking')),
              DropdownMenuItem(value: HereWeGoTravelMode.bicycling, child: Text('Bicycling')),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _launchDirections, child: const Text('Plan Route')),
        ],
      ),
    ),
  );

  Future<void> _launchView() async {
    final coordinate = _readRequiredCoordinate(_viewLatController, _viewLngController);
    if (coordinate == null) {
      return;
    }

    final zoom = int.tryParse(_zoomController.text);
    if (zoom == null) {
      _showInputError('Please enter a valid zoom value.');
      return;
    }

    await _deeplinkX.launchAction(
      HereWeGo.view(
        coordinate: coordinate,
        title: _titleController.text.isEmpty ? null : _titleController.text,
        zoom: zoom,
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
      HereWeGo.directionsWithCoords(
        origin: origin,
        originTitle: _originTitleController.text.isEmpty ? null : _originTitleController.text,
        destination: destination,
        destinationTitle: _destTitleController.text.isEmpty ? null : _destTitleController.text,
        mode: _mode,
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
