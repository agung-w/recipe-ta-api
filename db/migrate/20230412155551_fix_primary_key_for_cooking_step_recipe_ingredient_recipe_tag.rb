class FixPrimaryKeyForCookingStepRecipeIngredientRecipeTag < ActiveRecord::Migration[7.0]
  def change
    execute "ALTER TABLE cooking_steps ADD PRIMARY KEY (recipe_id,step);"
    execute "ALTER TABLE recipe_ingredients ADD PRIMARY KEY (recipe_id,ingredient_id);"
    execute "ALTER TABLE recipe_tags ADD PRIMARY KEY (recipe_id,tag_id);"
  end
end
