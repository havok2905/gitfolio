# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  tagline    :string
#  position   :string
#  email      :string
#  created_at :datetime
#  updated_at :datetime
#  published  :boolean          default(FALSE)
#

require 'rails_helper'
include RequiresRepo

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
        @profile = full_repo.user.profile
      end

      it 'should return a valid view model' do
        expect(@profile.view_model.nil?).to eq(false)
      end
    end
  end
end
