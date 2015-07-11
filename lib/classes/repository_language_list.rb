# Manages language list creation, ranking, and sorting
# from a list of given repositories
class RepositoryLanguageList
  attr_accessor :languages

  class << self
    def languages_from(repos)
      languages = {}
      repos.each do |repo|
        repo.repo_languages.each do |language|
          if languages[language.name]
            language_update(languages, language)
          else
            language_init(languages, language)
          end
        end
      end
      languages
    end

    private

    def language_init(languages, language)
      languages[language.name] = { bytes: language.bytes, repos: 1 }
    end

    def language_update(languages, language)
      languages[language.name][:bytes] += language.bytes
      languages[language.name][:repos] += 1
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
    languages.map { |key, value| { name: key, bytes: value[:bytes], repos: value[:repos] } }
      .sort_by { |lang| -score(lang) }
  end

  def score(language)
    byte_score = Math.log10 language[:bytes]
    language[:repos] * byte_score
  end

end
