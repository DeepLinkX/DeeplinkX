# DeeplinkX Example

This example project demonstrates how to use **DeeplinkX** in a Flutter application.

The UI exposes individual app and store actions plus a dedicated **Use Cases** section showing how those actions fit into real Flutter screens.

## Use Cases

- **Update App** — automatic or manual selection from Telegram's verified store listings.
- **About & Support** — social profile links with native and web behavior.
- **Map Selector** — automatic or manual directions through all supported coordinate-navigation providers.
- **Rate & Review** — direct rating links where supported and store-listing alternatives elsewhere.
- **Share & Message** — WhatsApp sharing and Telegram messages.
- **Installed Apps** — installation checks for every supported app and store.
- **Meeting & Community** — Zoom meeting and Slack channel links.
- **Promoted App CTA** — tracked store redirects for a promoted app.
- **Fallback Playground** — native-only, web, and store-then-web policies.

Automatic selectors try native apps in priority order and retain provider web or store fallbacks when an app is unavailable. Installation checks require the schemes and package queries included in the example platform projects.

## Running the Example

1. Fetch dependencies:
   ```bash
   flutter pub get
   ```
2. Run the example app on a connected device or simulator:
   ```bash
   flutter run
   ```

The example shows how to configure, launch, validate, and test practical deeplink workflows.
