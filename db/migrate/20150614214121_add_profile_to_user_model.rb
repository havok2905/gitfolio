class AddProfileToUserModel < ActiveRecord::Migration
  def change
    add_reference :users, :profile, index: true
  end
end
