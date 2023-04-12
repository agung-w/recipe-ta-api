FactoryBot.define do
  factory :recipe_comment do
    association :user
    association :recipe
    timestamp {Time.now}
    content { "MyString" }
  end
end
