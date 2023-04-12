class AddPrimaryKeyToRecipeComment < ActiveRecord::Migration[7.0]
  def change
    change_column :recipe_comments, :user_id, :bigint, foreign_key: {to_table: :users}, :unique => true
    change_column :recipe_comments, :recipe_id, :bigint, foreign_key: {to_table: :recipes}, :unique => true
    add_column :recipe_comments, :timestamp, :timestamp, primary_key: true
  end
end
