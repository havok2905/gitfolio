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
      profile: create(:profile),
      email: 'baz@baz.baz',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  permissions :launch? do
    it 'allows access to developers and admins' do
      expect(subject).to permit(admin, :profile)
      expect(subject).to permit(developer, :profile)
    end
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

  permissions :publish?, :deactivate?, :edit?, :update? do
    it 'allows access to profile owners' do
      expect(subject).to permit(admin, developer_with_profile.profile)
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
end
