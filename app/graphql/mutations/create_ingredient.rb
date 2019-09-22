module Mutations
  class CreateIngredient < AuthenticatedMutation
    argument :name, String, required: true
    argument :amount, Float, required: true
    argument :recipe_id, Integer, required: true
    argument :unit, String, required: true

    type Types::IngredientType

    def resolve(name: nil, recipe_id: nil, amount: nil, unit: nil)
      ingredient = Ingredient.new(
        name: name,
        amount: amount,
        unit: unit,
        recipe: Recipe.find(recipe_id)
      )
      if ingredient.save
        ingredient
      else 
        raise GraphQL::ExecutionError.new(ingredient.errors.full_messages.join(", "))
      end
    end
  end
end