# Contribution Guidelines

These instructions apply to the entire repository.

- Format Dart code by running `dart format .` before committing.
- Ensure lint checks pass by running `flutter analyze`.
- Run all tests with `flutter test`.
- Document new features in `CHANGELOG.md` and update any relevant files under `doc/`.
- In `CHANGELOG.md`, keep each release as a `## <version>` heading and group entries under populated `###` headings in this order: `Breaking Changes`, `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Performance`, `Security`. Omit empty categories and do not add a `# Changelog` heading.

## Adding A Navigation App

When introducing a new navigation app (e.g. Maps providers), follow this checklist:

1. **Implementation**
   - Create the app/action classes under `lib/src/apps/downloadable_apps/`.
   - Wire exports via `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
   - Ensure custom schemes, store actions, supported platforms, and fallback links are defined.
   - Align navigation APIs with the existing pattern: provide at least a `view` action plus `directionsWithCoords` (or platform-equivalent) so navigation workflows stay consistent.
   - Implement the relevant map action abstractions (`MapViewAction`, `MapSearchAction`, `MapDirectionsAction`, `MapDirectionsWithCoordsAction`) on each navigation action so the shared map launch utilities can use it.
   - Reuse the established naming for navigation actions across code and docs (`View map`, `Search`, `Directions`, `Directions with coordinates`) so README tables, doc pages, changelog entries, and example labels stay in sync.

2. **Documentation**
   - Add a dedicated page in `doc/apps/` describing usage, configuration, and URL schemes.
   - Reference the new app everywhere it appears in `README.md` (feature counts and app list, supported apps table, documentation list, recipes, etc.).
   - Add the new provider action to the README map launch utility examples when it supports one of the shared map action abstractions.
   - Keep README code snippets aligned with public API names and constructor parameters.

3. **Example App**
   - Add an `AppSpec` entry to `example/lib/catalog/map_apps.dart` (or `social_apps.dart` / `stores.dart`) covering all supported actions with real API labels and sensible default inputs; the home gallery and detail screen are generated from the catalog.
   - Include the required logo asset under `example/assets/` and keep `example/test/catalog_test.dart` counts passing.
   - Add every required app and store scheme to `example/ios/Runner/Info.plist` under `LSApplicationQueriesSchemes`.
   - Add every required package and intent visibility query to `example/android/app/src/main/AndroidManifest.xml`.
   - Avoid duplicate platform entries and verify both example configuration files after updating them.

4. **Testing**
   - Add unit tests under `test/src/apps/` covering store actions, app links, and fallbacks.
   - Update the integration/coverage checks in `test/deeplink_x_test.dart` when necessary (e.g. exposed API lists).
   - Use first-party provider documentation and store listings as implementation evidence. Record the checked sources and dates, document intentional limitations, and treat device results as the runtime authority; do not use third-party package implementations as behavioral references.
   - Run `dart format .`, `flutter analyze`, and `flutter test` (via FVM if required).

5. **Release Artifacts**
   - Update `CHANGELOG.md` with the new feature entry.
   - Bump the version in `pubspec.yaml` and run `flutter pub get` (update `example/pubspec.lock` accordingly).
