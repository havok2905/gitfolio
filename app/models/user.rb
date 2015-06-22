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
# integer  :role
# integer  :profile_id
#
class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  enum role: [:admin, :developer]

  belongs_to :profile

  # Define getters on a class level for role values
  roles.each do |key, value|
    define_singleton_method(key) { value }
  end

  class << self
    def role_names
      roles.map { |key, _value| key }
    end

    def from_omniauth(auth)
      where(provider: provider(auth), uid: uid(auth)).first_or_create do |user|
        user.provider = provider(auth)
        user.uid = uid(auth)
        user.email = email(auth)
        user.password = devise_token
        user.role = developer
      end
    end

    private

    def provider(auth)
      auth.provider
    end

    def uid(auth)
      auth.uid
    end

    def email(auth)
      auth.info.email
    end

    def devise_token
      Devise.friendly_token[0, 20]
    end
  end
end
