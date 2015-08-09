module UserSyncJob
  @queue = :high

  def self.perform
    'job'
  end
end
