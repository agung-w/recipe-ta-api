class CreateRecipeBundles < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_bundles do |t|
      t.references :recipe, null: false, foreign_key: {to_table: :recipes}
      t.string :description, null: false
      t.string :title, null: false
      t.float :price, null: false
      t.integer :stock, :default => 0

      t.timestamps
    end
  end
end
