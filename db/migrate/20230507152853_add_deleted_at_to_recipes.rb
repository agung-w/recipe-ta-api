class AddDeletedAtToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :deleted_at, :datetime
    add_index :recipes, :deleted_at
  end
end
