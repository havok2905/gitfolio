# Profile Model
#
# string :first_name
# string :last_name
# string :tagline
# string :position
# string :email
# datetime :created_at
# datetime :updated_at
#
class Profile < ActiveRecord::Base
  has_one :user
  has_many :repos

  accepts_nested_attributes_for :repos

  delegate :nickname, to: :user

  def full_name
    first_name + ' ' + last_name
  end
end
