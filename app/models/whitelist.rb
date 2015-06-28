# Whitelist Model
#
# integer :user_id
# datetime :created_at
# datetime :updated_at

class Whitelist < ActiveRecord::Base
  belongs_to :user
  has_many :repos
end
