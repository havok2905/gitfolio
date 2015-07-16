require 'rails_helper'
include RequiresRepo

RSpec.describe RepositoryLanguageList do
  subject { RepositoryLanguageList }

  context 'class methods' do
    context '#languages_from' do
      before :each do
        @languages = RepositoryLanguageList.languages_from([full_repo])
      end

      it 'should return a hash of languages from a given resource' do
        expect(@languages.class).to be(Hash)
      end
    end
  end

  context 'instance methods' do
    context '#top_languages' do
      before :each do
        list = RepositoryLanguageList.new(
          languages: {
            'PHP' => { bytes: 3_000_000, repos: 4 },
            'JavaScript' => { bytes: 1_000_000, repos: 20 },
            'Ruby' => { bytes: 300_000, repos: 10 },
            'HTML' => { bytes: 40_000, repos: 7 },
            'CSS' => { bytes: 30_000, repos: 11 },
            'Python' => { bytes: 3_000, repos: 2 },
            'Go' => { bytes: 1_000, repos: 1 }
          }
        )

        @top_languages = list.top_languages
      end

      it 'should return a list of languages' do
        expect(@top_languages.empty?).to be(false)
      end

      it 'should weigh the number of repositories over number of bytes' do
        expect(@top_languages[0][:name] == 'JavaScript').to be(true)
        expect(@top_languages[0][:name] == 'PHP').to be(false)
      end
    end
  end
end
