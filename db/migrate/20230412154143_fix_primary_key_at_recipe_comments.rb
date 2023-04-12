class FixPrimaryKeyAtRecipeComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipe_comments, :timestamp
    add_column :recipe_comments, :timestamp, :timestamp
    execute "ALTER TABLE recipe_comments ADD PRIMARY KEY (timestamp,recipe_id,user_id);"
  end
end
