class AddPkToOrderDetails < ActiveRecord::Migration[7.0]
  def change
    execute "ALTER TABLE order_details ADD PRIMARY KEY (order_id,recipe_bundle_id);"
  end
end
