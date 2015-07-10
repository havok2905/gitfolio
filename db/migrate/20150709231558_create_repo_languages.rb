class CreateRepoLanguages < ActiveRecord::Migration
  def change
    create_table :repo_languages do |t|
      t.string :name
      t.integer :lines
      t.integer :repo_id
      t.timestamps
    end

    add_index :repo_languages, :repo_id
  end
end
