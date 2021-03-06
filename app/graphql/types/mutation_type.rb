module Types
  class MutationType < Types::BaseObject
    field :create_note, mutation: Mutations::CreateNote
    field :create_ingredient, mutation: Mutations::CreateIngredient
    field :create_recipe, mutation: Mutations::CreateRecipe
    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SignInUser
  end
end
