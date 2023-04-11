class AddColumnToRecipeBundle < ActiveRecord::Migration[7.0]
  def change
    add_column :recipe_bundles, :pic_url, :string
  end
end
