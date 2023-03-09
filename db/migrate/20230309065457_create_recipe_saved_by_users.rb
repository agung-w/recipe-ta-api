class CreateRecipeSavedByUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_saved_by_users, id: false, primary_key: %i[user recipe] do |t|
      t.references :user, null: false, foreign_key: {to_table: :users}
      t.references :recipe, null: false, foreign_key: {to_table: :recipes}

      t.timestamps
    end
  end
end
