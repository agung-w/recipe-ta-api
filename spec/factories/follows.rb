FactoryBot.define do
  factory :follow do
    association :user
    association :followed
  end
end
