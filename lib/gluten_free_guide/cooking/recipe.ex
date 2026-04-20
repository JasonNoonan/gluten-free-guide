defmodule GlutenFreeGuide.Cooking.Recipe do
  use Ash.Resource,
    domain: GlutenFreeGuide.Cooking,
    data_layer: AshPostgres.DataLayer

  postgres do
    table("recipes")
    repo(GlutenFreeGuide.Repo)
  end

  actions do
    defaults([:read, :destroy])

    create :create do
      accept([:title, :summary, :privacy, :servings, :duration_minutes, :owner_user_id])
    end

    update :update do
      accept([:title, :summary, :privacy, :servings, :duration_minutes])
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :title, :string do
      allow_nil?(false)
      public?(true)
    end

    attribute :summary, :string do
      allow_nil?(true)
      public?(true)
    end

    attribute :privacy, :string do
      allow_nil?(false)
      default("private")
      constraints(match: ~r/^(private|unlisted|public)$/)
      public?(true)
    end

    attribute :servings, :integer do
      constraints(min: 1)
      allow_nil?(true)
      public?(true)
    end

    attribute :duration_minutes, :integer do
      constraints(min: 1)
      allow_nil?(true)
      public?(true)
    end

    create_timestamp(:inserted_at)
    update_timestamp(:updated_at)
  end

  relationships do
    belongs_to :owner, GlutenFreeGuide.Cooking.User do
      source_attribute(:owner_user_id)
      allow_nil?(false)
      attribute_public?(true)
    end

    has_many :steps, GlutenFreeGuide.Cooking.RecipeStep
    has_many :recipe_ingredients, GlutenFreeGuide.Cooking.RecipeIngredient
  end
end
