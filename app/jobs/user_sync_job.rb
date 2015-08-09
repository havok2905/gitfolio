module UserSyncJob
  @queue = :high
  @api = GithubApi.new

  def self.perform
    User.all.each do |user|
      unless user.repos.empty?
        repo_sync = RepoSync.new user, @api
        repo_sync.run
      end
    end
  end
end
