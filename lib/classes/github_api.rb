# Github API Wrapper Class
class GithubApi
  def initialize
    @root = 'https://api.github.com'
  end

  def user(args)
    HTTParty.get "#{@root}/users/#{args[:username]}", params
  end

  def repos(args)
    HTTParty.get "#{@root}/users/#{args[:username]}/repos?per_page=100", params
  end

  def repo_data(args)
    repos = HTTParty.get "#{@root}/users/#{args[:username]}/repos?per_page=100", params
    repos.map do |repo|
      {
        name: repo['name'],
        url: repo['html_url'],
        description: repo['description'],
        languages: repo_languages(username: args[:username], project: repo['name'])
      }
    end
  end

  def repo_languages(args)
    HTTParty.get "#{@root}/repos/#{args[:username]}/#{args[:project]}/languages", params
  end

  private

  def params
    { query: { access_token: ENV['GITHUB_ACCESS_TOKEN'] } }
  end
end
