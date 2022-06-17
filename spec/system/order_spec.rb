require 'rails_helper'

RSpec.describe 'Order - buying a Reward', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:employee1) { create(:employee) }
  let(:employee2) { create(:employee) }
  let!(:kudo) { create(:kudo, receiver: employee1) }
  let!(:reward1) { create(:reward, price: 1) }

  context 'when I buy a Reward' do
    it 'lowers number of points after purchase' do
      sign_in employee1
      visit rewards_path
      expect(page).to have_content('Earned points: 1')
      click_link 'Buy reward'
      expect(page).to have_content('You have bought a new reward')
      expect(employee1.earned_points).to eq(0)
      expect(page).to have_content('Earned points: 0')
    end

    it 'does not allow to buy too expensive Reward' do
      sign_in employee2
      visit rewards_path
      expect(employee2.earned_points).to eq(0)
      expect(page).to have_no_content('Buy reward')
    end
  end
end
