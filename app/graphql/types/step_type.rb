module Types
  class StepType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :content, String, null: true
    field :step_number, Int, null: false
    field :recipe, Types::RecipeType, null: false
  end
end