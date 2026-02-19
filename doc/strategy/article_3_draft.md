# Draft Article 3

## Title
Production Playbook for Outbound Deep Linking in Flutter

## Intro
Outbound deep links are often scattered across settings pages, contact buttons, social menus, and map actions. Production quality depends on consistency, evidence-backed behavior, and maintainable contributor workflows.

This playbook defines a repeatable approach using DeeplinkX.

## 1) Requirements Checklist
- List all outbound features by product area.
- Define fallback requirement per feature.
- Define telemetry expectations (success/failure).
- Define ownership for docs and review.

## 2) Provider and Action Selection
Use explicit action handlers per feature instead of a monolithic callback.

```dart
Future<void> onSupportTap() async {
  await deeplinkX.launchAction(
    WhatsApp.chat(
      phoneNumber: '989120000000',
      message: 'Hi support team',
      fallbackToStore: true,
    ),
  );
}
```

## 3) Reliability and UX Safety
- Validate with installed and non-installed app states.
- Verify behavior for store fallback and web fallback.
- Keep strict mode (`disableFallback`) for flows that need explicit in-app handling.

## 4) Contributor Workflow
- Use lane ownership for technical docs vs distribution docs.
- Enforce claim-to-proof mapping in reviews.
- Keep docs quality checklist mandatory before merge.

## 5) KPI Loop
Track weekly leading indicators:
- query coverage,
- proof-backed claims,
- external outputs.

Track monthly lagging indicators:
- likes trend,
- downloads trend,
- recommendation hit rate.

## Sources
- Docs quality checklist: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/contributing/docs_quality_checklist.md
- KPI framework: https://github.com/DeepLinkX/DeeplinkX/blob/master/doc/strategy/kpi_framework.md
- Claim-to-proof map: https://github.com/DeepLinkX/DeeplinkX/blob/master/README.md
