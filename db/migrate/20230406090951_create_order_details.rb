class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details, id: false, foreign_key: %i[order_id recipe_bundle] do |t|
      t.string :order_id, null: false
      t.references :recipe_bundle, null: false, foreign_key: {to_table: :recipe_bundles}
      t.integer :quantity, null: false
      t.float :price, null: false
      t.float :total_price, null: false

      t.timestamps
    end
    add_index :order_details, :order_id
    add_foreign_key :order_details, :orders, column: :order_id, primary_key: :id
  end
end
