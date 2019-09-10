# run with `bundle exec rails db:seed`

# clear out existing data
[User, Recipe].each do |model|
  model.delete_all
end

# create some owners
owners = Array(1..15).map do |n|
  User.create!(
    name: Faker::Name.name,
    email: "brewer-#{n}@email.com",
    password: 'secret'
  )
end

# create some recipes 
Array(1..15).map do |n|
  Recipe.create!(
    name: Faker::Name.name,
    user: owners.sample
  )
end