require 'test_helper'

class Mutations::DeleteStepTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::DeleteStep.new(object: nil, context: @context).resolve(args)
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
      Mutations::DeleteStep.new(object: nil, context: {}).ready?
    end
  end
end