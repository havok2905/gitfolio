class AddReposToProfile < ActiveRecord::Migration
  def change
    change_table :repos do |t|
      add_reference :repos, :profile, index: true
    end
  end
end
