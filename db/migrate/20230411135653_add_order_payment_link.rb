class AddOrderPaymentLink < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :order_payment_link, :string
  end
end
