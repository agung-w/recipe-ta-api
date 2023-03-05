class CreateMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :metrics do |t|
      t.string :name, null: false, :limit => 100
      t.string :abbrev, null: false, :limit => 6
      t.float :volume
      t.float :weight

      t.timestamps
    end
  end
end
