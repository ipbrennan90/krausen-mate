
module Mutations
  class CreateUser < BaseMutation 
    class AuthProviderSignUpData < Types::BaseInputObject
      argument :email, Types::AuthProviderEmailInput, required: false
    end

    argument :name, String, required: false
    argument :auth_provider, AuthProviderSignUpData, required: false

    type Types::UserType

    def resolve(name: nil, auth_provider: nil)
      # &.[](:email) == [:email]
      User.create!(
        name: name,
        email: auth_provider&.[](:email)&.[](:email),
        password: auth_provider&.[](:email)&.[](:password)
      )
    end
  end
end