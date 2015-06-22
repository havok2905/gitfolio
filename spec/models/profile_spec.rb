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
  end
end
