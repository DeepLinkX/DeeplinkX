# Contribution Guidelines

These instructions apply to the entire repository.

- Format Dart code by running `dart format .` before committing.
- Ensure lint checks pass by running `flutter analyze`.
- Run all tests with `flutter test`.
- Document new features in `CHANGELOG.md` and update any relevant files under `doc/`.

## Adding A Navigation App

When introducing a new navigation app (e.g. Maps providers), follow this checklist:

1. **Implementation**
   - Create the app/action classes under `lib/src/apps/downloadable_apps/`.
   - Wire exports via `lib/src/apps/downloadable_apps/downloadable_apps.dart`.
   - Ensure custom schemes, store actions, supported platforms, and fallback links are defined.
   - Align navigation APIs with the existing pattern: provide at least a `view` action plus `directionsWithCoords` (or platform-equivalent) so navigation workflows stay consistent.
   - Reuse the established naming for navigation actions across code and docs (`View map`, `Search`, `Directions`, `Directions with coordinates`) so README tables, doc pages, changelog entries, and example labels stay in sync.

2. **Documentation**
   - Add a dedicated page in `doc/apps/` describing usage, configuration, and URL schemes.
   - Reference the new app everywhere it appears in `README.md` (feature bullet list, supported apps table, documentation list, etc.).

3. **Example App**
   - Provide a sample page in `example/lib/pages/` that demonstrates all supported actions.
   - Add the page to the grid/list in `example/lib/home.dart` and include required assets.

4. **Testing**
   - Add unit tests under `test/src/apps/` covering store actions, app links, and fallbacks.
   - Update the integration/coverage checks in `test/deeplink_x_test.dart` when necessary (e.g. exposed API lists).
   - Run `dart format .`, `flutter analyze`, and `flutter test` (via FVM if required).

5. **Release Artifacts**
   - Update `CHANGELOG.md` with the new feature entry.
   - Bump the version in `pubspec.yaml` and run `flutter pub get` (update `example/pubspec.lock` accordingly).
