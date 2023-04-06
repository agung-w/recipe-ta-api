FactoryBot.define do
  factory :order_detail do
    association :order
    association :recipe_bundle
    quantity { 1 }
    price { 1.5 }
    total_price { 1.5 }
  end
end
