# GitHub Discussion Draft

## Title
How do you structure multiple outbound deep-link features in one Flutter app?

## Body
I am looking for practical patterns to manage several outbound deeplink features in one Flutter app, such as:
- app update actions,
- contact support actions,
- social/community actions,
- navigation/map actions.

Current approach uses separate feature handlers and consistent fallback behavior per feature. I want feedback on:
1. service-layer structure,
2. fallback policy consistency,
3. testing strategy for installed vs non-installed states.

Reference implementation and docs:
- Multi-feature recipe: `doc/recipes/multi_feature_app_menu.md`
- Fallback patterns: `doc/recipes/fallback_strategy_examples.md`
- Core launch behavior: `lib/src/core/deeplink_x.dart`

If you have production patterns, please share what worked and what failed.
