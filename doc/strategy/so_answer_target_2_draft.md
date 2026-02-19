# Stack Overflow Draft: Target 2

## Suggested question title
Flutter: open external app and redirect to App Store/Play Store if not installed

## Draft answer
If you want app deep links with store fallback, you can call `launchAction` and set `fallbackToStore: true` on the action.

```dart
import 'package:deeplink_x/deeplink_x.dart';

final deeplinkX = DeeplinkX();

Future<void> openInstagramProfile() async {
  final launched = await deeplinkX.launchAction(
    Instagram.openProfile(
      username: 'deeplinkx',
      fallbackToStore: true,
    ),
  );

  if (!launched) {
    // Optional: show local fallback UI.
  }
}
```

Behavior:
1. Try native app deep link first.
2. If app is missing and `fallbackToStore: true`, DeeplinkX tries store actions for current platform.
3. If store is not available, fallback can continue to web when supported.

If you need strict behavior (no fallback at all), set `disableFallback: true`:

```dart
await deeplinkX.launchAction(
  Instagram.openProfile(username: 'deeplinkx', fallbackToStore: true),
  disableFallback: true,
);
```

Proof links:
- Core flow: https://github.com/DeepLinkX/DeeplinkX/blob/master/lib/src/core/deeplink_x.dart
- Fallback recipes: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/recipes/fallback_strategy_examples.md
- Instagram docs: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/apps/instagram.md
