require 'rails_helper'

RSpec.describe Repo do
  subject { Repo }

  before :each do
    @repo = Repo.new
  end

  context 'class methods' do
    context '#update_whitelist' do
      # TODO: add test here
    end
  end

  context 'instance methods' do
    context '#primary_language' do
      it 'should return the primary language' do
        expect(full_repo.primary_language).to eq('c')
      end
    end
  end
end
