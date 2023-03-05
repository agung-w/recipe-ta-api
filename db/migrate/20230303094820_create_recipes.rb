class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title, null: false, :limit => 100
      t.string :poster_pic_url
      t.string :description, null: false, :limit=>1000
      t.integer :favorite_count, :default => 0
      t.integer :prep_time, null: false
      t.integer :serving, null: false
      t.references :user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
