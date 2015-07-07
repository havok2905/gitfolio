class AddFlagToRepos < ActiveRecord::Migration
  def change
    change_table :repos do |t|
      add_column :repos, :whitelist, :boolean
    end
  end
end
