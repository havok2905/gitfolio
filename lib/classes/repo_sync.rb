class RepoSync
  def initialize(user, api)
    @user = user
    @api = api
  end

  def run
    @user.update_attributes repos: repo_list
  end

  private

  def language(args)
    RepoLanguage.where(args).first_or_create(args)
  end

  def repo_list
    @api.repo_data(username: @user.nickname).map do |r|
      repo = Repo.where(user_id: @user.id, name: r[:name]).first_or_create

      puts repo

      repo.update_attributes(
        url: r[:url],
        description: r[:description],
        name: r[:name],
        user_id: @user.id
      )

      r[:languages].each do |key, value|
        repo.repo_languages << language(name: key, bytes: value, repo_id: repo.id)
      end

      repo
    end
  end
end
