FactoryBot.define do
  factory :order do
    id { "order-id" }
    association :user
    shipping_address { "MyString" }
    shipping_fee { 1.5 }
    payment_fee { 1.5 }
    order_total { 1.5 }
    total { 1.5 }
    status { "MyString" }
    order_time { "2023-04-06 15:26:17" }
    paid_time { "2023-04-06 15:26:17" }
    sent_time { "2023-04-06 15:26:17" }
    finished_time { "2023-04-06 15:26:17" }
    cancel_time { "2023-04-06 15:26:17" }
  end
end
