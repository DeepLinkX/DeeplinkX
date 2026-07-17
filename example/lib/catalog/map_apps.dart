import 'package:deeplink_x/deeplink_x.dart';
import 'package:deeplink_x_example/catalog/models.dart';
import 'package:flutter/material.dart';

ActionField _latField({required final String value, final String key = 'lat', final String label = 'Latitude'}) =>
    ActionField(key: key, label: label, defaultValue: value, validator: FieldValidator.latitude);

ActionField _lngField({required final String value, final String key = 'lng', final String label = 'Longitude'}) =>
    ActionField(key: key, label: label, defaultValue: value, validator: FieldValidator.longitude);

const List<ActionField> _originFields = [
  ActionField(
    key: 'originLat',
    label: 'Origin latitude (optional)',
    optional: true,
    validator: FieldValidator.latitude,
  ),
  ActionField(
    key: 'originLng',
    label: 'Origin longitude (optional)',
    optional: true,
    validator: FieldValidator.longitude,
  ),
];

String? _validateOrigin(final ActionValues values) => validateOptionalPair(values, 'originLat', 'originLng', 'origin');

/// Maps and navigation apps shown in the example gallery.
final List<AppSpec> mapApps = [
  AppSpec(
    id: 'google_maps',
    name: 'Google Maps',
    assetName: 'assets/google_maps.png',
    category: CatalogCategory.maps,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'GoogleMaps.open(fallbackToStore)',
        buttonLabel: 'Open Google Maps',
        runner: OpenAppRunner(({required final fallbackToStore}) => GoogleMaps.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.map_rounded,
        title: 'View map',
        apiLabel: 'GoogleMaps.view(coordinate)',
        buttonLabel: 'View location',
        fields: [_latField(value: '37.7749'), _lngField(value: '-122.4194')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              GoogleMaps.view(coordinate: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.search_rounded,
        title: 'Search location',
        apiLabel: 'GoogleMaps.search(query)',
        buttonLabel: 'Search',
        fields: const [ActionField(key: 'query', label: 'Query', defaultValue: 'coffee near me')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              GoogleMaps.search(query: v.value('query'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.signpost_rounded,
        title: 'Directions',
        apiLabel: 'GoogleMaps.directions(destination, origin)',
        buttonLabel: 'Get directions',
        fields: const [
          ActionField(key: 'destination', label: 'Destination', defaultValue: 'Eiffel Tower, Paris'),
          ActionField(key: 'origin', label: 'Origin (optional)', optional: true),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => GoogleMaps.directions(
            destination: v.value('destination'),
            origin: v.optionalValue('origin'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.near_me_rounded,
        title: 'Directions with coordinates',
        apiLabel: 'GoogleMaps.directionsWithCoords(destination, origin)',
        buttonLabel: 'Navigate',
        fields: [_latField(value: '37.7749'), _lngField(value: '-122.4194'), ..._originFields],
        validate: _validateOrigin,
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => GoogleMaps.directionsWithCoords(
            destination: v.coordinate('lat', 'lng'),
            origin: v.optionalCoordinate('originLat', 'originLng'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'amap',
    name: 'Amap',
    assetName: 'assets/amap.png',
    category: CatalogCategory.maps,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Amap.open(fallbackToStore)',
        buttonLabel: 'Open Amap',
        runner: OpenAppRunner(({required final fallbackToStore}) => Amap.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.my_location_rounded,
        title: 'My location',
        apiLabel: 'Amap.myLocation()',
        buttonLabel: 'Show my location',
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => Amap.myLocation(fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.map_rounded,
        title: 'View map',
        apiLabel: 'Amap.view(coordinate, title)',
        buttonLabel: 'View location',
        fields: [
          _latField(value: '39.98848272'),
          _lngField(value: '116.47560823'),
          const ActionField(key: 'title', label: 'Title (optional)', defaultValue: 'Amap HQ', optional: true),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => Amap.view(
            coordinate: v.coordinate('lat', 'lng'),
            title: v.optionalValue('title'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.search_rounded,
        title: 'Search',
        apiLabel: 'Amap.search(query)',
        buttonLabel: 'Search',
        fields: const [ActionField(key: 'query', label: 'Query', defaultValue: 'bank|fuel')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Amap.search(query: v.value('query'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.signpost_rounded,
        title: 'Directions',
        apiLabel: 'Amap.directions(destination)',
        buttonLabel: 'Get directions',
        fields: const [ActionField(key: 'destination', label: 'Destination', defaultValue: 'Amap HQ')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Amap.directions(destination: v.value('destination'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.near_me_rounded,
        title: 'Directions with coordinates',
        apiLabel: 'Amap.directionsWithCoords(destination, origin)',
        buttonLabel: 'Navigate',
        fields: [_latField(value: '39.98848272'), _lngField(value: '116.47560823'), ..._originFields],
        validate: _validateOrigin,
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => Amap.directionsWithCoords(
            destination: v.coordinate('lat', 'lng'),
            origin: v.optionalCoordinate('originLat', 'originLng'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'baidu_maps',
    name: 'Baidu Maps',
    assetName: 'assets/baidu_maps.png',
    category: CatalogCategory.maps,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'BaiduMaps.open(fallbackToStore)',
        buttonLabel: 'Open Baidu Maps',
        runner: OpenAppRunner(({required final fallbackToStore}) => BaiduMaps.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.location_on_rounded,
        title: 'View map',
        apiLabel: 'BaiduMaps.view(coordinate, title)',
        buttonLabel: 'View location',
        fields: [
          _latField(value: '39.915'),
          _lngField(value: '116.404'),
          const ActionField(key: 'title', label: 'Title (optional)', defaultValue: 'Tiananmen', optional: true),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => BaiduMaps.view(
            coordinate: v.coordinate('lat', 'lng'),
            title: v.optionalValue('title'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.search_rounded,
        title: 'Search',
        apiLabel: 'BaiduMaps.search(query, region)',
        buttonLabel: 'Search',
        fields: const [
          ActionField(key: 'query', label: 'Query', defaultValue: 'coffee'),
          ActionField(key: 'region', label: 'Region (optional)', defaultValue: 'Beijing', optional: true),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => BaiduMaps.search(
            query: v.value('query'),
            region: v.optionalValue('region'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.travel_explore_rounded,
        title: 'Nearby search',
        apiLabel: 'BaiduMaps.nearbySearch(query, center)',
        buttonLabel: 'Search nearby',
        fields: [
          const ActionField(key: 'query', label: 'Query', defaultValue: 'coffee'),
          _latField(key: 'centerLat', label: 'Center latitude', value: '39.915'),
          _lngField(key: 'centerLng', label: 'Center longitude', value: '116.404'),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => BaiduMaps.nearbySearch(
            query: v.value('query'),
            center: v.coordinate('centerLat', 'centerLng'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.route_rounded,
        title: 'Transit line',
        apiLabel: 'BaiduMaps.line(name, region)',
        buttonLabel: 'Show line',
        fields: const [
          ActionField(key: 'name', label: 'Line name', defaultValue: 'Line 1'),
          ActionField(key: 'region', label: 'Region (optional)', defaultValue: 'Beijing', optional: true),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => BaiduMaps.line(
            name: v.value('name'),
            region: v.optionalValue('region'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.signpost_rounded,
        title: 'Directions',
        apiLabel: 'BaiduMaps.directions(destination, origin)',
        buttonLabel: 'Get directions',
        fields: const [
          ActionField(key: 'destination', label: 'Destination', defaultValue: 'Tiananmen'),
          ActionField(
            key: 'origin',
            label: 'Origin (optional)',
            defaultValue: 'Beijing Railway Station',
            optional: true,
          ),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => BaiduMaps.directions(
            destination: v.value('destination'),
            origin: v.optionalValue('origin'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.near_me_rounded,
        title: 'Directions with coordinates',
        apiLabel: 'BaiduMaps.directionsWithCoords(destination, origin)',
        buttonLabel: 'Navigate',
        fields: [_latField(value: '39.915'), _lngField(value: '116.404'), ..._originFields],
        validate: _validateOrigin,
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => BaiduMaps.directionsWithCoords(
            destination: v.coordinate('lat', 'lng'),
            origin: v.optionalCoordinate('originLat', 'originLng'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.navigation_rounded,
        title: 'Navigation',
        apiLabel: 'BaiduMaps.navigate(destination)',
        buttonLabel: 'Start navigation',
        fields: [_latField(value: '39.915'), _lngField(value: '116.404')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              BaiduMaps.navigate(destination: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
  AppSpec(
    id: '2gis',
    name: '2GIS',
    assetName: 'assets/2gis.png',
    category: CatalogCategory.maps,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'TwoGis.open(fallbackToStore)',
        buttonLabel: 'Open 2GIS',
        runner: OpenAppRunner(({required final fallbackToStore}) => TwoGis.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.map_rounded,
        title: 'View map',
        apiLabel: 'TwoGis.view(coordinate)',
        buttonLabel: 'View location',
        fields: [_latField(value: '55.76009'), _lngField(value: '37.648801')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              TwoGis.view(coordinate: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.near_me_rounded,
        title: 'Directions with coordinates',
        apiLabel: 'TwoGis.directionsWithCoords(destination, origin)',
        buttonLabel: 'Navigate',
        fields: [_latField(value: '55.76009'), _lngField(value: '37.648801'), ..._originFields],
        validate: _validateOrigin,
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => TwoGis.directionsWithCoords(
            destination: v.coordinate('lat', 'lng'),
            origin: v.optionalCoordinate('originLat', 'originLng'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'waze',
    name: 'Waze',
    assetName: 'assets/waze.png',
    category: CatalogCategory.maps,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Waze.open(fallbackToStore)',
        buttonLabel: 'Open Waze',
        runner: OpenAppRunner(({required final fallbackToStore}) => Waze.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.map_rounded,
        title: 'View map',
        apiLabel: 'Waze.view(coordinate)',
        buttonLabel: 'View location',
        fields: [_latField(value: '45.6906304'), _lngField(value: '-120.810983')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Waze.view(coordinate: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.search_rounded,
        title: 'Search',
        apiLabel: 'Waze.search(query)',
        buttonLabel: 'Search',
        fields: const [ActionField(key: 'query', label: 'Query', defaultValue: '66 Acacia Avenue')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Waze.search(query: v.value('query'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.signpost_rounded,
        title: 'Directions',
        apiLabel: 'Waze.directions(destination)',
        buttonLabel: 'Get directions',
        fields: const [ActionField(key: 'destination', label: 'Destination', defaultValue: '66 Acacia Avenue')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Waze.directions(destination: v.value('destination'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.near_me_rounded,
        title: 'Directions with coordinates',
        apiLabel: 'Waze.directionsWithCoords(destination)',
        buttonLabel: 'Navigate',
        fields: [_latField(value: '45.6906304'), _lngField(value: '-120.810983')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Waze.directionsWithCoords(destination: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'apple_maps',
    name: 'Apple Maps',
    assetName: 'assets/apple_maps.png',
    category: CatalogCategory.maps,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'AppleMaps.open(fallbackToStore)',
        buttonLabel: 'Open Apple Maps',
        runner: OpenAppRunner(({required final fallbackToStore}) => AppleMaps.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.map_rounded,
        title: 'View map',
        apiLabel: 'AppleMaps.view(coordinate)',
        buttonLabel: 'View location',
        fields: [_latField(value: '37.3349'), _lngField(value: '-122.0090')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              AppleMaps.view(coordinate: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.search_rounded,
        title: 'Search location',
        apiLabel: 'AppleMaps.search(query)',
        buttonLabel: 'Search',
        fields: const [ActionField(key: 'query', label: 'Query', defaultValue: 'Apple Park')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              AppleMaps.search(query: v.value('query'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.signpost_rounded,
        title: 'Directions',
        apiLabel: 'AppleMaps.directions(destination, origin)',
        buttonLabel: 'Get directions',
        fields: const [
          ActionField(key: 'destination', label: 'Destination', defaultValue: 'San Jose'),
          ActionField(key: 'origin', label: 'Origin (optional)', defaultValue: 'Cupertino', optional: true),
        ],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => AppleMaps.directions(
            destination: v.value('destination'),
            origin: v.optionalValue('origin'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.near_me_rounded,
        title: 'Directions with coordinates',
        apiLabel: 'AppleMaps.directionsWithCoords(destination, origin)',
        buttonLabel: 'Navigate',
        fields: [_latField(value: '37.3349'), _lngField(value: '-122.0090'), ..._originFields],
        validate: _validateOrigin,
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => AppleMaps.directionsWithCoords(
            destination: v.coordinate('lat', 'lng'),
            origin: v.optionalCoordinate('originLat', 'originLng'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'sygic',
    name: 'Sygic',
    assetName: 'assets/sygic.png',
    category: CatalogCategory.maps,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Sygic.open(fallbackToStore)',
        buttonLabel: 'Open Sygic',
        runner: OpenAppRunner(({required final fallbackToStore}) => Sygic.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.map_rounded,
        title: 'View map',
        apiLabel: 'Sygic.view(coordinate)',
        buttonLabel: 'View location',
        fields: [_latField(value: '48.1486'), _lngField(value: '17.1077')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Sygic.view(coordinate: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.near_me_rounded,
        title: 'Directions with coordinates',
        apiLabel: 'Sygic.directionsWithCoords(destination)',
        buttonLabel: 'Navigate',
        fields: [_latField(value: '48.1486'), _lngField(value: '17.1077')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Sygic.directionsWithCoords(destination: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'moovit',
    name: 'Moovit',
    assetName: 'assets/moovit.png',
    category: CatalogCategory.maps,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Moovit.open(fallbackToStore)',
        buttonLabel: 'Open Moovit',
        runner: OpenAppRunner(({required final fallbackToStore}) => Moovit.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.map_rounded,
        title: 'View map',
        apiLabel: 'Moovit.view(coordinate)',
        buttonLabel: 'View location',
        fields: [_latField(value: '40.7128'), _lngField(value: '-74.0060')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Moovit.view(coordinate: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.near_me_rounded,
        title: 'Directions with coordinates',
        apiLabel: 'Moovit.directionsWithCoords(destination, origin)',
        buttonLabel: 'Navigate',
        fields: [_latField(value: '40.7527'), _lngField(value: '-73.9772'), ..._originFields],
        validate: _validateOrigin,
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => Moovit.directionsWithCoords(
            destination: v.coordinate('lat', 'lng'),
            origin: v.optionalCoordinate('originLat', 'originLng'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'neshan',
    name: 'Neshan',
    assetName: 'assets/neshan.png',
    category: CatalogCategory.maps,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'Neshan.open(fallbackToStore)',
        buttonLabel: 'Open Neshan',
        runner: OpenAppRunner(({required final fallbackToStore}) => Neshan.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.map_rounded,
        title: 'View map',
        apiLabel: 'Neshan.view(coordinate)',
        buttonLabel: 'View location',
        fields: [_latField(value: '35.6892'), _lngField(value: '51.3890')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              Neshan.view(coordinate: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.near_me_rounded,
        title: 'Directions with coordinates',
        apiLabel: 'Neshan.directionsWithCoords(destination, origin)',
        buttonLabel: 'Navigate',
        fields: [_latField(value: '35.7000'), _lngField(value: '51.4000'), ..._originFields],
        validate: _validateOrigin,
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => Neshan.directionsWithCoords(
            destination: v.coordinate('lat', 'lng'),
            origin: v.optionalCoordinate('originLat', 'originLng'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
    ],
  ),
  AppSpec(
    id: 'yandex_maps',
    name: 'Yandex Maps',
    assetName: 'assets/yandex_maps.png',
    category: CatalogCategory.maps,
    actions: [
      ActionSpec(
        icon: Icons.open_in_new_rounded,
        title: 'Open app',
        apiLabel: 'YandexMaps.open(fallbackToStore)',
        buttonLabel: 'Open Yandex Maps',
        runner: OpenAppRunner(({required final fallbackToStore}) => YandexMaps.open(fallbackToStore: fallbackToStore)),
      ),
      ActionSpec(
        icon: Icons.public_rounded,
        title: 'Open map',
        apiLabel: 'YandexMaps.openMap()',
        buttonLabel: 'Open map',
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => YandexMaps.openMap(fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.map_rounded,
        title: 'View map',
        apiLabel: 'YandexMaps.view(coordinate)',
        buttonLabel: 'View location',
        fields: [_latField(value: '55.7558'), _lngField(value: '37.6173')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              YandexMaps.view(coordinate: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.search_rounded,
        title: 'Search',
        apiLabel: 'YandexMaps.search(query)',
        buttonLabel: 'Search',
        fields: const [ActionField(key: 'query', label: 'Query', defaultValue: 'cafe with wi-fi')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              YandexMaps.search(query: v.value('query'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.storefront_rounded,
        title: 'Organization card',
        apiLabel: 'YandexMaps.organization(objectId)',
        buttonLabel: 'Open card',
        fields: const [ActionField(key: 'objectId', label: 'Organization ID', defaultValue: '1221676748')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              YandexMaps.organization(objectId: v.value('objectId'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.not_listed_location_rounded,
        title: 'What is here',
        apiLabel: 'YandexMaps.whatIsHere(coordinate)',
        buttonLabel: 'What is here',
        fields: [_latField(value: '55.7558'), _lngField(value: '37.6173')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              YandexMaps.whatIsHere(coordinate: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
      ActionSpec(
        icon: Icons.near_me_rounded,
        title: 'Directions with coordinates',
        apiLabel: 'YandexMaps.directionsWithCoords(destination, origin)',
        buttonLabel: 'Navigate',
        fields: [_latField(value: '55.7558'), _lngField(value: '37.6173'), ..._originFields],
        validate: _validateOrigin,
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) => YandexMaps.directionsWithCoords(
            destination: v.coordinate('lat', 'lng'),
            origin: v.optionalCoordinate('originLat', 'originLng'),
            fallbackToStore: fallbackToStore,
          ),
        ),
      ),
      ActionSpec(
        icon: Icons.panorama_rounded,
        title: 'Panorama',
        apiLabel: 'YandexMaps.panorama(coordinate)',
        buttonLabel: 'Open panorama',
        fields: [_latField(value: '55.7558'), _lngField(value: '37.6173')],
        runner: AppActionRunner(
          (final v, {required final fallbackToStore}) =>
              YandexMaps.panorama(coordinate: v.coordinate('lat', 'lng'), fallbackToStore: fallbackToStore),
        ),
      ),
    ],
  ),
];
