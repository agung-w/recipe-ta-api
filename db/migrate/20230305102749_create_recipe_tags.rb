class CreateRecipeTags < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_tags, id: false, primary_key: %i[recipe tags] do |t|
      t.references :recipe, null: false, foreign_key: { to_table: :recipes }
      t.references :tag, null: false, foreign_key: { to_table: :tags }

      t.timestamps
    end
  end
end
