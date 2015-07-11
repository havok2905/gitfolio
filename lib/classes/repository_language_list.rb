# Manages language list creation, ranking, and sorting
# from a list of given repositories
class RepositoryLanguageList
  attr_accessor :languages

  class << self
    def languages_from(repos)
      languages = Hash.new
      repos.each do |repo|
        repo.repo_languages.each do |language|
          unless languages[language.name]
            languages[language.name] = language.bytes
          else
            languages[language.name] += language.bytes
          end
        end
      end
      languages
    end
  end

  def initialize(args)
    @languages = args[:languages]
  end

  def top_languages
    languages = ranked @languages
    [languages[0], languages[1], languages[2]]
  end

  private

  def ranked(languages)
    languages.map      { |key, value| {name: key, count: value} }
             .group_by { |lang| lang[:count] }
             .sort_by  { |a, b| -a }
             .map      { |c| c[1] }
             .flatten
  end

end
