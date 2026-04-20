defmodule GlutenFreeGuide.Cooking.RecipeIngredient do
  use Ash.Resource,
    domain: GlutenFreeGuide.Cooking,
    data_layer: AshPostgres.DataLayer

  postgres do
    table("recipe_ingredients")
    repo(GlutenFreeGuide.Repo)
  end

  actions do
    defaults([:read, :destroy])

    create :create do
      accept([:quantity, :unit, :preparation_note, :recipe_id, :ingredient_id])
    end

    update :update do
      accept([:quantity, :unit, :preparation_note])
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :quantity, :decimal do
      allow_nil?(true)
      public?(true)
    end

    attribute :unit, :string do
      allow_nil?(true)
      public?(true)
    end

    attribute :preparation_note, :string do
      allow_nil?(true)
      public?(true)
    end
  end

  relationships do
    belongs_to :recipe, GlutenFreeGuide.Cooking.Recipe do
      allow_nil?(false)
      attribute_public?(true)
    end

    belongs_to :ingredient, GlutenFreeGuide.Cooking.Ingredient do
      allow_nil?(false)
      attribute_public?(true)
    end
  end

  identities do
    identity(:unique_ingredient_per_recipe, [:recipe_id, :ingredient_id, :preparation_note])
  end
end
