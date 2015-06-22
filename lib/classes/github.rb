# Github API Wrapper Class
class GithubAPI
  def initialize
    @root = 'https://api.github.com'
  end

  def user(args)
    HTTParty.get "#{@root}/users/#{args[:username]}"
  end

  def repos(args)
    HTTParty.get "#{@root}/users/#{args[:username]}/repos"
  end

  def repo_languages(args)
    HTTParty.get "#{@root}/repos/#{args[:username]}/#{args[:project]}/languages"
  end
end
