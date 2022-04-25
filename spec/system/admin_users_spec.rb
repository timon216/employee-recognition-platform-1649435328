require 'rails_helper'

RSpec.describe 'AdminUsers', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when I sign in' do
    before do
      create(:admin_user, email: 'admin1@test.com', password: 'qwerty')
      visit new_admin_user_session_path
    end

    it 'is succesful' do
      within('form') do
        fill_in 'Email', with: 'admin1@test.com'
        fill_in 'Password', with: 'qwerty'
      end
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end

    it 'fails - invalid email' do
      within('form') do
        fill_in 'Email', with: 'admin@test.com'
        fill_in 'Password', with: 'qwerty'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'fails - invalid password' do
      within('form') do
        fill_in 'Email', with: 'admin1@test.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
