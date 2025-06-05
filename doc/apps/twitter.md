# Twitter Deeplinks

DeeplinkX provides comprehensive support for Twitter deep linking actions.

## Available Actions

### Launch Twitter App
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(Twitter.open());

// Launch with store fallback if not installed
await deeplinkX.launchApp(Twitter.open(fallbackToStore: true));

// Launch with fallback disabled
await deeplinkX.launchApp(Twitter.open(), disableFallback: true);
```

### Open Profile Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(Twitter.openProfile(username: 'twitter')); // Twitter username

// Action with store fallback if not installed
await deeplinkX.launchAction(Twitter.openProfile(
  username: 'twitter', // Twitter username
  fallbackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  Twitter.openProfile(username: 'twitter'), // Twitter username
  disableFallback: true,
);
```

### Open Tweet Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(Twitter.openTweet(tweetId: '1234567890')); // Twitter tweet ID

// Action with store fallback if not installed
await deeplinkX.launchAction(Twitter.openTweet(
  tweetId: '1234567890', // Twitter tweet ID
  fallbackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  Twitter.openTweet(tweetId: '1234567890'), // Twitter tweet ID
  disableFallback: true,
);
```

### Search Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(Twitter.search(query: 'flutter')); // Search query

// Action with store fallback if not installed
await deeplinkX.launchAction(Twitter.search(
  query: 'flutter', // Search query
  fallbackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  Twitter.search(query: 'flutter'), // Search query
  disableFallback: true,
);
```

## Parameter Validations

### Username Validation
Twitter usernames must follow these rules:
- Length: 1-15 characters
- Can contain letters, numbers, and underscores
- Cannot contain spaces or special characters
- Cannot start with a number or underscore
- Cannot end with an underscore
- Cannot contain consecutive underscores

Example valid usernames:
- `twitter`
- `elonmusk`
- `flutter_dev`

Example invalid usernames:
- `_twitter` (starts with underscore)
- `twitter_` (ends with underscore)
- `twitter__dev` (consecutive underscores)
- `twitter dev` (contains space)
- `twitter@dev` (contains special character)

### Tweet ID Validation
Twitter tweet IDs must follow these rules:
- Must be a valid numeric string
- Cannot be empty

## Platform-Specific Configuration

### iOS
Add the following to your `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>twitter</string>
    <string>itms-apps</string>
</array>
```

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <!-- For Twitter app -->
    <package android:name="com.twitter.android" />
    
    <!-- For Play Store fallback (if using fallbackToStore) -->
    <package android:name="com.android.vending" />
    
    <!-- For web fallback (required) -->
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>
```

## URL Schemes

DeeplinkX uses the following URL schemes for Twitter:

### Native App Deep Links
When Twitter is installed, the following scheme is used:
- `twitter://` - Native Twitter URL scheme
- For profiles: `twitter://user?screen_name={username}`
- For tweets: `twitter://status?id={tweetId}`
- For search: `twitter://search?query={query}`

### Web Fallback URLs
When Twitter is not installed, DeeplinkX automatically falls back to:
- `https://twitter.com` - Official Twitter web URL
- For profiles: `https://twitter.com/{username}`
- For tweets: `https://twitter.com/i/status/{tweetId}`
- For search: `https://twitter.com/search?q={query}`

## Supported Fallback Stores
When the Twitter app is not installed, DeeplinkX can redirect users to download Twitter from the following app stores:

- iOS App Store
- Google Play Store

To enable fallback to app stores, use the `fallbackToStore` parameter:

```dart
final deeplinkX = DeeplinkX();
await deeplinkX.launchApp(Twitter.open(fallbackToStore: true));
```

## Fallback Behavior
DeeplinkX follows this sequence when handling Twitter deeplinks:

1. First, it attempts to launch the Twitter app if it's installed on the device.
2. If the Twitter app is not installed and `fallbackToStore` is set to `true`, it will redirect to the appropriate app store based on the user's platform (iOS App Store or Google Play Store).
3. If no supported store is available for the current platform or the store app cannot be launched, it will fall back to opening the Twitter web interface in the default browser.
4. You can disable all fallbacks by setting `disableFallback: true` in the launch methods.

## Fallback Support for Actions

| Action      | Store Fallback | Web Fallback |
| ----------- | -------------- | ------------ |
| open        | ✅              | ✅            |
| openProfile | ✅              | ✅            |
| openTweet   | ✅              | ✅            |
| search      | ✅              | ✅            |