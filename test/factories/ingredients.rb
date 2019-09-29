FactoryBot.define do
  factory :ingredient do
    sequence(:name) { |i| "Ingredient #{i}"}
    amount { 1.0 }
    unit { Measured::Weight.unit_names.sample }
    recipe
  end
end
