import 'package:deeplink_x/deeplink_x.dart';
import 'package:flutter/material.dart';

/// Demonstrates deeplinks for Amap.
class AmapPage extends StatefulWidget {
  /// Creates the Amap example page.
  const AmapPage({super.key});

  @override
  State<AmapPage> createState() => _AmapPageState();
}

class _AmapPageState extends State<AmapPage> {
  final _deeplinkX = DeeplinkX();
  final _viewLatController = TextEditingController(text: '39.98848272');
  final _viewLngController = TextEditingController(text: '116.47560823');
  final _viewTitleController = TextEditingController(text: 'Amap HQ');
  final _searchController = TextEditingController(text: 'bank|fuel');
  final _topLeftLatController = TextEditingController();
  final _topLeftLngController = TextEditingController();
  final _bottomRightLatController = TextEditingController();
  final _bottomRightLngController = TextEditingController();
  final _directionsController = TextEditingController(text: 'Amap HQ');
  final _originLatController = TextEditingController();
  final _originLngController = TextEditingController();
  final _originTitleController = TextEditingController();
  final _destinationLatController = TextEditingController(text: '39.98848272');
  final _destinationLngController = TextEditingController(text: '116.47560823');
  final _destinationTitleController = TextEditingController(text: 'Amap HQ');
  final _waypointLatController = TextEditingController();
  final _waypointLngController = TextEditingController();
  final _waypointTitleController = TextEditingController();
  var _mode = AmapTravelMode.driving;
  var _convertFromWgs84 = false;
  var _fallback = true;

  @override
  void dispose() {
    _viewLatController.dispose();
    _viewLngController.dispose();
    _viewTitleController.dispose();
    _searchController.dispose();
    _topLeftLatController.dispose();
    _topLeftLngController.dispose();
    _bottomRightLatController.dispose();
    _bottomRightLngController.dispose();
    _directionsController.dispose();
    _originLatController.dispose();
    _originLngController.dispose();
    _originTitleController.dispose();
    _destinationLatController.dispose();
    _destinationLngController.dispose();
    _destinationTitleController.dispose();
    _waypointLatController.dispose();
    _waypointLngController.dispose();
    _waypointTitleController.dispose();
    super.dispose();
  }

