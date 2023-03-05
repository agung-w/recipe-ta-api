FactoryBot.define do
  factory :cooking_step do
    association :recipe
    description { "MyString" }
    pic_url { "MyString" }
  end
end
