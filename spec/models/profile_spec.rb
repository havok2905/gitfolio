require 'rails_helper'

RSpec.describe Profile do
  subject { Profile }

  before :each do
    @profile = Profile.new
  end

  context 'instance methods' do
    context '#full_name' do
      it 'should return a valid full name' do
        @profile.first_name = 'Chris'
        @profile.last_name = 'McLean'
        expect(@profile.full_name).to eq('Chris McLean')
      end
    end

    context '#user_repos' do
      it 'should return a list of repositories to use in profile editing' do
        repo = create :repo
        profile = repo.user.profile
        expect(profile.user_repos.empty?).to eq(false)
      end
    end

    context '#view_model' do
      before :each do
        repo = create :repo, whitelist: true, repo_languages: [
          RepoLanguage.create({ name: 'javascript', bytes: 100000 }),
          RepoLanguage.create({ name: 'php', bytes: 100000 }),
          RepoLanguage.create({ name: 'c', bytes: 100000 }),
        ]

        @profile = repo.user.profile
      end

      it 'should return a valid view model' do
        expect(@profile.view_model.nil?).to eq(false)
      end
    end
  end
end
