class CreateRecipeComments < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_comments, id: false, primary_key: %i[user recipe] do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.string :content,null: false, :limit => 3000
      t.timestamps
    end
  end
end
