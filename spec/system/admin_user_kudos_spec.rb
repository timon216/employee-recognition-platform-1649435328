require 'rails_helper'

RSpec.describe 'AdminUser - RD actions for kudo', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:admin_user) { create(:admin_user) }
  let(:giver) { create(:employee) }
  let!(:receiver) { create(:employee) }
  let!(:kudo) { create(:kudo) }

  context 'when I list all kudos' do
    it 'shows all kudos' do
      sign_in admin_user
      visit '/admin/pages/dashboard'
      click_link 'Kudos'
      expect(page).to have_content kudo.title
      expect(page).to have_content kudo.content
      expect(page).to have_content kudo.giver.email
      expect(page).to have_content kudo.receiver.email
      expect(page).to have_content('Delete')
    end

    it 'does not show kudos without logging in' do
      visit '/admin/kudos'
      expect(page).to have_current_path '/admin/sign_in'
    end
  end

  context 'when I delete kudos' do
    before do
      sign_in admin_user
      visit '/admin/kudos'
    end

    it 'allows to delete the kudo' do
      expect { click_link 'Delete' }.to change(Kudo, :count).by(-1)
      expect(page).to have_content('Kudo was successfully destroyed.')
    end
  end
end
