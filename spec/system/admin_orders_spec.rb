require 'rails_helper'

RSpec.describe 'Admin - listing Employees\' Orders', type: :system do
  let(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }
  let!(:order) { create(:order, employee: employee) }

  context 'when Admin lists Orders' do
    before do
      sign_in admin
      visit '/admins/pages/dashboard'
    end

    it 'shows Orders of each Employee in their details\' page' do
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
