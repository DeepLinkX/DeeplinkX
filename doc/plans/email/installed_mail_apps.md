# Proposal: installed mail app discovery and open selection

Checked **2026-10-11**. Shared capability instructions in draft PR #88. Discovery, opening a selected app, default-handler lookup and composing are separate operations. A scheme handler does not necessarily identify the named app, and enumerating every installed app is not required to offer a bounded mail picker.

## Platform feasibility

| Platform | Proposed discovery / selection | Identifiers and prerequisites | Evidence boundary | Runtime |
| --- | --- | --- | --- | --- |
| Android | Query bounded known packages; separately resolve email intents | Verified package IDs, visibility queries and activity resolution | [Android intents](https://developer.android.com/guide/components/intents-common#Email), [package visibility](https://developer.android.com/training/package-visibility/declaring); release policy must be checked before implementation | Not tested |
| iOS | Probe only evidenced schemes from a bounded catalog | LSApplicationQueriesSchemes, query limits, provider scheme registration | [Apple canOpenURL](https://developer.apple.com/documentation/uikit/uiapplication/canopenurl(_:)), existing LauncherUtil; app availability is not enumeration permission | Not tested |
| macOS | Known-bundle lookup; selected app opening needs native targeting | Verified bundle IDs, NSWorkspace application URL, sandbox policy | [NSWorkspace](https://developer.apple.com/documentation/appkit/nsworkspace/open(_:withapplicationat:configuration:completionhandler:)); current installation lookup does not provide bundle launch | Not tested |
| Windows | Known provider identity/association research | Product/AppUserModelID or verified executable; URI association can be another app | [Windows default URI launch](https://learn.microsoft.com/en-us/windows/apps/develop/launch/launch-default-app) does not prove enumeration/identity | Not tested |
| Linux | Known desktop entry / executable research | Desktop-file IDs, packaging, Flatpak/Snap/session constraints | [Desktop entries](https://specifications.freedesktop.org/desktop-entry-spec/latest/); [xdg-email](https://portland.freedesktop.org/doc/xdg-email.html) chooses default, not arbitrary app list | Not tested |
| Web | No general installed native mail-app enumeration established | Browser scheme handoff may need user action | Keep app detection unknown rather than fingerprinting or claiming a native picker | Not tested |

OS permission/policy and current-release enumeration APIs are blockers; this brief proposes no unrestricted inventory scan. Return only verified catalog matches, distinguish unavailable query from absent app, and avoid exposing installation details beyond the caller's explicit request. Do not mistake the OS chooser for a DeeplinkX-installed-app list.

An explicit selection should open the chosen app, not the default handler. If selected provider has no evidenced native open route, mark it unavailable/blocked instead of redirecting to a different provider. Store/product fallback may be a separate labeled choice; it does not mean the chosen app is installed.

No to/cc/bcc/subject/body fields belong to root-open selection; compose uses its separate action. No provider-independent inbox guarantee exists. See [matrix](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/matrix.md) and [desktop prerequisites](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/desktop_launch_prerequisites.md).

## Future tests

Distinguish installed versus resolvable, invisible versus absent packages, handler collisions, stale IDs, unavailable selection, changed defaults, canceled picker and zero candidates. Verify the chosen provider opens on cold/warm launch. Do not query credentials or mailbox contents to detect installation.
