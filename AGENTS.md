# Contribution Guidelines

These instructions apply to the entire repository.

- Format Dart code by running `dart format .` before committing.
- Ensure lint checks pass by running `flutter analyze`.
- Run all tests with `flutter test`.
- Document new features in `CHANGELOG.md` and update any relevant files under `doc/`.

## Keyword Reports

When creating or refreshing pub.dev keyword reports:

- Store reports under `doc/keywords/` with date-stamped filenames using `YYYY-MM-DD`.
- Keep `doc/keywords/README.md` updated with every new visibility or comparison report.
- Fetch current pub.dev package metadata, score data, rendered package page, and rendered score page before writing the report.
- Re-scan the previous report's keyword groups so comparisons remain stable.
- Derive app-specific keywords from the current supported app list in `README.md` and every `doc/apps/*.md` page, including newly added apps and navigation providers.
- For each supported app, scan at least `{app}`, `{app} link`, `{app} deeplink`, and human search phrases such as `open {app} from Flutter`.
- For map and navigation apps, also scan search, directions, coordinates, and provider-specific navigation phrases.
- Include expanded human-search phrases and Medium-derived article phrases.
- Wait through pub.dev rate limits with retry/backoff instead of skipping rate-limited queries.
- Create a comparison report when a previous snapshot exists.

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
   - When `map_launcher` supports the provider, record the checked release and date, compare its overlapping marker and directions behavior, and document intentional differences. Provider documentation and device results remain authoritative.
   - Run `dart format .`, `flutter analyze`, and `flutter test` (via FVM if required).

5. **Release Artifacts**
   - Update `CHANGELOG.md` with the new feature entry.
   - Bump the version in `pubspec.yaml` and run `flutter pub get` (update `example/pubspec.lock` accordingly).
