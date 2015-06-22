require 'rails_helper'

RSpec.describe User do
  subject { User }

  before :each do
    @user = User.new
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
