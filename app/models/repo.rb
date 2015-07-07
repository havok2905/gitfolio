# Repo Model
#
# string :url
# string :description
# string :name
# integer :user_id
# boolean :whitelist
# datetime :created_at
# datetime :updated_at
class Repo < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile

  class << self
    def update_whitelist(user, selected_repos)
      Repo.where(user_id: user.id).update_all(whitelist: false)
      Repo.find(selected_repos).each do |r|
        r.update_attributes(whitelist: true)
      end
    end
  end
end
