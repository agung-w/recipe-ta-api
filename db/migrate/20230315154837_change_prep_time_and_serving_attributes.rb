class ChangePrepTimeAndServingAttributes < ActiveRecord::Migration[7.0]
  def change
    change_column :recipes, :prep_time, :integer, :null => true
    change_column :recipes, :serving, :integer, :null => true
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
