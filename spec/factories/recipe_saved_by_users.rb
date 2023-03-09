FactoryBot.define do
  factory :recipe_saved_by_user do
    association :user
    association :recipe
  end
end
