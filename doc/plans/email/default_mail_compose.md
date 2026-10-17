# Proposal: default-mail compose

Checked **2026-10-11**. Shared capability instructions in draft PR #88. This invokes the configured handler or OS chooser, independently of selecting a named provider.

## Contract and platform routes

Keep the same text fields (to/cc/bcc/subject/body) conceptually, but do not force this capability into `MailAppAction extends DownloadableApp`: a default handler need not be a catalog app or have a provider store. Public API/class names remain undecided until the adapter boundary is designed. It must never be silently inserted into `launchMailComposeAction`.

| Platform | Route / identity | Fields / limitations | Prerequisites / evidence | Runtime |
| --- | --- | --- | --- | --- |
| Android | Untargeted SENDTO with mailto; OS handler/chooser | Recipient arrays and URI fields need precedence testing | Resolve handler, intent visibility, handle none; [Android](https://developer.android.com/guide/components/intents-common#Email) | Not tested |
| iOS | mailto via OS; identity is the configured handler | RFC text fields; cannot assume Apple Mail or all header handling | Query/launch behavior and changed default; [Apple](https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MailLinks/MailLinks.html), [RFC](https://www.rfc-editor.org/rfc/rfc6068) | Not tested |
| macOS | mailto via default application | Named bundle selection is a separate adapter, not default behavior | Verify configured handler; [NSWorkspace](https://developer.apple.com/documentation/appkit/nsworkspace/open(_:withapplicationat:configuration:completionhandler:)), [RFC](https://www.rfc-editor.org/rfc/rfc6068) | Not tested |
| Windows | mailto URI launcher | May select native or browser handler; no Outlook guarantee | Handler association and launch failure; [Windows](https://learn.microsoft.com/en-us/windows/apps/develop/launch/launch-default-app) | Not tested |
| Linux | xdg-email or desktop mailto handler | xdg-email options differ from URI; attachments separate | Desktop/session/sandbox executable availability; [xdg-email](https://portland.freedesktop.org/doc/xdg-email.html), [RFC](https://www.rfc-editor.org/rfc/rfc6068) | Not tested |
| Web | Browser mailto handoff, potentially a prompt/configured web handler | No guarantee of a handler or draft field acceptance | Browser/user configuration; [RFC](https://www.rfc-editor.org/rfc/rfc6068) is URI syntax, not browser installation evidence | Not tested |

Generic mailto does not have a store listing or provider-specific web fallback. An unavailable default handler returns failure unless a caller explicitly opts into a separately designed fallback; no arbitrary named provider or store should be chosen automatically.

Encode UTF-8/Unicode, reserved characters, addresses and newlines according to RFC 6068. Route compatibility must cover every supplied nonempty field; do not discard recipients or reinterpret an unverified header. Subject/body are plain text. No portable attachment parameter exists in this contract. Success means handoff accepted, not draft validation or sending.

## Future tests and blockers

Test no handler, multiple handlers, changed default, browser handler, logged-out account, all recipient fields together, Unicode/encoding and cancellation. Validate each platform's adapter and installation gate independently: current named-app `isAppInstalled` cannot reliably discover a generic default handler. See [desktop prerequisites](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/desktop_launch_prerequisites.md) and [test scenarios](https://github.com/DeepLinkX/DeeplinkX/blob/plan%2Fmail-compose-launcher/doc/plans/email/test_scenarios.md).
