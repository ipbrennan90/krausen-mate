require 'test_helper'

class Mutations::CreateRecipeTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::CreateRecipe.new(object: nil, context: @context).resolve(args)
  end
  
  def create_user
    User.create!(
      name: 'Recipe User',
      email: 'recipe_user@example.com',
      password: '[omitted]'
    )
  end

  def sign_in
    user = User.first || create_user

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
      Mutations::CreateRecipe.new(object: nil, context: {}).ready?
    end
  end

  test 'success' do
    sign_in

    result = perform(
      name: "Test Recipe",
    )

    assert result.persisted?

    assert_equal result.name, "Test Recipe"
    assert_equal result.user.email, "recipe_user@example.com"
  end
end