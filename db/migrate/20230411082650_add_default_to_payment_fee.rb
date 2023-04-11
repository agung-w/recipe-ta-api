class AddDefaultToPaymentFee < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :payment_fee, :float, :default => 0
  end
end
