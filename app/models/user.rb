# User Model
#
# string   :email,              null: false, default: ""
# string   :encrypted_password, null: false, default: ""
# string   :reset_password_token
# datetime :reset_password_sent_at
# datetime :remember_created_at
# integer  :sign_in_count, default: 0, null: false
# datetime :current_sign_in_at
# datetime :last_sign_in_at
# string   :current_sign_in_ip
# string   :last_sign_in_ip
# string   :provider
# string   :uid
# string   :role
#
class User < ActiveRecord::Base

  class << self
    def role_names
      roles.map{ |key, value | key }
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]


  enum role: [:admin, :developer]

  # Define getters on a class level for role values
  roles.each do |key, value|
    define_singleton_method(key) { value }
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.role = self.developer
    end
  end

end
