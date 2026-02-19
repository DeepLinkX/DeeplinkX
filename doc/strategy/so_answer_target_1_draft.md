# Stack Overflow Draft: Target 1

## Suggested question title
Flutter: open Telegram profile and fallback to store/web if app is not installed

## Draft answer
If you need Telegram deep links plus fallback behavior, you can do it with `deeplink_x` in one action call.

```dart
import 'package:deeplink_x/deeplink_x.dart';

final deeplinkX = DeeplinkX();

Future<void> openTelegramProfile() async {
  final launched = await deeplinkX.launchAction(
    Telegram.openProfile(
      username: 'deeplinkx',
      fallbackToStore: true,
    ),
  );

  if (!launched) {
    // Optional: show a snackbar/dialog as your final fallback UX.
  }
}
```

How this behaves:
1. Try native Telegram deep link first.
2. If Telegram is missing and `fallbackToStore: true`, try the platform store page.
3. If store open is unavailable, fallback to web link.
4. You can force no fallback using `disableFallback: true` in `launchAction`.

```dart
await deeplinkX.launchAction(
  Telegram.openProfile(username: 'deeplinkx', fallbackToStore: true),
  disableFallback: true,
);
```

Proof links:
- Core fallback flow: https://github.com/DeepLinkX/DeeplinkX/blob/master/lib/src/core/deeplink_x.dart
- Telegram docs and fallback details: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/apps/telegram.md
- Fallback recipe examples: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/recipes/fallback_strategy_examples.md
