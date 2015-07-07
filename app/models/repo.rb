# Repo Model
#
# string :url
# string :description
# string :name
# integer :user_id
# datetime :created_at
# datetime :updated_at
class Repo < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile
end
