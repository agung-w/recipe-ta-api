class AllowNullOnPaymentFee < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :payment_fee, :float, :null => true
  end
end
