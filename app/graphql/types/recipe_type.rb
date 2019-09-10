module Types
  class RecipeType < Types::BaseObject
    field :name, String, null: true
    field :user, Types::UserType, null: true
  end
end
