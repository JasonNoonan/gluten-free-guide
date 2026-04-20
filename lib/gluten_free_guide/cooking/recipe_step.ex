defmodule GlutenFreeGuide.Cooking.RecipeStep do
  use Ash.Resource,
    domain: GlutenFreeGuide.Cooking,
    data_layer: AshPostgres.DataLayer

  postgres do
    table("recipe_steps")
    repo(GlutenFreeGuide.Repo)
  end

  actions do
    defaults([:read, :destroy])

    create :create do
      accept([:position, :instruction, :timer_seconds, :recipe_id])
    end

    update :update do
      accept([:position, :instruction, :timer_seconds])
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :position, :integer do
      constraints(min: 1)
      allow_nil?(false)
      public?(true)
    end

    attribute :instruction, :string do
      allow_nil?(false)
      public?(true)
    end

    attribute :timer_seconds, :integer do
      constraints(min: 0)
      allow_nil?(true)
      public?(true)
    end
  end

  relationships do
    belongs_to :recipe, GlutenFreeGuide.Cooking.Recipe do
      allow_nil?(false)
      attribute_public?(true)
    end
  end

  identities do
    identity(:unique_step_position_per_recipe, [:recipe_id, :position])
  end
end
