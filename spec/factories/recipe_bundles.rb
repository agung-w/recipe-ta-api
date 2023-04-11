FactoryBot.define do
  factory :recipe_bundle do
    recipe { nil }
    description { "MyString" }
    title { "MyString" }
    price { 1.5 }
    stock { 1 }
    pic_url { 1 }
  end
end
