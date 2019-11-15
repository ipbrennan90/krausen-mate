module Mutations
  class DeleteStep < AuthenticatedMutation
    def resolve(id: nil)
      step = Step.find(id)

      if(step.destroy)
        {delete_id: id}
      else
        raise GraphQL::ExecutionError.new(step.errors.full_messages.join(", "))
      end
    end
  end
end