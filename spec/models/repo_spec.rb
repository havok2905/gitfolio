require 'rails_helper'

RSpec.describe Repo do
  subject { Repo }

  before :each do
    @repo = Repo.new
  end

  context 'class methods' do
    context '#update_whitelist' do
      # TODO: add test here
    end
  end

  context 'instance methods' do
    context '#primary_language' do
      it 'should return the primary language' do
        repo = create :repo, whitelist: true, repo_languages: [
          RepoLanguage.create({ name: 'javascript', bytes: 1000000 }),
          RepoLanguage.create({ name: 'php', bytes: 100000 }),
          RepoLanguage.create({ name: 'c', bytes: 100000 }),
        ]

        expect(repo.primary_language).to eq('javascript') 
      end
    end
  end
end
