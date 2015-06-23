# Profile Model
#
# string :first_name
# string :last_name
# string :tagline
# string :position
# string :email
#
class Profile < ActiveRecord::Base
  has_one :user

  def full_name
    first_name + ' ' + last_name
  end
end
