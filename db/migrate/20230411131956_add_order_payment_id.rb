class AddOrderPaymentId < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :order_payment_id, :string
  end
end
