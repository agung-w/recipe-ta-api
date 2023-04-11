class AddColumnToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :shipping_address_notes, :string, :null => true
    add_column :orders, :recipient_name, :string, :null => false
    add_column :orders, :recipient_contact, :string, :null => false
  end
end
