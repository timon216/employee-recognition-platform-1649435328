require 'rails_helper'

RSpec.describe 'Order - buying a Reward and listing Orders to Employee', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:employee1) { create(:employee) }
  let(:employee2) { create(:employee) }
  let!(:reward1) { create(:reward, price: 1) }
  let!(:order) { create(:order, employee: employee2, reward: reward1) }

  context 'when an Employee buys a Reward' do
    before do
      create(:kudo, receiver: employee1)
    end

    it 'lowers number of points after purchase' do
      sign_in employee1
      visit rewards_path
      expect(page).to have_content('Earned points: 1')
      click_link 'Buy reward'
      expect(page).to have_content('You have bought a new reward')
      expect(page).to have_content('Earned points: 0')
    end
  end

  context 'when Employee lists bought Rewards' do
    it 'shows all Orders' do
      sign_in employee2
      visit orders_path
      expect(page).to have_content order.reward_snapshot.title
      expect(page).to have_content order.reward_snapshot.description
      expect(page).to have_content order.created_at.strftime('%d/%m/%Y')
      expect(page).to have_content order.purchase_price
    end
  end

  context 'when Admin changes Reward\'s current price' do
    let(:admin) { create(:admin) }

    before do
      sign_in admin
      visit '/admins/rewards'
      click_link 'Edit'
      within('form') do
        fill_in 'Price', with: '5'
      end
      sign_out admin
    end

    it 'does not affect the price displayed in list of Employee\'s Orders' do
      sign_in employee2
      visit orders_path
      expect(order.purchase_price).to eq(1)
      expect(page).to have_content('1.0')
    end
  end
end
