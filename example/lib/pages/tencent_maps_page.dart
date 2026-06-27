import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Tencent Maps.
class TencentMapsPage extends StatefulWidget {
  /// Creates the Tencent Maps example page.
  const TencentMapsPage({super.key});

  @override
  State<TencentMapsPage> createState() => _TencentMapsPageState();
}

class _TencentMapsPageState extends State<TencentMapsPage> {
  final _deeplinkX = DeeplinkX();
  final _viewLatController = TextEditingController(text: '39.867192');
  final _viewLngController = TextEditingController(text: '116.493187');
  final _titleController = TextEditingController(text: 'Community');
  final _addressController = TextEditingController(text: 'Beijing');
  final _searchController = TextEditingController(text: 'coffee');
  final _regionController = TextEditingController(text: 'Shanghai');
  final _nearbyQueryController = TextEditingController(text: 'restaurant');
  final _nearbyLatController = TextEditingController(text: '39.994745');
  final _nearbyLngController = TextEditingController(text: '116.247282');
  final _nearbyRadiusController = TextEditingController(text: '800');
  final _originLatController = TextEditingController(text: '39.994745');
  final _originLngController = TextEditingController(text: '116.247282');
  final _originTitleController = TextEditingController(text: 'Tsinghua');
  final _destLatController = TextEditingController(text: '39.867192');
  final _destLngController = TextEditingController(text: '116.493187');
  final _destTitleController = TextEditingController(text: 'Community');
  var _mode = TencentMapsTravelMode.driving;
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
    _addressController.dispose();
    _searchController.dispose();
    _regionController.dispose();
    _nearbyQueryController.dispose();
    _nearbyLatController.dispose();
    _nearbyLngController.dispose();
    _nearbyRadiusController.dispose();
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
    appBar: AppBar(title: const Text('Tencent Maps')),
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
            onPressed: () async => _deeplinkX.launchApp(TencentMaps.open(fallbackToStore: _fallback)),
            child: const Text('Open Tencent Maps'),
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
            controller: _addressController,
            decoration: const InputDecoration(labelText: 'Address', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _launchView, child: const Text('Show Marker')),
          const SizedBox(height: 24),
          const Text('Search', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(labelText: 'Query', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _regionController,
            decoration: const InputDecoration(labelText: 'Region (optional)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _launchSearch, child: const Text('Search')),
          const SizedBox(height: 24),
          const Text('Nearby Search', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _nearbyQueryController,
            decoration: const InputDecoration(labelText: 'Query', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _nearbyLatController, lngController: _nearbyLngController),
          const SizedBox(height: 8),
          TextField(
            controller: _nearbyRadiusController,
            decoration: const InputDecoration(labelText: 'Radius meters', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _launchNearbySearch, child: const Text('Nearby Search')),
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
          DropdownButton<TencentMapsTravelMode>(
            value: _mode,
            isExpanded: true,
            onChanged: (final mode) => setState(() => _mode = mode ?? TencentMapsTravelMode.driving),
            items: const [
              DropdownMenuItem(value: TencentMapsTravelMode.driving, child: Text('Driving')),
              DropdownMenuItem(value: TencentMapsTravelMode.transit, child: Text('Transit')),
              DropdownMenuItem(value: TencentMapsTravelMode.walking, child: Text('Walking')),
              DropdownMenuItem(value: TencentMapsTravelMode.bicycling, child: Text('Bicycling')),
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

    await _deeplinkX.launchAction(
      TencentMaps.view(
        coordinate: coordinate,
        title: _titleController.text.isEmpty ? 'Location' : _titleController.text,
        address: _addressController.text.isEmpty ? null : _addressController.text,
        fallbackToStore: _fallback,
      ),
    );
  }

  Future<void> _launchSearch() async {
    if (_searchController.text.isEmpty) {
      _showInputError('Please enter a search query.');
      return;
    }

    await _deeplinkX.launchAction(
      TencentMaps.search(
        query: _searchController.text,
        region: _regionController.text.isEmpty ? null : _regionController.text,
        fallbackToStore: _fallback,
      ),
    );
  }

  Future<void> _launchNearbySearch() async {
    if (_nearbyQueryController.text.isEmpty) {
      _showInputError('Please enter a nearby search query.');
      return;
    }

    final center = _readRequiredCoordinate(_nearbyLatController, _nearbyLngController);
    if (center == null) {
      return;
    }

    final radius = int.tryParse(_nearbyRadiusController.text);
    if (radius == null) {
      _showInputError('Please enter a valid radius.');
      return;
    }

    await _deeplinkX.launchAction(
      TencentMaps.nearbySearch(
        query: _nearbyQueryController.text,
        center: center,
        radius: radius,
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
      TencentMaps.directionsWithCoords(
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
