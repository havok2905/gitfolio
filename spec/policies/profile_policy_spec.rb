require 'rails_helper'

RSpec.describe ProfilePolicy do
  subject { ProfilePolicy }

  let(:admin) do
    User.create(
      role: User.admin,
      email: 'foo@foo.foo',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  let(:developer) do
    User.create(
      role: User.developer,
      email: 'bar@bar.bar',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  let(:developer_with_profile) do
    User.create(
      role: User.developer,
      profile: Profile.create,
      email: 'baz@baz.baz',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  permissions :index? do
    it 'denies access unless user is an admin' do
      expect(subject).to permit(admin, :profile)
      expect(subject).not_to permit(developer, :profile)
    end
  end

  permissions :show? do
    it 'allows access to admins and profile owners' do
      expect(subject).to permit(admin, developer_with_profile.profile)
      expect(subject).to permit(developer_with_profile, developer_with_profile.profile)
      expect(subject).not_to permit(developer, developer_with_profile.profile)
    end
  end

  permissions :publish?, :deactivate? do
    it 'allows access to profile owners' do
      expect(subject).not_to permit(admin, developer_with_profile.profile)
      expect(subject).not_to permit(developer, developer_with_profile.profile)
      expect(subject).to permit(developer_with_profile, developer_with_profile.profile)
    end
  end

  permissions :new?, :create? do
    it 'denies access unless user is an admin or a profileless developer' do
      expect(subject).to permit(admin, :profile)
      expect(subject).to permit(developer, :profile)
      expect(subject).not_to permit(developer_with_profile, :profile)
    end
  end

  permissions :edit?, :update? do
    it 'denies access unless the user is an admin or developer' do
      expect(subject).to permit(admin, :profile)
      expect(subject).to permit(developer, :profile)
    end
  end
end
