# == Schema Information
#
# Table name: repos
#
#  id          :integer          not null, primary key
#  url         :string
#  description :string
#  name        :string
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  whitelist   :boolean
#
# Indexes
#
#  index_repos_on_user_id  (user_id)
#

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
