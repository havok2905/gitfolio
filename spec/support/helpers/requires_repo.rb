require 'rails_helper'

# mixin module for creating repos with dependencies
module RequiresRepo
  def full_repo
    create :repo, whitelist: true, repo_languages: [
      RepoLanguage.create({ name: 'javascript', bytes: 100000 }),
      RepoLanguage.create({ name: 'php', bytes: 100000 }),
      RepoLanguage.create({ name: 'c', bytes: 100000 }),
    ]
  end
end
