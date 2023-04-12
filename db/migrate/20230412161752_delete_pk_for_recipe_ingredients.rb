class DeletePkForRecipeIngredients < ActiveRecord::Migration[7.0]
  def change
    execute "ALTER TABLE recipe_ingredients DROP CONSTRAINT recipe_ingredients_pkey"
  end
end
