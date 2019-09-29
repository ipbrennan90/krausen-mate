require 'test_helper'

class Mutations::CreateNoteTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::CreateNote.new(object: nil, context: @context).resolve(args)
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
      Mutations::CreateNote.new(object: nil, context: {}).ready?
    end
  end

  test 'successfully add note to recipe' do
    sign_in

    recipe = create(:recipe, user: @context[:current_user])

    result = perform(
      title: "Note 1",
      content: "this is a test",
      note_subject: recipe
    )

    assert result.persisted?
    
    assert_equal result.title, "Note 1"
    assert_equal result.content, "this is a test"
    assert_equal result.note_subject, recipe
  end

  test 'successfully add note to ingredient' do
    sign_in

    ingredient = create(:ingredient)

    result = perform(
      title: "Ingredient Note",
      content: "This is an ingredient note.",
      note_subject: ingredient
    )

    assert result.persisted?
    
    assert_equal result.title, "Ingredient Note"
    assert_equal result.content, "This is an ingredient note."
    assert_equal result.note_subject, ingredient
  end
end