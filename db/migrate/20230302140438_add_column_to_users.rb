class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :followers_count, :integer, :default => 0
    change_column :users, :following_count, :integer, :default => 0
    add_column :users, :bookmark_count, :integer, :default => 0
    add_column :users, :posted_recipe_count, :integer, :default => 0
  end
end
