class Add < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :verify_status, :boolean
  end
end
