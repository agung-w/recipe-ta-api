class CreateCookingSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :cooking_steps do |t|
      t.references :recipe, null: false, foreign_key: { to_table: :recipes }
      t.string :description
      t.string :pic_url

      t.timestamps
    end
  end
end
