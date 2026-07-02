# Netflix Deeplinks

DeeplinkX supports opening Netflix, Netflix title pages, and playback links on Android, iOS, and Windows.

## Available Actions

### Launch Netflix

```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchApp(Netflix.open());
await deeplinkX.launchApp(Netflix.open(fallbackToStore: true));
await deeplinkX.launchApp(Netflix.open(), disableFallback: true);
```

### Open a Title Page

```dart
await deeplinkX.launchAction(
  Netflix.openTitle(titleId: '81215567', fallbackToStore: true),
);
```

### Watch a Title

```dart
await deeplinkX.launchAction(
  Netflix.watchTitle(titleId: '81215567', fallbackToStore: true),
);
```

## Platform Configuration

### iOS

Add the Netflix scheme to `ios/Runner/Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>nflx</string>
</array>
```

### Android

Add the Netflix package to `<queries>` in `android/app/src/main/AndroidManifest.xml`:

```xml
<package android:name="com.netflix.mediaclient" />
```

## Link Formats

- Open app: `nflx://`
- Title page: `nflx://www.netflix.com/title/{titleId}`
- Watch title: `nflx://www.netflix.com/watch/{titleId}`
- Web fallback: `https://www.netflix.com/title/{titleId}` or `https://www.netflix.com/watch/{titleId}`

## Fallback Behavior

1. DeeplinkX opens Netflix when installed.
2. If Netflix is not installed and `fallbackToStore` is `true`, DeeplinkX redirects to Google Play, the iOS App Store, or the Microsoft Store.
3. If store fallback is disabled or unavailable, DeeplinkX opens Netflix on the web.
4. Disable all fallbacks with `disableFallback: true`.

## Fallback Support Matrix

| Action       | Store Fallback | Web Fallback |
| ------------ | -------------- | ------------ |
| Open app     | Yes            | Yes          |
| Open title   | Yes            | Yes          |
| Watch title  | Yes            | Yes          |

## Check If Netflix Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(Netflix());
```
