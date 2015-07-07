require 'rails_helper'

RSpec.describe UserPolicy do
  subject { UserPolicy }

  let(:admin) { User.new(role: User.admin) }
  let(:developer) { User.new(role: User.developer) }

  permissions :index?, :edit?, :update?, :show? do
    it 'denies access unless user is an admin' do
      expect(subject).to permit(admin, :user)
      expect(subject).not_to permit(developer, :user)
    end
  end

  permissions :sync_repos? do
    it 'denies access unless user is an admin or developer' do
      expect(subject).to permit(admin, :user)
      expect(subject).to permit(developer, :user)
    end
  end
end
