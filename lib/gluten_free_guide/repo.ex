defmodule GlutenFreeGuide.Repo do
  use Ecto.Repo,
    otp_app: :gluten_free_guide,
    adapter: Ecto.Adapters.Postgres
end
