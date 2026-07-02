# ChatGPT Deeplinks

DeeplinkX supports opening ChatGPT and stable ChatGPT web links on Android, iOS, and Windows.

## Available Actions

### Launch ChatGPT

```dart
final deeplinkX = DeeplinkX();

await deeplinkX.launchApp(ChatGPT.open());
await deeplinkX.launchApp(ChatGPT.open(fallbackToStore: true));
await deeplinkX.launchApp(ChatGPT.open(), disableFallback: true);
```

### Open a Shared Conversation

```dart
await deeplinkX.launchAction(
  ChatGPT.openSharedConversation(shareId: 'abc123', fallbackToStore: true),
);
```

### Open a GPT

```dart
await deeplinkX.launchAction(
  ChatGPT.openGpt(gptId: 'g-abc123', fallbackToStore: true),
);
```

## Platform Configuration

### iOS

Add the ChatGPT scheme to `ios/Runner/Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>chatgpt</string>
</array>
```

### Android

Add the ChatGPT package to `<queries>` in `android/app/src/main/AndroidManifest.xml`:

```xml
<package android:name="com.openai.chatgpt" />
```

## Link Formats

- Open app: `chatgpt://`
- Shared conversation: `https://chatgpt.com/share/{shareId}`
- GPT: `https://chatgpt.com/g/{gptId}`

## Fallback Behavior

1. DeeplinkX opens ChatGPT when installed.
2. If ChatGPT is not installed and `fallbackToStore` is `true`, DeeplinkX redirects to Google Play, the iOS App Store, or the Microsoft Store.
3. If store fallback is disabled or unavailable, DeeplinkX opens the matching ChatGPT web URL.
4. Disable all fallbacks with `disableFallback: true`.

## Fallback Support Matrix

| Action               | Store Fallback | Web Fallback |
| -------------------- | -------------- | ------------ |
| Open app             | Yes            | Yes          |
| Open shared conversation | Yes        | Yes          |
| Open GPT             | Yes            | Yes          |

## Check If ChatGPT Is Installed

```dart
final deeplinkX = DeeplinkX();
final isInstalled = await deeplinkX.isAppInstalled(ChatGPT());
```
