class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: false, primary_key: %i[id] do |t|
      t.string :id, null: false
      t.references :user, null: false, foreign_key: {to_table: :users}
      t.string :shipping_address, null: false
      t.float :shipping_fee, null: false
      t.float :payment_fee, null: false
      t.float :order_total, null: false
      t.float :total, null: false
      t.string :status, null: false
      t.timestamp :order_time, null: false
      t.timestamp :paid_time
      t.timestamp :sent_time
      t.timestamp :finished_time
      t.timestamp :cancel_time
      t.timestamps
    end
  end
end
