module Mutations
  class CreateNote < AuthenticatedMutation
    argument :title, String, required: true
    argument :content, String, required: false
    argument :recipe_id, ID, required: false, loads: Types::RecipeType, as: :note_subject
    argument :ingredient_id, ID, required: false, loads: Types::IngredientType, as: :note_subject

    field  :note_subject, Types::NoteSubject, null: true

    type Types::NoteType

    def resolve(title: nil, content: nil, note_subject:)
      note = Note.new(
        title: title,
        content: content,
        note_subject: note_subject
      )

      if note.save
        note
      else 
        raise GraphQL::ExecutionError.new(note.errors.full_messages.join(", "))
      end
    end
  end
end
