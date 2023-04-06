class AddIsPublishToRecipeTables < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :is_published, :boolean, :default =>  nil
    add_index :recipes, :is_published
  end
end
