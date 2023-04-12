class AddPkToUserSavedRecipe < ActiveRecord::Migration[7.0]
  def change
    execute "ALTER TABLE recipe_saved_by_users ADD PRIMARY KEY (recipe_id,user_id);"
  end
end
