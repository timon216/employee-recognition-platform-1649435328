require 'rails_helper'

RSpec.describe 'Kudos', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:giver) { create(:employee) }
  let!(:receiver) { create(:employee) }
  let(:admin_user) { create(:admin_user) }

  context 'when I add kudo' do
    before do
      sign_in giver
      visit 'kudos/new'
      within('form') do
        fill_in 'Title', with: 'Nice kudo'
        fill_in 'Content', with: 'Nice content'
      end
    end

    it 'decreases number of available kudos by 1' do
      click_button 'Create Kudo'
      expect(page).to have_content('Available kudos: 9')
    end
  end

  context 'when I add 10 kudos' do
    before do
      sign_in giver
      visit 'kudos'

      10.times do
        click_link 'New Kudo'
        within('form') do
          fill_in 'Title', with: 'Nice kudo'
          fill_in 'Content', with: 'Nice content'
        end
        click_button 'Create Kudo'
      end
    end

    it 'does not allow to give another kudo' do
      visit 'kudos/new'
      within('form') do
        fill_in 'Title', with: 'Nice kudo'
        fill_in 'Content', with: 'Nice content'
      end
      click_button 'Create Kudo'
      expect(page).to have_content("You don't have any available kudo to give")
    end
  end

  context 'when I delete kudo' do
    before do
      sign_in giver
      visit 'kudos/new'
      within('form') do
        fill_in 'Title', with: 'Nice kudo'
        fill_in 'Content', with: 'Nice content'
      end
      click_button 'Create Kudo'
    end

    it 'increases number of available kudos by 1' do
      click_link 'Delete'
      expect(page).to have_content('Available kudos: 10')
    end
  end

  context 'when admin deletes kudo' do
    before do
      sign_in giver
      visit 'kudos/new'
      within('form') do
        fill_in 'Title', with: 'Nice kudo'
        fill_in 'Content', with: 'Nice content'
      end
      click_button 'Create Kudo'
      sign_out giver
      sign_in admin_user
      visit '/admin/pages/dashboard'
      click_link 'Kudos'
    end

    it 'increases number of employee\'s available kudos by 1' do
      click_link 'Delete'
      sign_out admin_user
      sign_in giver
      visit 'kudos'
      expect(page).to have_content('Available kudos: 10')
    end
  end
end
