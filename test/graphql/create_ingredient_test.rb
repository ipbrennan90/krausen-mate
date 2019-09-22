require 'test_helper'

class Mutations::CreateIngredientTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::CreateIngredient.new(object: nil, context: @context).resolve(args)
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

  test 'success' do 
    sign_in
    recipe = create(:recipe, user: @context[:current_user])

    result = perform(
      name: "Cascade Hops",
      amount: 1.5,
      unit: "g",
      recipe_id: recipe.id
    )

    assert result.persisted?

    assert_equal result.name, "Cascade Hops"
    assert_equal result.amount, 1.5
    assert_equal result.unit, "g"
    assert_equal result.recipe, recipe
  end

  test 'failure w/no credentials' do
    assert_raises(GraphQL::ExecutionError) do
      Mutations::CreateIngredient.new(object: nil, context: {}).ready?
    end
  end

  test 'failure w/no name' do
    sign_in
    recipe = create(:recipe, user: @context[:current_user])

    error = assert_raises GraphQL::ExecutionError do
      perform(
        name: "",
        amount: 1.5,
        unit: "g",
        recipe_id: recipe.id
      )
    end

    assert_equal error.message, "Name can't be blank"
  end

  test 'failure w/no amount' do
    sign_in
    recipe = create(:recipe, user: @context[:current_user])

    error = assert_raises GraphQL::ExecutionError do
      perform(
        name: "Cascade Hops",
        unit: "g",
        recipe_id: recipe.id
      )
    end

    assert_equal error.message, "Amount can't be blank"
  end

  test 'failure w/no unit' do
    sign_in
    recipe = create(:recipe, user: @context[:current_user])

    error = assert_raises GraphQL::ExecutionError do
      perform(
        name: "Cascade Hops",
        amount: 1.5,
        recipe_id: recipe.id
      )
    end

    assert_equal error.message, "Unit can't be blank"
  end
end
