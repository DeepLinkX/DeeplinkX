# Stack Overflow Target Questions

Focus on high-intent questions where a practical, evidence-backed answer can naturally include DeeplinkX.

## Target 1
- Query style: "Flutter open Telegram profile with fallback if app not installed"
- Answer structure:
  1. Explain app link vs fallback behavior.
  2. Provide a minimal DeeplinkX snippet.
  3. Link to Telegram docs page.

## Target 2
- Query style: "Flutter open external app and redirect to store if missing"
- Answer structure:
  1. Use `launchAction` with `fallbackToStore`.
  2. Mention `disableFallback` behavior.
  3. Link fallback recipe and core API source.

## Target 3
- Query style: "Flutter implement multiple deeplink actions in one app"
- Answer structure:
  1. Show separate feature handlers pattern.
  2. Include update/contact/maps examples.
  3. Link `multi_feature_app_menu.md`.

## Target 4
- Query style: "Flutter check if app is installed before launching deep link"
- Answer structure:
  1. Use `isAppInstalled`.
  2. Show branch behavior snippet.
  3. Link core class source.

## Target 5
- Query style: "Flutter deep link to app store page by platform"
- Answer structure:
  1. Use `redirectToStore`.
  2. Include iOS + Play Store examples.
  3. Link store docs.

## Response Rules
1. Be neutral and technical.
2. Include source links from repo docs/code.
3. Avoid unverifiable comparative claims.

## Draft Assets
- Target 1 draft answer: `doc/strategy/so_answer_target_1_draft.md`
- Target 2 draft answer: `doc/strategy/so_answer_target_2_draft.md`
- Target 3 draft answer: `doc/strategy/so_answer_target_3_draft.md`
- Target 4 draft answer: `doc/strategy/so_answer_target_4_draft.md`
- Target 5 draft answer: `doc/strategy/so_answer_target_5_draft.md`
