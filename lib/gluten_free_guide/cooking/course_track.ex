defmodule GlutenFreeGuide.Cooking.CourseTrack do
  use Ash.Resource,
    domain: GlutenFreeGuide.Cooking,
    data_layer: AshPostgres.DataLayer

  postgres do
    table("course_tracks")
    repo(GlutenFreeGuide.Repo)
  end

  actions do
    defaults([:read, :destroy])

    create :create do
      accept([:slug, :title, :description, :status])
    end

    update :update do
      accept([:slug, :title, :description, :status])
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :slug, :string do
      allow_nil?(false)
      public?(true)
    end

    attribute :title, :string do
      allow_nil?(false)
      public?(true)
    end

    attribute :description, :string do
      allow_nil?(true)
      public?(true)
    end

    attribute :status, :string do
      allow_nil?(false)
      default("draft")
      constraints(match: ~r/^(draft|published|archived)$/)
      public?(true)
    end
  end

  relationships do
    has_many :lessons, GlutenFreeGuide.Cooking.Lesson
    has_many :progress_events, GlutenFreeGuide.Cooking.ProgressEvent
  end

  identities do
    identity(:unique_course_slug, [:slug])
  end
end
