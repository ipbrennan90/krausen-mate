module Types
  class AuthProviderEmailInput < BaseInputObject
    graphql_name 'AUTH_PROVIDER_EMAIL'

    argument 'email', String, required: false
    argument 'password', String, required: true
  end
end