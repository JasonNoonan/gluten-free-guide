defmodule GlutenFreeGuide.Repo do
  use AshPostgres.Repo,
    otp_app: :gluten_free_guide,
    adapter: Ecto.Adapters.Postgres

  def installed_extensions do
    ["uuid-ossp", "citext", "ash-functions"]
  end

  def min_pg_version do
    %Version{major: 16, minor: 0, patch: 0}
  end
end
