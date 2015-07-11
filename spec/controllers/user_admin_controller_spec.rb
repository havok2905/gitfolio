require 'rails_helper'
include Loginable

RSpec.describe UserAdminController do
  subject { UserAdminController }

  let(:valid_update_params) do
    {
      email: 'updated@updated.updated'
    }
  end

  before :each do
    login_admin
  end

  context '#update' do
    it 'should update a profile' do
      @user = create(:developer)
      patch :update, id: @user.id, user: valid_update_params
      expect(response).to redirect_to user_path(@user)
    end
  end

  context '#sync_repos' do
    # TODO: add tests for syncing repos
  end
end
