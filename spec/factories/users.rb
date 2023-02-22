FactoryBot.define do
  factory :user do
    name { "Agung" }
    username { "agung" }
    email { "agung@gmail.com" }
    password { "password" }
    profile_pic_url { "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png" }
  end
end
