FactoryBot.define do
  factory :note do
    sequence(:title) { |i| "Note #{i}"}
    content { "test note content" }
    factory :recipe_note do
      association :note_subject, factory: :recipe
    end

    factory :ingredient_note do
      association :note_subject, factory: :ingredient
    end
  end
end
