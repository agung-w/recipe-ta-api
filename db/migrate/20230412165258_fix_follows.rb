class FixFollows < ActiveRecord::Migration[7.0]
  def change
    remove_column :follows, :id
    execute "ALTER TABLE follows ADD PRIMARY KEY (user_id,followed_id);"
  end
end
