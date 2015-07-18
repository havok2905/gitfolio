require 'rails_helper'
include Loginable

RSpec.describe ProfilesController do
  subject { ProfilesController }

  let(:valid_update_params) do
    {
      first_name: 'Updated',
      last_name: 'Updated',
      tagline: 'Updated',
      position: 'Updated',
      email: 'updated@updated.updated'
    }
  end

  let(:valid_create_params) do
    {
      first_name: 'Created',
      last_name: 'Created',
      tagline: 'Created',
      position: 'Created',
      email: 'created@created.created'
    }
  end

  before :each do
    login_admin
  end

  context '#update' do
    it 'should update a profile' do
      profile = create(:profile, user: User.last)
      patch :update, id: profile.id, profile: valid_update_params
      expect(response).to redirect_to profile_path(profile)
    end
  end

  context '#create' do
    it 'should create a profile' do
      post :create, profile: valid_create_params
      expect(response).to redirect_to profile_path(Profile.last)
    end
  end

  context '#publish' do
    it 'should make a profile published' do
      profile = create(:profile, user: User.first)
      expect(profile.published).to be(false)
      patch :publish, id: profile.id
      profile.reload
      expect(profile.published).to be(true)
    end
  end

  context '#deactivate' do
    it 'should make a profile deactivated' do
      profile = create(:profile, user: User.first, published: true)
      expect(profile.published).to be(true)
      patch :deactivate, id: profile.id
      profile.reload
      expect(profile.published).to be(false)
    end
  end
end