  void _showInputError(final String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Coordinate? _readCoordinate({
    required final TextEditingController latController,
    required final TextEditingController lngController,
    required final String label,
    required final bool required,
  }) {
    final hasLat = latController.text.isNotEmpty;
    final hasLng = lngController.text.isNotEmpty;

    if (!hasLat && !hasLng && !required) {
      return null;
    }

    if (!hasLat || !hasLng) {
      _showInputError('Please enter both $label latitude and longitude.');
      return null;
    }

    final latitude = double.tryParse(latController.text);
    final longitude = double.tryParse(lngController.text);

    if (latitude == null || longitude == null) {
      _showInputError('Please enter valid $label coordinates.');
      return null;
    }

    return Coordinate(latitude: latitude, longitude: longitude);
  }

  AmapBounds? _readBounds() {
    final hasAnyBounds = [
      _topLeftLatController,
      _topLeftLngController,
      _bottomRightLatController,
      _bottomRightLngController,
    ].any((final controller) => controller.text.isNotEmpty);

    if (!hasAnyBounds) {
      return null;
    }

    final topLeft = _readCoordinate(
      latController: _topLeftLatController,
      lngController: _topLeftLngController,
      label: 'top-left',
      required: true,
    );
    final bottomRight = _readCoordinate(
      latController: _bottomRightLatController,
      lngController: _bottomRightLngController,
      label: 'bottom-right',
      required: true,
    );

    if (topLeft == null || bottomRight == null) {
      return null;
    }

    return AmapBounds(topLeft: topLeft, bottomRight: bottomRight);
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Amap')),
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
          Row(
            children: [
              const Text('Convert WGS84 coordinates:'),
              const SizedBox(width: 8),
              Switch(value: _convertFromWgs84, onChanged: (final value) => setState(() => _convertFromWgs84 = value)),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async => _deeplinkX.launchApp(Amap.open(fallbackToStore: _fallback)),
            child: const Text('Open Amap'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async => _deeplinkX.launchAction(Amap.myLocation(fallbackToStore: _fallback)),
            child: const Text('Show My Location'),
          ),
          const SizedBox(height: 24),
          const Text('View Map', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(latController: _viewLatController, lngController: _viewLngController),
          const SizedBox(height: 8),
          TextField(
            controller: _viewTitleController,
            decoration: const InputDecoration(labelText: 'Title (optional)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final coordinate = _readCoordinate(
                latController: _viewLatController,
                lngController: _viewLngController,
                label: 'view',
                required: true,
              );

              if (coordinate == null) {
                return;
              }

              await _deeplinkX.launchAction(
                Amap.view(
                  coordinate: coordinate,
                  title: _viewTitleController.text.isNotEmpty ? _viewTitleController.text : null,
                  convertFromWgs84: _convertFromWgs84,
                  fallbackToStore: _fallback,
                ),
              );
            },
            child: const Text('View Map'),
          ),
          const SizedBox(height: 24),
          const Text('Search', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(labelText: 'Query', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          _CoordinateRow(
            latController: _topLeftLatController,
            lngController: _topLeftLngController,
            latLabel: 'Top-left lat',
            lngLabel: 'Top-left lng',
          ),
          const SizedBox(height: 8),
          _CoordinateRow(
            latController: _bottomRightLatController,
            lngController: _bottomRightLngController,
            latLabel: 'Bottom-right lat',
            lngLabel: 'Bottom-right lng',
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_searchController.text.isEmpty) {
                _showInputError('Please enter a search query.');
                return;
              }

              final bounds = _readBounds();
              final hasBoundsInput = [
                _topLeftLatController,
                _topLeftLngController,
                _bottomRightLatController,
                _bottomRightLngController,
              ].any((final controller) => controller.text.isNotEmpty);

              if (hasBoundsInput && bounds == null) {
                return;
              }

              await _deeplinkX.launchAction(
                Amap.search(
                  query: _searchController.text,
                  bounds: bounds,
                  convertFromWgs84: _convertFromWgs84,
                  fallbackToStore: _fallback,
                ),
              );
            },
            child: const Text('Search Places'),
          ),
          const SizedBox(height: 24),
          const Text('Directions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _directionsController,
            decoration: const InputDecoration(labelText: 'Destination', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (_directionsController.text.isEmpty) {
                _showInputError('Please enter a destination.');
                return;
              }

              await _deeplinkX.launchAction(
                Amap.directions(destination: _directionsController.text, fallbackToStore: _fallback),
              );
            },
            child: const Text('Get Directions'),
          ),
          const SizedBox(height: 24),
          const Text('Directions with Coordinates', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CoordinateRow(
            latController: _originLatController,
            lngController: _originLngController,
            latLabel: 'Origin lat',
            lngLabel: 'Origin lng',
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _originTitleController,
            decoration: const InputDecoration(labelText: 'Origin title (optional)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          _CoordinateRow(
            latController: _destinationLatController,
            lngController: _destinationLngController,
            latLabel: 'Destination lat',
            lngLabel: 'Destination lng',
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _destinationTitleController,
            decoration: const InputDecoration(labelText: 'Destination title (optional)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          _CoordinateRow(
            latController: _waypointLatController,
            lngController: _waypointLngController,
            latLabel: 'Waypoint lat',
            lngLabel: 'Waypoint lng',
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _waypointTitleController,
            decoration: const InputDecoration(labelText: 'Waypoint title (optional)', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 8),
          DropdownButton<AmapTravelMode>(
            value: _mode,
            isExpanded: true,
            onChanged: (final mode) => setState(() => _mode = mode ?? AmapTravelMode.driving),
            items: [for (final mode in AmapTravelMode.values) DropdownMenuItem(value: mode, child: Text(mode.name))],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final origin = _readCoordinate(
                latController: _originLatController,
                lngController: _originLngController,
                label: 'origin',
                required: false,
              );
              final hasOriginInput = _originLatController.text.isNotEmpty || _originLngController.text.isNotEmpty;

              if (hasOriginInput && origin == null) {
                return;
              }

              final destination = _readCoordinate(
                latController: _destinationLatController,
                lngController: _destinationLngController,
                label: 'destination',
                required: true,
              );

              if (destination == null) {
                return;
              }

              final waypoint = _readCoordinate(
                latController: _waypointLatController,
                lngController: _waypointLngController,
                label: 'waypoint',
                required: false,
              );
              final hasWaypointInput = _waypointLatController.text.isNotEmpty || _waypointLngController.text.isNotEmpty;

              if (hasWaypointInput && waypoint == null) {
                return;
              }

              await _deeplinkX.launchAction(
                Amap.directionsWithCoords(
                  origin: origin,
                  originTitle: _originTitleController.text.isNotEmpty ? _originTitleController.text : null,
                  destination: destination,
                  destinationTitle:
                      _destinationTitleController.text.isNotEmpty ? _destinationTitleController.text : null,
                  waypoints: [
                    if (waypoint != null)
                      AmapWaypoint(
                        coordinate: waypoint,
                        title: _waypointTitleController.text.isNotEmpty ? _waypointTitleController.text : null,
                      ),
                  ],
                  mode: _mode,
                  convertFromWgs84: _convertFromWgs84,
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

class _CoordinateRow extends StatelessWidget {
  const _CoordinateRow({
    required this.latController,
    required this.lngController,
    this.latLabel = 'Latitude',
    this.lngLabel = 'Longitude',
  });

  final TextEditingController latController;
  final TextEditingController lngController;
  final String latLabel;
  final String lngLabel;

  @override
  Widget build(final BuildContext context) => Row(
    children: [
      Expanded(
        child: TextField(
          controller: latController,
          decoration: InputDecoration(labelText: latLabel, border: const OutlineInputBorder()),
          keyboardType: TextInputType.number,
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: TextField(
          controller: lngController,
          decoration: InputDecoration(labelText: lngLabel, border: const OutlineInputBorder()),
          keyboardType: TextInputType.number,
        ),
      ),
    ],
  );
}
