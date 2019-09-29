module Types
  class RecipeType < Types::BaseObject
    implements GraphQL::Relay::Node.interface
    global_id_field :id
    field :id, ID, null: false
    field :name, String, null: true
    field :user, Types::UserType, null: false
    field :ingredients, [Types::IngredientType], null: true
  end
end
