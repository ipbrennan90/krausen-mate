module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :recipes, [Types::RecipeType], null: false do
      description "get all recipes"
    end

    field :users, [Types::UserType], null: false

    def recipes
      Recipe.all
    end
    
    def users
      User.all
    end
  end
end
