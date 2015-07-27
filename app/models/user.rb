# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  role                   :integer
#  profile_id             :integer
#  nickname               :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_profile_id            (profile_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  enum role: [:admin, :developer]

  belongs_to :profile
  has_many :repos

  validates :email, presence: true
  validates :role, presence: true

  # Define getters on a class level for role values
  roles.each do |key, value|
    define_singleton_method(key) { value }
  end

  class << self
    def role_names
      roles.map { |key, _value| key }
    end

    # rubocop:disable Metrics/AbcSize
    def from_omniauth(auth)
      where(provider: provider(auth), uid: uid(auth)).first_or_create do |user|
        user.provider = provider(auth)
        user.uid = uid(auth)
        user.email = email(auth)
        user.password = devise_token
        user.role = developer
        user.nickname = nickname(auth)
      end
    end
    # rubocop:enable Metrics/AbcSize

    private

    def nickname(auth)
      auth.info.nickname
    end

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

  def needs_profile?
    profile.nil? && role == 'developer'
  end

  def profile?
    profile.present? && role == 'developer'
  end

  def whitelist
    repos.select(&:whitelist)
  end
end
