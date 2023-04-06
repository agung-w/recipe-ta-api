FactoryBot.define do
  factory :recipe do
    title { "MyString" }
    poster_pic_url { "MyString" }
    description { "MyString" }
    favorite_count { 1 }
    prep_time { 1 }
    serving { 1 }
    association :user
    is_published {true}
  end
end
