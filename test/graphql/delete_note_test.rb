require 'test_helper'

class Mutations::DeleteNoteTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::DeleteNote.new(object: nil, context: @context).resolve(args)
  end

  #TODO: Move this to a helper
  def sign_in
    user = create(:user)
    
    authenticated = Mutations::SignInUser.new(object: nil, context: {session: {}}).resolve(
      email: {
        email: user.email,
        password: user.password
      }
    )

    @context[:current_user] = authenticated[:user]
  end

  test 'failure w/no credentials' do
    assert_raises(GraphQL::ExecutionError) do
      Mutations::DeleteNote.new(object: nil, context: {}).ready?
    end
  end

  test 'successfully removes recipe note' do
    sign_in

    note = create(:recipe_note)
    recipe = note.note_subject

    assert_difference('Note.count', -1) do
      result = perform(
        id: note.id
      )
    end

    recipe.reload

    assert_equal recipe.notes.count, 0
  end

  test 'successfully removes ingredient note' do
    sign_in

    note = create(:ingredient_note)
    ingredient = note.note_subject

    assert_difference('Note.count', -1) do
      result = perform(
        id: note.id
      )
    end

    ingredient.reload
    
    assert_equal ingredient.notes.count, 0
  end
end