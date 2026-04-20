# ADR 0001: Initial domain model and architecture boundaries

- Status: Accepted
- Date: 2026-04-19
- Issue: NOO-14

## Context

Sprint 1 requires a shared foundation for recipes, guided lessons, user dietary personalization, and progress tracking. The project uses Phoenix LiveView and Ash, but resource boundaries and ownership rules were not explicitly documented.

Without clear boundaries, personalization logic and authorization checks risk being duplicated across LiveViews and future APIs.

## Decision

We adopt an Ash-centric domain model with these core entities:

- `User`
- `DietaryProfile`
- `Recipe`
- `Ingredient`
- `RecipeIngredient`
- `RecipeStep`
- `CourseTrack`
- `Lesson`
- `ProgressEvent`

We define these system boundaries:

- LiveView is presentation and interaction only.
- Ash domain owns data invariants, policies, and business actions.
- Adaptation logic (allergy and altitude) is a dedicated service boundary that receives domain inputs and returns recommendations.
- An application API layer wraps Ash actions to provide a stable seam for future external clients.

We define the initial privacy model:

- Recipes use `private`, `unlisted`, and `public` visibility states.
- User profile and dietary data are owner-private.
- Course and lesson authoring is restricted to admin/editor roles.
- Progress events are append-only and only user-self writable.

## Consequences

Positive:

- Authorization and invariants become centralized in Ash policies and actions.
- Adaptation logic can evolve independently from UI implementation.
- A clear API seam reduces migration effort for future mobile or partner access.
- Event-style progress history supports analytics and replayable projections.

Trade-offs:

- Slightly more upfront structure than directly querying from LiveViews.
- Progress dashboards require projection logic over event streams.
- Adaptation service introduces an extra internal call boundary.

## Alternatives considered

1. Put adaptation logic directly in LiveView handlers.
   - Rejected: creates duplication and weak testability.

2. Model progress as mutable per-lesson fields only.
   - Rejected: loses event history and analytics flexibility.

3. Skip `unlisted` visibility and keep only `public/private`.
   - Rejected: reduces sharing flexibility for draft-like content.

## Related documents

- `docs/architecture/noo-14-domain-model.md`
