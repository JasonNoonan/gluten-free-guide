defmodule GlutenFreeGuide.Cooking.Ingredient do
  use Ash.Resource,
    domain: GlutenFreeGuide.Cooking,
    data_layer: AshPostgres.DataLayer

  postgres do
    table("ingredients")
    repo(GlutenFreeGuide.Repo)
  end

  actions do
    defaults([:read, :destroy])

    create :create do
      accept([:name, :gluten_status])
    end

    update :update do
      accept([:name, :gluten_status])
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :name, :string do
      allow_nil?(false)
      public?(true)
    end

    attribute :gluten_status, :string do
      allow_nil?(false)
      default("unknown")
      constraints(match: ~r/^(unknown|gluten_free|contains_gluten|cross_contact_risk)$/)
      public?(true)
    end

    create_timestamp(:inserted_at)
    update_timestamp(:updated_at)
  end

  relationships do
    has_many :recipe_ingredients, GlutenFreeGuide.Cooking.RecipeIngredient
  end

  identities do
    identity(:unique_ingredient_name, [:name])
  end
end
