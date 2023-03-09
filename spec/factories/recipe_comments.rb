FactoryBot.define do
  factory :recipe_comment do
    association :user
    association :recipe
    content { "MyString" }
  end
end
