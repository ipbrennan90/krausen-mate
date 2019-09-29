module Mutations
  class DeleteNote < AuthenticatedMutation
    def resolve(id: nil)
      note = Note.find(id)

      if(note.destroy)
        {delete_id: id}
      else
        raise GraphQL::ExecutionError.new(note.errors.full_messages.join(", "))
      end
    end
  end
end