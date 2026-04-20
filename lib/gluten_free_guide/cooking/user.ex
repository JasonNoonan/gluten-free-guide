defmodule GlutenFreeGuide.Cooking.User do
  use Ash.Resource,
    domain: GlutenFreeGuide.Cooking,
    data_layer: AshPostgres.DataLayer

  postgres do
    table("users")
    repo(GlutenFreeGuide.Repo)
  end

  actions do
    defaults([:read, :destroy])

    create :create do
      accept([:email, :display_name])
    end

    update :update do
      accept([:display_name])
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :email, :string do
      allow_nil?(false)
      constraints(match: ~r/^[^\s]+@[^\s]+$/)
      public?(true)
    end

    attribute :display_name, :string do
      allow_nil?(false)
      public?(true)
    end

    create_timestamp(:inserted_at)
    update_timestamp(:updated_at)
  end

  relationships do
    has_one :dietary_profile, GlutenFreeGuide.Cooking.DietaryProfile
    has_many :recipes, GlutenFreeGuide.Cooking.Recipe, destination_attribute: :owner_user_id
    has_many :progress_events, GlutenFreeGuide.Cooking.ProgressEvent
  end

  identities do
    identity(:unique_email, [:email])
  end
end
