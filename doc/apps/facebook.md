# Facebook Deeplinks

DeeplinkX provides comprehensive support for Facebook deep linking actions.

## Available Actions

### Launch Facebook App
```dart
final deeplinkX = DeeplinkX();

// Simple launch
await deeplinkX.launchApp(Facebook.open());

// Launch with store fallback if not installed
await deeplinkX.launchApp(Facebook.open(fallBackToStore: true));

// Launch with fallback disabled
await deeplinkX.launchApp(Facebook.open(), disableFallback: true);
```

### Open Profile by ID Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(Facebook.openProfileById(id: 'profileId')); // Facebook numeric ID (e.g. '123456789')

// Action with store fallback if not installed
await deeplinkX.launchAction(Facebook.openProfileById(
  id: 'profileId', // Facebook numeric ID (e.g. '123456789')
  fallBackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  Facebook.openProfileById(id: 'profileId'), // Facebook numeric ID (e.g. '123456789')
  disableFallback: true,
);
```

### Open Profile by Username Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(Facebook.openProfileByUsername(username: 'username')); // Facebook username (e.g. 'zuck' for Mark Zuckerberg)

// Action with store fallback if not installed
await deeplinkX.launchAction(Facebook.openProfileByUsername(
  username: 'username', // Facebook username (e.g. 'zuck' for Mark Zuckerberg)
  fallBackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  Facebook.openProfileByUsername(username: 'username'), // Facebook username (e.g. 'zuck' for Mark Zuckerberg)
  disableFallback: true,
);
```

### Open Page Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(Facebook.openPage(pageId: 'pageId')); // Facebook page ID (e.g. 'facebookapp' for Facebook's official page)

// Action with store fallback if not installed
await deeplinkX.launchAction(Facebook.openPage(
  pageId: 'pageId', // Facebook page ID (e.g. 'facebookapp' for Facebook's official page)
  fallBackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  Facebook.openPage(pageId: 'pageId'), // Facebook page ID (e.g. 'facebookapp' for Facebook's official page)
  disableFallback: true,
);
```

### Open Group Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(Facebook.openGroup(groupId: 'groupId')); // Facebook group ID (e.g. '231104380821004' for Flutter Community group)

// Action with store fallback if not installed
await deeplinkX.launchAction(Facebook.openGroup(
  groupId: 'groupId', // Facebook group ID (e.g. '231104380821004' for Flutter Community group)
  fallBackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  Facebook.openGroup(groupId: 'groupId'), // Facebook group ID (e.g. '231104380821004' for Flutter Community group)
  disableFallback: true,
);
```

### Open Event Action
```dart
final deeplinkX = DeeplinkX();

// Simple action
await deeplinkX.launchAction(Facebook.openEvent(eventId: 'eventId')); // Facebook event ID (e.g. '10155945715431729' for F8 Conference)

// Action with store fallback if not installed
await deeplinkX.launchAction(Facebook.openEvent(
  eventId: 'eventId', // Facebook event ID (e.g. '10155945715431729' for F8 Conference)
  fallBackToStore: true,
));

// Action with fallback disabled
await deeplinkX.launchAction(
  Facebook.openEvent(eventId: 'eventId'), // Facebook event ID (e.g. '10155945715431729' for F8 Conference)
  disableFallback: true,
);
```

## Parameter Validations

### ID Validation
Facebook IDs must be valid numeric or alphanumeric identifiers assigned by Facebook.

### Username Validation
Facebook usernames must follow these rules:
- Length: 5-50 characters
- Can contain letters, numbers, and periods
- Cannot contain spaces or special characters
- Cannot start or end with a period
- Cannot contain consecutive periods

## Platform-Specific Configuration

### iOS
Add the following to your `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>fb</string>
    <string>itms-apps</string>
</array>
```

### Android
Add the following to your `android/app/src/main/AndroidManifest.xml` inside the `<queries>` tag:
```xml
<queries>
    <!-- For Facebook app -->
    <package android:name="com.facebook.katana" />
    
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

DeeplinkX uses the following URL schemes for Facebook:

### Native App Deep Links
When Facebook is installed, the following schemes are used:
- `fb://` - Native Facebook URL scheme
- For profiles by ID: `fb://profile/{id}`
- For profiles by username: `https://www.facebook.com/{username}` (uses universal link)
- For pages: `https://www.facebook.com/{pageId}` (uses universal link)
- For groups: `https://www.facebook.com/groups/{groupId}` (uses universal link)
- For events: `https://www.facebook.com/events/{eventId}` (uses universal link)

### Web Fallback URLs
When Facebook is not installed, DeeplinkX automatically falls back to:
- `https://www.facebook.com` - Official Facebook web URL
- For profiles by ID: `https://www.facebook.com/{id}`
- For profiles by username: `https://www.facebook.com/{username}`
- For pages: `https://www.facebook.com/{pageId}`
- For groups: `https://www.facebook.com/groups/{groupId}`
- For events: `https://www.facebook.com/events/{eventId}`