FactoryBot.define do
  factory :cooking_step do
    association :recipe
    step { 1 }
    description { "MyString" }
    pic_url { "MyString" }
  end
end
