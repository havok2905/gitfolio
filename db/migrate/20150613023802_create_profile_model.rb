class CreateProfileModel < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :tagline
      t.string :position
      t.string :email
    end
  end
end
