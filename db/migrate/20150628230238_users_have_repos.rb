class UsersHaveRepos < ActiveRecord::Migration
  def change
    change_table :repos do |t|
      add_reference :repos, :user, index: true
    end
  end
end
