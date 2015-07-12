require 'rails_helper'

RSpec.describe ProfileViewModel do
  subject { ProfileViewModel }

  context 'class methods' do
    before :each do
      user = create :developer

      @view_model = ProfileViewModel.build(
        profile: user.profile,
        languages: [
          { name: 'javascript', bytes: 5000, repos: 12 },
          { name: 'php', bytes: 50005, repos: 10 },
          { name: 'css', bytes: 1000, repos: 10 }
        ],
        whitelist: [
          create(:repo, user: user)
        ]
      )
    end

    it 'should build a valid view model' do |variable|
      expect(@view_model[:name].present?).to eq(true)
      expect(@view_model[:nickname].present?).to eq(true)
      expect(@view_model[:position].present?).to eq(true)
      expect(@view_model[:tagline].present?).to eq(true)
      expect(@view_model[:email].present?).to eq(true)
      expect(@view_model[:languages].length > 0)
      expect(@view_model[:whitelist].length > 0)
    end
  end
end
