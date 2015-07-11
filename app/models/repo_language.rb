# RepoLanguage Model
#
# string :name
# integer :bytes
# integer :repo_id
# datetime :created_at
# datetime :updated_at
class RepoLanguage < ActiveRecord::Base
  has_one :repo
end
