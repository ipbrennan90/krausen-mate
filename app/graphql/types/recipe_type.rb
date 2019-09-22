module Types
  class RecipeType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :user, Types::UserType, null: false
    field :ingredients, [Types::IngredientType], null: true
  end
end
