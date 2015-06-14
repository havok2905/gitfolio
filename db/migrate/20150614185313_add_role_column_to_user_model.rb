class AddRoleColumnToUserModel < ActiveRecord::Migration
  def change
    change_table :users do |t|
      add_column :users, :role, :integer
    end
  end
end
