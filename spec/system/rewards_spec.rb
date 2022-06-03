require 'rails_helper'

RSpec.describe 'Listing available Rewards to employees', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:employee) { create(:employee) }
  let!(:reward) { create(:reward) }

  context 'when I list all Rewards' do
    it 'shows all Rewards' do
      sign_in employee
      visit rewards_path
      expect(page).to have_content reward.title
      expect(page).to have_content reward.price
    end

    it 'does not show Rewards without logging in' do
      visit rewards_path
      expect(page).to have_current_path '/employee/sign_in'
    end

    it 'allows to see Reward\'s details' do
      sign_in employee
      visit rewards_path
      click_link 'Show details'
      expect(page).to have_content reward.description
    end
  end
end
