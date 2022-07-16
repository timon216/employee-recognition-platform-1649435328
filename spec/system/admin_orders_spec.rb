require 'rails_helper'

RSpec.describe 'Admin - listing Employees\' Orders', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }
  let!(:order) { create(:order, employee: employee) }

  before do
    sign_in admin
    visit '/admins/pages/dashboard'
  end

  context 'when Admin lists all Orders' do
    it 'shows all Orders' do
      click_link 'Orders'
      expect(page).to have_content order.reward_snapshot.title
      expect(page).to have_content order.reward_snapshot.description
      expect(page).to have_content order.created_at.strftime('%d/%m/%Y')
      expect(page).to have_content order.purchase_price
    end
  end

  context 'when Admin lists one Employee\'s Orders' do
    it 'shows all Employee\'s Orders' do
      click_link 'Employees'
      click_link 'Show details'
      expect(page).to have_content employee.email
      expect(page).to have_content order.reward_snapshot.title
      expect(page).to have_content order.reward_snapshot.description
      expect(page).to have_content order.created_at.strftime('%d/%m/%Y')
      expect(page).to have_content order.purchase_price
    end
  end
end
