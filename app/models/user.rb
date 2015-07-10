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
# string   :nickname
# integer  :role
# integer  :profile_id
#
class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  enum role: [:admin, :developer]

  belongs_to :profile
  has_many :repos

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

  def sync_repos
    repo_list = api.repo_data(username: nickname).map do |r|
      repo = Repo.where(user_id: id, name: r[:name]).first_or_create(
        url: r[:url],
        description: r[:description],
        name: r[:name],
        user_id: id
      )

      r[:languages].each do |key, value|
        repo.repo_languages << language(name: key, lines: value, repo_id: repo.id)
      end

      repo
    end
    
    update_attributes repos: repo_list
  end

  private

  def language(args)
    RepoLanguage.where(args).first_or_create(args)
  end

  def api
    @api ||= GithubApi.new
  end

end
