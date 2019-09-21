module Mutations
  class CreateRecipe < AuthenticatedMutation
    argument :name, String, required: true

    type Types::RecipeType

    def resolve(name: nil)
      Recipe.create!(
        name: name,
        user: context[:current_user]
      )
    end
  end
end