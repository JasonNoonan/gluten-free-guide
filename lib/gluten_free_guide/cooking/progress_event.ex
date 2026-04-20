defmodule GlutenFreeGuide.Cooking.ProgressEvent do
  use Ash.Resource,
    domain: GlutenFreeGuide.Cooking,
    data_layer: AshPostgres.DataLayer

  postgres do
    table("progress_events")
    repo(GlutenFreeGuide.Repo)
  end

  actions do
    defaults([:read])

    create :create do
      accept([:event_type, :metadata, :user_id, :course_track_id, :lesson_id])
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :event_type, :string do
      allow_nil?(false)
      public?(true)
    end

    attribute :metadata, :map do
      allow_nil?(false)
      default(%{})
      public?(true)
    end

    attribute :occurred_at, :utc_datetime_usec do
      allow_nil?(false)
      default(&DateTime.utc_now/0)
      public?(true)
    end
  end

  relationships do
    belongs_to :user, GlutenFreeGuide.Cooking.User do
      allow_nil?(false)
      attribute_public?(true)
    end

    belongs_to :course_track, GlutenFreeGuide.Cooking.CourseTrack do
      allow_nil?(false)
      attribute_public?(true)
    end

    belongs_to :lesson, GlutenFreeGuide.Cooking.Lesson do
      allow_nil?(true)
      attribute_public?(true)
    end
  end
end
