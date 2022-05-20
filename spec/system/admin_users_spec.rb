require 'rails_helper'

RSpec.describe 'AdminUsers', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when I sign in' do
    let(:admin) { create(:admin_user) }

    before do
      visit new_admin_user_session_path
    end

    it 'is allows to sign in with valid email and password' do
      within('form') do
        fill_in 'Email', with: admin.email
        fill_in 'Password', with: admin.password
      end
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end

    it 'does not allow to sign in with invalid email' do
      within('form') do
        fill_in 'Email', with: 'admin@test.com'
        fill_in 'Password', with: admin.password
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'does not allow to sign in with invalid password' do
      within('form') do
        fill_in 'Email', with: admin.email
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
