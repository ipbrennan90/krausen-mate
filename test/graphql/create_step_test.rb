require 'test_helper'

class Mutations::CreateStepTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::CreateStep.new(object: nil, context: @context).resolve(args)
  end

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
      Mutations::CreateStep.new(object: nil, context: {}).ready?
    end
  end

  test 'successfully add step to recipe' do
    sign_in

    recipe = create(:recipe, user: @context[:current_user])

    result = perform(
      title: "Step 1",
      content: "This is the first step",
      recipe: recipe,
      step_number: 1
    )

    assert result.persisted?
    
    assert_equal result.title, "Step 1"
    assert_equal result.content, "This is the first step"
    assert_equal result.recipe, recipe
    assert_equal result.step_number, 1
  end
end