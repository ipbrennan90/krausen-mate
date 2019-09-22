FactoryBot.define do
  factory :recipe do
    sequence(:name) { |i| "Recipe #{i}"}
    user { User.first || create(:user) }
    after :create do |recipe|
      create_list :ingredient, 3, recipe: recipe
    end
  end
end