# Week 1 Publishing Runbook

This runbook converts prepared drafts into published external assets.

## Inputs
- SO draft: `doc/strategy/so_answer_target_1_draft.md`
- Article draft: `doc/strategy/article_1_draft.md`
- Evidence links: `README.md`, `doc/apps/`, `doc/recipes/`, `lib/src/core/deeplink_x.dart`

## A) Stack Overflow Publish Steps
1. Find a matching live question for target #1 from `doc/strategy/so_targets.md`.
2. Paste answer from `doc/strategy/so_answer_target_1_draft.md`.
3. Keep only relevant links (max 2-3) to avoid noise.
4. Verify snippet formatting and markdown rendering.
5. Publish and save the answer URL in `doc/strategy/external_publication_log.md`.

## B) Article Publish Steps
1. Copy draft from `doc/strategy/article_1_draft.md` into Medium/editor.
2. Keep all claims evidence-backed; remove any unverifiable language.
3. Add links to docs and core source paths.
4. Add 3-5 tags focused on Flutter deep linking and external app routing.
5. Publish and record URL in `doc/strategy/external_publication_log.md`.

## C) Post-Publish Tracking
1. Update `doc/strategy/promotion_review_week6.md` with:
   - external surface outputs count,
   - publication URLs,
   - initial qualitative notes.
2. Update `doc/strategy/execution_status.md` External publishing status.

## Guardrails
1. Keep language technical and non-promotional.
2. Do not introduce unsupported runtime/API claims.
3. Do not add “other plugin is enough” comparison framework in this cycle.
