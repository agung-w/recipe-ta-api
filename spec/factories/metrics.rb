FactoryBot.define do
  factory :metric do
    name { "MyString" }
    abbrev { "ms" }
    volume { 1.5 }
    weight { 1.5 }
  end
end
