require 'rails_helper'

RSpec.describe Order, type: :model do
  it "is expected to be valid when given valid values" do
    order=build(:order)
    expect(order).to be_valid
  end

  it "shipping address cant be null nor empty" do
    order=build(:order,shipping_address:nil)
    expect(order).to_not be_valid
    order=build(:order,shipping_address:"")
    expect(order).to_not be_valid
  end

  it "status cant be null nor empty" do
    order=build(:order,status:nil)
    expect(order).to_not be_valid
    order=build(:order,status:"")
    expect(order).to_not be_valid
  end

  it "shipping fee cant be null nor negative" do
    order=build(:order,shipping_fee:nil)
    expect(order).to_not be_valid
    order=build(:order,shipping_fee:-1)
    expect(order).to_not be_valid
  end

  it "payment fee cant be null nor negative" do
    order=build(:order,payment_fee:nil)
    expect(order).to_not be_valid
    order=build(:order,payment_fee:-1)
    expect(order).to_not be_valid
  end

  it "order total cant be null nor negative" do
    order=build(:order,order_total:nil)
    expect(order).to_not be_valid
    order=build(:order,order_total:-1)
    expect(order).to_not be_valid
  end

  it "total cant be null nor negative" do
    order=build(:order,total:nil)
    expect(order).to_not be_valid
    order=build(:order,total:-1)
    expect(order).to_not be_valid
  end

  it "order time cant be null nor empty" do
    order=build(:order,order_time:nil)
    expect(order).to_not be_valid
    order=build(:order,order_time:"")
    expect(order).to_not be_valid
  end
end
