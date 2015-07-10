# RepoLanguage Model
#
# string :name
# integer :lines
# integer :repo_id
# datetime :created_at
# datetime :updated_at
class RepoLanguage < ActiveRecord::Base
  has_one :repo
end
