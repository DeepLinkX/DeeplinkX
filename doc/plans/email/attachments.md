# Proposal: compose with attachments

Checked **2026-10-11**. Shared capability instructions in draft PR #88. Attachments are outside the existing proposed `MailComposeAction`; no attachment parameter, API or permission is added in this phase.

## Platform research

| Platform | Route candidate | Fields / file requirements | Blockers and evidence | Runtime |
| --- | --- | --- | --- | --- |
| Android | Package-targeted SEND / SEND_MULTIPLE | Email recipient arrays/subject/body plus URI stream(s), MIME type and read grants | Content/FileProvider URIs, ClipData, flags and Parcelable bridge; [Android](https://developer.android.com/guide/components/intents-common#Email), [Proton source](https://github.com/ProtonMail/android-mail/blob/1bf2e1058bbe637562cded858d7cd460e064977e/mail-common/data/src/main/kotlin/ch/protonmail/android/mailcommon/data/file/IntentShareExtensions.kt), [Thunderbird source](https://github.com/thunderbird/thunderbird-android/blob/e3fb7f3341827eb756327e26198f97b7c3f1821e/legacy/ui/legacy/src/main/java/com/fsck/k9/ui/compose/IntentDataMapper.kt) | Not tested |
| iOS | OS mail composer or share UI research | Attachments require native data/file handling, not invented scheme query keys | Mail composer extension must verify APIs, entitlement/account availability and named-provider limits; no external route established here | Not tested |
| macOS | Explicit app URL/file/CLI candidate | File access, application targeting and lifetime; handler-specific arguments | [NSWorkspace](https://developer.apple.com/documentation/appkit/nsworkspace/open(_:withapplicationat:configuration:completionhandler:)), [Mailspring source](https://github.com/Foundry376/Mailspring/blob/5e9cf917d072fe3b8e3b2df0ace0bbf2953581b6/app/src/browser/main.js); current text/URI launcher insufficient | Not tested |
| Windows | Provider-specific file/CLI or share adapter research | Verified app identity, file paths, accessibility and argument grammar | No generic external attachment compose contract established | Not tested |
| Linux | xdg-email --attach; Evolution attach; Mailspring file argument | Default handler versus explicit executable; local file access and sandbox translation | [xdg-email](https://portland.freedesktop.org/doc/xdg-email.html), [Evolution](https://gnome.pages.gitlab.gnome.org/evolution/help/te/start-command-line-parameters.html), [Mailspring](https://github.com/Foundry376/Mailspring/blob/5e9cf917d072fe3b8e3b2df0ace0bbf2953581b6/app/src/browser/main.js) | Not tested |
| Web | User file selection/provider upload UI research | A local path in a URL does not upload a file | No portable external attachment URL contract; [RFC 6068](https://www.rfc-editor.org/rfc/rfc6068) | Not tested |

Do not encode `attachment=...` into generic mailto and claim portable support. Provider-specific CLI extensions must have their own tested adapter. AndroidIntentOption supports general arguments/arrays/type/flags, but that is not proof it can construct Parcelable URI streams, ClipData and grants correctly. The bridge and cleanup lifecycle are prerequisites.

If an attachment cannot be preserved, fail or skip the incompatible attachment route. Do not silently open an empty composer or drop files. A labeled store/product fallback can open, but it must not claim the attachment was delivered. No automatic send operation is proposed.

## Future test scenarios

Verify single/multiple files, URI grants, revocation/lifetime, MIME matching, Unicode filenames, large files, missing/locked files, sandboxed destinations, provider rejection, logged-out mail app and all recipient fields together. Compare native output draft contents, not only a successful launch return. Keep cancellation and provider errors distinct from acceptance. API design remains blocked until platform file transport and ownership are settled.
