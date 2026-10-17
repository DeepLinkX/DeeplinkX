# Proposal: desktop launch prerequisites

Checked **2026-10-11**. Shared capability instructions in draft PR #88. Desktop distribution is recorded for every app in the [matrix](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/matrix.md); it does not automatically justify adding a platform to an eventual `supportedPlatforms` list.

## Current adapter boundary

[LauncherUtil](https://github.com/DeepLinkX/DeeplinkX/blob/f8225e35158d4b69c9ddb7e8128418e9b278d33c/lib/src/utils/launcher_util.dart) root opening uses an Android package or a custom scheme. macOS install checks require `macosBundleIdentifier`, but root launch still uses the scheme. A bundle ID alone therefore cannot enable macOS opening. Windows/Linux installation checks use a scheme handler, which may belong to another app. A generic mailto association cannot establish named-provider installation or compose identity.

[launchAction](https://github.com/DeepLinkX/DeeplinkX/blob/f8225e35158d4b69c9ddb7e8128418e9b278d33c/lib/src/core/deeplink_x.dart) gates native actions on installation. An eventual desktop URL/action can be valid in isolation yet never attempted when its identity gate is absent. Design both identity and invocation together; preserve the established fallback behavior.

| Platform | Named-open candidate | Named-compose candidate | Identity / packaging requirements | Runtime |
| --- | --- | --- | --- | --- |
| macOS | NSWorkspace application lookup/open, or verified provider scheme | Explicit application URL opening or verified CLI | Bundle ID from installed/vendor metadata, application URL, sandbox/security-scoped file access where relevant | Not tested |
| Windows | Explicit verified app identity or executable adapter | Documented provider URI/CLI; default mailto is separate | Classic/new/MSIX/portable app differences, product/AppUserModelID/path, handler ownership | Not tested |
| Linux | Explicit desktop entry/executable adapter | Documented CLI/URI sent to that app | Desktop-file ID, executable, distribution package, Flatpak/Snap and desktop session | Not tested |

OS references: [NSWorkspace](https://developer.apple.com/documentation/appkit/nsworkspace/open(_:withapplicationat:configuration:completionhandler:)), [Windows default URI launch](https://learn.microsoft.com/en-us/windows/apps/develop/launch/launch-default-app), [xdg-email](https://portland.freedesktop.org/doc/xdg-email.html). These do not establish every named-provider route. Mobile routes are covered in provider briefs; web opens a browser URL and is not desktop-native support.

Proton's desktop `ch.protonmail.desktop` is source-observed; Apple's local `com.apple.mail` and message registration are metadata-only. Other desktop identities generally remain unresolved. Do not copy iOS bundle IDs to macOS. Store listing IDs are distribution IDs, not necessarily bundle/product/executable launch IDs.

Thunderbird's source command handler, Mailspring's CLI, Evolution's command documentation, and historical Geary/KMail entries provide research paths. Betterbird's ancestry does not independently prove Thunderbird options. No CLI adapter or new platform interface is implemented in this phase.

Future adapters must pass argument arrays directly, preserve URI encoding, reject unverified/unsupported fields before launch, and verify selected app identity. Do not build shell commands from recipients, body text, message IDs or filenames. Normal website/store fallback remains a labeled non-compose route.

## Acceptance tests before enabling a platform

Verify installed identity, handler ownership, cold/warm start, missing executable/handler, packaging variants, account selection, all compose fields and message lookup failures. Verify explicit selection with another app configured as default. Test desktop file transport separately from text compose. Record OS/app/build/source pin and expected versus observed draft contents; current runtime status is not tested.
