module Types
  class NoteType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :content, String, null: true
    field :recipe_id, ID, null: true
    field :ingredient_id, ID, null: true
    field :note_subject, Types::NoteSubject, null: true
  end
end
