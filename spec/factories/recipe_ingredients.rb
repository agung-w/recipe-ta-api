FactoryBot.define do
  factory :recipe_ingredient do
    association :recipe 
    association :ingredient 
    quantity { 1 }
    association :metric 
  end
end
