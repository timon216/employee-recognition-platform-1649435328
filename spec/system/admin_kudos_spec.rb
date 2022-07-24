require 'rails_helper'

RSpec.describe 'Admin - RD actions for kudo', type: :system do
  let(:admin) { create(:admin) }
  let(:giver) { create(:employee) }
  let!(:receiver) { create(:employee) }
  let!(:kudo) { create(:kudo) }

  context 'when Admin lists all Kudos' do
    it 'shows all Kudos' do
      sign_in admin
      visit '/admins/pages/dashboard'
      click_link 'Kudos'
      expect(page).to have_content kudo.title
      expect(page).to have_content kudo.content
      expect(page).to have_content kudo.giver.email
      expect(page).to have_content kudo.receiver.email
      expect(page).to have_content('Delete')
    end

    it 'does not show Kudos without Admin logging in' do
      visit '/admins/kudos'
      expect(page).to have_current_path '/admin/sign_in'
    end
  end

  context 'when Admin deletes the Kudo' do
    before do
      sign_in admin
      visit '/admins/kudos'
    end

    it 'allows to delete the kudo' do
      expect { click_link 'Delete' }.to change(Kudo, :count).by(-1)
      expect(page).to have_content('Kudo was successfully destroyed.')
    end
  end
end
