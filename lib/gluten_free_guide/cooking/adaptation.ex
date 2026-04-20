defmodule GlutenFreeGuide.Cooking.Adaptation do
  @moduledoc false

  @type adaptation_input :: %{
          required(:dietary_profile) => map(),
          required(:recipe) => map(),
          optional(:environment) => map()
        }

  @type adaptation_output :: %{
          substitutions: list(map()),
          recommendations: list(map()),
          warnings: list(map())
        }

  @spec adapt(adaptation_input()) :: {:ok, adaptation_output()}
  def adapt(_input) do
    {:ok, %{substitutions: [], recommendations: [], warnings: []}}
  end
end
