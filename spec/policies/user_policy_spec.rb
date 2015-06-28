require 'rails_helper'

RSpec.describe UserPolicy do
  subject { UserPolicy }

  let(:admin) { User.new(role: User.admin) }
  let(:developer) { User.new(role: User.developer) }

  permissions :index?, :edit?, :update?, :show? do
    it 'denies access unless user is an admin' do
      expect(subject).to permit(admin, :profile)
      expect(subject).not_to permit(developer, :profile)
    end
  end
end
