defmodule GlutenFreeGuide.Cooking.Lesson do
  use Ash.Resource,
    domain: GlutenFreeGuide.Cooking,
    data_layer: AshPostgres.DataLayer

  postgres do
    table("lessons")
    repo(GlutenFreeGuide.Repo)
  end

  actions do
    defaults([:read, :destroy])

    create :create do
      accept([:slug, :title, :body, :position, :course_track_id])
    end

    update :update do
      accept([:slug, :title, :body, :position])
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

    attribute :body, :string do
      allow_nil?(false)
      public?(true)
    end

    attribute :position, :integer do
      constraints(min: 1)
      allow_nil?(false)
      public?(true)
    end
  end

  relationships do
    belongs_to :course_track, GlutenFreeGuide.Cooking.CourseTrack do
      allow_nil?(false)
      attribute_public?(true)
    end

    has_many :progress_events, GlutenFreeGuide.Cooking.ProgressEvent
  end

  identities do
    identity(:unique_lesson_slug_per_course, [:course_track_id, :slug])
    identity(:unique_lesson_position_per_course, [:course_track_id, :position])
  end
end
