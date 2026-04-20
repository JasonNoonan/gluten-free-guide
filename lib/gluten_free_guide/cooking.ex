defmodule GlutenFreeGuide.Cooking do
  use Ash.Domain

  resources do
    resource(GlutenFreeGuide.Cooking.User)
    resource(GlutenFreeGuide.Cooking.DietaryProfile)
    resource(GlutenFreeGuide.Cooking.Recipe)
    resource(GlutenFreeGuide.Cooking.Ingredient)
    resource(GlutenFreeGuide.Cooking.RecipeIngredient)
    resource(GlutenFreeGuide.Cooking.RecipeStep)
    resource(GlutenFreeGuide.Cooking.CourseTrack)
    resource(GlutenFreeGuide.Cooking.Lesson)
    resource(GlutenFreeGuide.Cooking.ProgressEvent)
  end
end
