class UsersHaveRepos < ActiveRecord::Migration
  def change
    change_table :repos do |t|
      add_column :repos, :user_id, :integer
    end
  end
end
