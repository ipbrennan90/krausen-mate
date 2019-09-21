module Mutations
  class AuthenticatedMutation < BaseMutation
    def ready?(**args)
      if !context[:current_user]
        raise GraphQL::ExecutionError, "You don't have permission to do this."
      else
        return true
      end
    end
  end
end
