# Draft Article 2

## Title
Flutter Deep Link Fallback Strategies: Native, Store, Web, and No-Fallback Modes

## Intro
Fallback behavior is where most deep-link bugs happen in production. A link that works on one device can fail on another because app install state, store availability, and platform behavior differ.

This guide shows a practical fallback model in Flutter using DeeplinkX.

## Fallback Modes

## Mode A: Native + web fallback
Use when web is acceptable and install conversion is not the goal.

```dart
await deeplinkX.launchAction(
  Telegram.openProfile(username: 'deeplinkx'),
);
```

## Mode B: Native + store + web
Use when install conversion matters.

```dart
await deeplinkX.launchAction(
  Instagram.openProfile(
    username: 'deeplinkx',
    fallbackToStore: true,
  ),
);
```

## Mode C: Strict no-fallback
Use when product policy requires explicit failure handling in-app.

```dart
final launched = await deeplinkX.launchAction(
  YouTube.openVideo(videoId: 'dQw4w9WgXcQ', fallbackToStore: true),
  disableFallback: true,
);
```

## Operational Guidance
1. Pick one fallback policy style for similar features.
2. Keep `fallbackToStore` intentional per feature.
3. Use strict mode only when a product requirement needs it.

## Common Mistakes
1. Enabling store fallback without validating store action metadata.
2. Mixing strict and non-strict behavior inconsistently across the app.
3. Publishing claims without proving fallback behavior from source/tests.

## Sources
- Fallback recipe: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/recipes/fallback_strategy_examples.md
- Telegram docs: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/apps/telegram.md
- Google Maps docs: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/apps/google_maps.md
- Core launch flow: https://github.com/DeepLinkX/DeeplinkX/blob/master/lib/src/core/deeplink_x.dart
