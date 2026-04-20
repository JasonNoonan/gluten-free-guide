defmodule GlutenFreeGuide.Cooking.DietaryProfile do
  use Ash.Resource,
    domain: GlutenFreeGuide.Cooking,
    data_layer: AshPostgres.DataLayer

  postgres do
    table("dietary_profiles")
    repo(GlutenFreeGuide.Repo)
  end

  actions do
    defaults([:read, :destroy])

    create :create do
      accept([:allergens, :altitude_ft, :experience_level, :user_id])
    end

    update :update do
      accept([:allergens, :altitude_ft, :experience_level])
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :allergens, {:array, :string} do
      allow_nil?(false)
      default([])
      public?(true)
    end

    attribute :altitude_ft, :integer do
      constraints(min: 0)
      allow_nil?(true)
      public?(true)
    end

    attribute :experience_level, :string do
      allow_nil?(false)
      default("beginner")
      constraints(match: ~r/^(beginner|intermediate|advanced)$/)
      public?(true)
    end

    create_timestamp(:inserted_at)
    update_timestamp(:updated_at)
  end

  relationships do
    belongs_to :user, GlutenFreeGuide.Cooking.User do
      allow_nil?(false)
      attribute_public?(true)
    end
  end

  identities do
    identity(:unique_user_profile, [:user_id])
  end
end
