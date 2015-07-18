# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  tagline    :string
#  position   :string
#  email      :string
#  created_at :datetime
#  updated_at :datetime
#  published  :boolean          default(FALSE)
#
class Profile < ActiveRecord::Base
  has_one :user
  has_many :repos

  accepts_nested_attributes_for :repos

  delegate :nickname, to: :user

  def full_name
    first_name + ' ' + last_name
  end

  def user_repos
    user.repos.all
  end

  def content?
    first_name.present? && last_name.present? && tagline.present? && position.present? && email.present?
  end

  def view_model
    languages = RepositoryLanguageList.languages_from user_repos
    list = RepositoryLanguageList.new(languages: languages)
    ProfileViewModel.build(profile: self, whitelist: user.whitelist, languages: list.top_languages)
  end
end
