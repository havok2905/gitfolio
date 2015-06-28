class CreateWhitelist < ActiveRecord::Migration
  def change
    create_table :whitelists do |t|
      t.integer :user_id
      t.timestamps
    end

    change_table :repos do |t|
      add_reference :repos, :whitelist, index: true
    end

    add_index :whitelists, :user_id
  end
end
