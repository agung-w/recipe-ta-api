class AddIndexWithUniqueToTable < ActiveRecord::Migration[7.0]
  def change
    add_index :recipe_tags, [:recipe_id, :tag_id], unique: true
    add_index :recipe_saved_by_users, [:user_id, :recipe_id], unique: true
  end
end
