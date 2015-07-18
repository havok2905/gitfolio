# == Schema Information
#
# Table name: repo_languages
#
#  id         :integer          not null, primary key
#  name       :string
#  bytes      :integer
#  repo_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_repo_languages_on_repo_id  (repo_id)
#
class RepoLanguage < ActiveRecord::Base
  has_one :repo

  validates :name, presence: true
  validates :bytes, presence: true
end
