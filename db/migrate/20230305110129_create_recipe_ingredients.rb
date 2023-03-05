class CreateRecipeIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_ingredients, id: false, primary_key: %i[recipe ingredient] do |t|
      t.references :recipe, null: false, foreign_key: { to_table: :recipes }
      t.references :ingredient, null: false, foreign_key: { to_table: :ingredients }
      t.integer :quantity
      t.references :metric, null: true, foreign_key:{to_table: :metrics}
      t.timestamps
    end
  end
end
