class AddNicknameToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      add_column :users, :nickname, :string
    end
  end
end
