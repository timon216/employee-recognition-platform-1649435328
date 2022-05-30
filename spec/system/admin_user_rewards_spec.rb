require 'rails_helper'

RSpec.describe 'AdminUser - CRUD actions for Reward', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:admin_user) { create(:admin_user) }
  let!(:reward) { create(:reward) }

  context 'when I list all Rewards' do
    it 'shows all Rewards' do
      sign_in admin_user
      visit '/admin/pages/dashboard'
      click_link 'Rewards'
      expect(page).to have_content reward.title
      expect(page).to have_content reward.description
      expect(page).to have_content reward.price
    end

    it 'does not show Rewards without logging in' do
      visit '/admin/rewards'
      expect(page).to have_current_path '/admin/sign_in'
    end
  end

  context 'when I create Reward' do
    before do
      sign_in admin_user
      visit '/admin/rewards'
    end

    it 'allows to create new Reward' do
      click_link 'New Reward'
      within('form') do
        fill_in 'Title', with: "Awesome Reward Title"
        fill_in 'Description', with: "Awesome Reward Description"
        fill_in 'Price', with: "99"
      end
      click_button 'Create Reward'
      expect(page).to have_content('Reward was successfully created.')
    end

    it 'does not allow to create Reward with price lower than 1' do
      click_link 'New Reward'
      within('form') do
        fill_in 'Title', with: reward.title
        fill_in 'Description', with: reward.description
        fill_in 'Price', with: '0.1'
      end
      click_button 'Create Reward'
      expect(page).to have_content('Price must be greater than or equal to 1')
    end
  end

  context 'when I edit Reward' do
    before do
      sign_in admin_user
      visit '/admin/rewards'
    end

    it 'allows to update the title, content and price' do
      click_link 'Edit'
      within('form') do
        fill_in 'Title', with: 'Edited title'
        fill_in 'Description', with: 'Edited description'
        fill_in 'Price', with: '10'
      end
      click_button 'Update Reward'
      expect(page).to have_content('Reward was successfully updated.')
    end
  end

  context 'when I delete Reward' do
    before do
      sign_in admin_user
      visit '/admin/rewards'
    end

    it 'allows to delete the Reward' do
      expect { click_link 'Delete' }.to change(Reward, :count).by(-1)
      expect(page).to have_content('Reward was successfully destroyed.')
    end
  end
end
