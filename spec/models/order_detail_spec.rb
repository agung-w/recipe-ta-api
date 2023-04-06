require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  it "is expected to be valid when given valid values" do
    order=build(:order_detail)
    expect(order).to be_valid
  end

  it "quantity cant be null nor negative" do
    order=build(:order_detail,quantity:nil)
    expect(order).to_not be_valid
    order=build(:order_detail,quantity:-1)
    expect(order).to_not be_valid
  end
  it "price cant be null nor negative" do
    order=build(:order_detail,price:nil)
    expect(order).to_not be_valid
    order=build(:order_detail,price:-1)
    expect(order).to_not be_valid
  end
  it "total price cant be null nor negative" do
    order=build(:order_detail,total_price:nil)
    expect(order).to_not be_valid
    order=build(:order_detail,total_price:-1)
    expect(order).to_not be_valid
  end
end
