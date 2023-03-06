class CreateCookingSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :cooking_steps, id:false, primary_key: %i[recipe step] do |t|
      t.references :recipe, null: false, foreign_key: { to_table: :recipes }
      t.integer :step, null: false
      t.string :description, null:false, :limit => 1000
      t.string :pic_url

      t.timestamps
    end
  end
end
