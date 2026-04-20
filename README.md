# Gluten-Free Guide

Phoenix LiveView app for the Gluten-Free Guide project, bootstrapped with an Ash baseline domain and managed with Mise.

## Prerequisites

- Install Mise: https://mise.jdx.dev/
- Install Docker (required for the Sprint 1 Postgres container work)

## Local setup

1. Install runtime/toolchain versions from `.mise.toml`:

   ```bash
   mise install
   ```

2. Start Postgres in Docker:

   ```bash
   make db-up
   ```

3. Install Elixir dependencies and build frontend tooling:

   ```bash
   mix setup
   ```

4. Configure and create the local database:

   ```bash
   mix ecto.create
   ```

5. Start the app:

   ```bash
   mix phx.server
   ```

Then visit `http://localhost:4000`.

## Current foundations (Sprint 1)

- Phoenix 1.8 + LiveView 1.1 scaffold
- Ash dependencies (`ash`, `ash_postgres`, `ash_phoenix`) configured
- Initial Ash domain module at `lib/gluten_free_guide/cooking.ex`
- Toolchain pinned via `.mise.toml`
- Dockerized Postgres with persistent volume via `docker-compose.yml`

## Local database commands

- Start Postgres: `make db-up`
- Stop services: `make db-down`
- Reset DB volume and restart Postgres: `make db-reset`
- Seed DB data: `make db-seed`

## Troubleshooting

- `connection refused`: run `make db-up` and wait for healthcheck to pass.
- Port conflict on `5432`: stop local Postgres or change the port mapping in `docker-compose.yml` and update `config/dev.exs`.
- Dirty local database state: run `make db-reset` and then `mix ecto.setup`.
# gluten-free-guide
