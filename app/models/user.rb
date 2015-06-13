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
#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
