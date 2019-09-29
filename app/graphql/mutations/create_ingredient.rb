module Mutations
  class CreateIngredient < AuthenticatedMutation
    argument :name, String, required: true
    argument :amount, Float, required: true
    argument :recipe_id, ID, required: true, loads: Types::RecipeType
    argument :unit, String, required: true

    type Types::IngredientType

    def resolve(name: nil, amount: nil, unit: nil, recipe:)
      ingredient = Ingredient.new(
        name: name,
        amount: amount,
        unit: unit,
        recipe: recipe
      )
      if ingredient.save
        ingredient
      else 
        raise GraphQL::ExecutionError.new(ingredient.errors.full_messages.join(", "))
      end
    end
  end
end