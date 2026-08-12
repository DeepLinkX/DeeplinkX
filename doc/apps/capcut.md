# CapCut Deeplinks

DeeplinkX supports opening CapCut and CapCut template links on Android, iOS, and Windows.

## References

- CapCut template jump support: <https://www.capcut.com/help/template-jump-exception>

## Available Actions

### Launch CapCut

```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchApp(CapCut.open());
await deeplinkX.launchApp(CapCut.open(fallbackToStore: true));
await deeplinkX.launchApp(CapCut.open(), disableFallback: true);
```

### Open a Template Link

```dart
await deeplinkX.launchAction(
  CapCut.openTemplate(
    templateLink: Uri.parse('https://www.capcut.com/template-detail/example/1'),
    fallbackToStore: true,
  ),
);
```

## Platform Configuration

### iOS

Add the CapCut scheme to `ios/Runner/Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>capcut</string>
</array>
```

### Android

Add the CapCut package to `<queries>` in `android/app/src/main/AndroidManifest.xml`:

```xml
<package android:name="com.lemon.lvoverseas" />
```

## Link Formats

- Open app: `capcut://`
- Template links: CapCut share/template URLs such as `https://www.capcut.com/template-detail/...`

## Fallback Behavior

1. DeeplinkX opens CapCut when installed.
2. If CapCut is not installed and `fallbackToStore` is `true`, DeeplinkX redirects to Google Play, the iOS App Store, or the Microsoft Store.
3. If store fallback is disabled or unavailable, DeeplinkX opens the CapCut web page or the provided template link.
4. Disable all fallbacks with `disableFallback: true`.

## Fallback Support Matrix

| Action             | Store Fallback | Web Fallback |
| ------------------ | -------------- | ------------ |
| Open app           | Yes            | Yes          |
| Open template link | Yes            | Yes          |

## Check If CapCut Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(CapCut());
```
