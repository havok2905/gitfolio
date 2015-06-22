require 'rails_helper'

RSpec.describe ProfilePolicy do
  subject { ProfilePolicy }

  let(:admin) { User.new(role: User.admin) }
  let(:developer) { User.new(role: User.developer) }
  let(:developer_with_profile) { User.new(role: User.developer, profile_id: 1) }

  permissions :index? do
    it 'denies access unless user is an admin' do
      expect(subject).to permit(admin, :profile)
      expect(subject).not_to permit(developer, :profile)
    end
  end

  permissions :show? do
    it 'denies access to nobody' do
      expect(subject).to permit(admin, :profile)
      expect(subject).to permit(developer, :profile)
    end
  end

  permissions :new? do
    it 'denies access unless user is an admin or a profileless developer' do
      expect(subject).to permit(admin, :profile)
      expect(subject).to permit(developer, :profile)
      expect(subject).not_to permit(developer_with_profile, :profile)
    end
  end

  permissions :create? do
    it 'denies access unless user is an admin or a profileless developer' do
      expect(subject).to permit(admin, :profile)
      expect(subject).to permit(developer, :profile)
      expect(subject).not_to permit(developer_with_profile, :profile)
    end
  end

  permissions :edit? do
    it 'denies access unless the user is an admin or developer' do
      expect(subject).to permit(admin, :profile)
      expect(subject).to permit(developer, :profile)
    end
  end

  permissions :update? do
    it 'denies access unless the user is an admin or developer' do
      expect(subject).to permit(admin, :profile)
      expect(subject).to permit(developer, :profile)
    end
  end
end
