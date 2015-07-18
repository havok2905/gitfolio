# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  role                   :integer
#  profile_id             :integer
#  nickname               :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_profile_id            (profile_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'
include RequiresRepo

RSpec.describe User do
  subject { User }

  before :each do
    @user = User.new
  end

  context 'class methods' do
    context '#role_names' do
      it 'should return a list' do
        expect(User.role_names.empty?).to be(false)
      end
    end
  end

  context 'instance methods' do
    context '#needs_profile?' do
      context 'developer user' do
        before :each do
          @user = create(:developer)
        end

        it 'should be true for developers with no profiles' do
          @user.profile = nil
          expect(@user.needs_profile?).to be(true)
        end

        it 'should be false for developers with profiles' do
          expect(@user.needs_profile?).to be(false)
        end
      end

      context 'admin user' do
        before :each do
          @user = create(:admin)
        end

        it 'should be false for admins' do
          expect(@user.needs_profile?).to be(false)
        end
      end
    end

    context '#profile?' do
      context 'developer user' do
        before :each do
          @user = create(:developer)
        end

        it 'should be true for developers with profiles' do
          expect(@user.profile?).to be(true)
        end

        it 'should be false for developers with no profiles' do
          @user.profile = nil
          expect(@user.profile?).to be(false)
        end
      end

      context 'admin user' do
        before :each do
          @user = create(:admin)
        end

        it 'should be false for admins' do
          expect(@user.profile?).to be(false)
        end
      end
    end

    context '#sync_repos' do
      # TODO: add test here
    end

    context '#whitelist' do
      before :each do
        @whitelist_repo = create(:repo, user: create(:developer, email: 'foo@foo.foo'), whitelist: true)
        @normal_repo = create(:repo, user: create(:developer, email: 'bar@bar.bar'), whitelist: false)
      end

      it 'should only return whitelisted repositories' do
        expect(@normal_repo.user.whitelist.empty?).to be(true)
        expect(@whitelist_repo.user.whitelist.empty?).to be(false)
      end
    end
  end

  context 'class methods' do
    context '#role_names' do
      it 'should return just the names of roles from the enum' do
        expect(User.role_names).to eq(%w(admin developer))
      end
    end

    context 'dynamically defined methods' do
      it 'should have class level getters for roles' do
        expect(User.methods.include? :developer).to be(true)
        expect(User.methods.include? :admin).to be(true)
      end
    end
  end
end
