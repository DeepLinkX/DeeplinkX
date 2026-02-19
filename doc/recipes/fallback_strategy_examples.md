# Fallback Strategy Examples

DeeplinkX supports three practical fallback modes per action call.

## Pattern A: Native app + web fallback
Use this when you want web fallback but do not want store redirect.

```dart
await deeplinkX.launchAction(
  Telegram.openProfile(username: 'deeplinkx'),
);
```

## Pattern B: Native app + store fallback + web fallback
Use this when install flow is important for conversion.

```dart
await deeplinkX.launchAction(
  Instagram.openProfile(
    username: 'deeplinkx',
    fallbackToStore: true,
  ),
);
```

## Pattern C: No fallback
Use this when you want strict behavior and handle errors in-app.

```dart
final launched = await deeplinkX.launchAction(
  YouTube.openVideo(
    videoId: 'dQw4w9WgXcQ',
    fallbackToStore: true,
  ),
  disableFallback: true,
);

if (!launched) {
  // Show in-app error or alternative UI.
}
```

## Pattern D: App-level open with optional store fallback
Use this for simple "open app" buttons.

```dart
await deeplinkX.launchApp(
  Slack.open(fallbackToStore: true),
);
```

## Notes
1. `fallbackToStore` controls whether DeeplinkX tries store actions first.
2. `disableFallback` short-circuits all fallback behavior.
3. For provider-specific details, check files in `doc/apps/`.
