module Mutations
  class CreateStep < AuthenticatedMutation
    argument :title, String, required: true
    argument :content, String, required: false
    argument :step_number, Int, required: true
    argument :recipe_id, ID, required: true, loads: Types::RecipeType

    type Types::StepType

    def resolve(title: nil, content: nil, step_number: nil, recipe:)
      step = Step.new(
        title: title, 
        content: content, 
        recipe: recipe,
        step_number: step_number
      )
      
      if step.save
        step
      else
        raise GraphQL::ExecutionError.new(step.errors.full_messages.join(", "))
      end
    end
  end
end