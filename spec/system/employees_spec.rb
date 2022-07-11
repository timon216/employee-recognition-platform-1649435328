require 'rails_helper'

RSpec.describe 'Employees', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when Employee signs up' do
    before do
      visit new_employee_registration_path
      within('form') do
        fill_in 'Email', with: 'employee@test.com'
      end
    end

    it 'allows to sign up with valid password and password confirmation' do
      within('form') do
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
      end
      click_button 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    it 'does not allow to sign up without password' do
      within('form') do
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: ''
      end
      click_button 'Sign up'
      expect(page).to have_content('Password can\'t be blank')
    end

    it 'does not allow to sign up with different password and password confirmation' do
      within('form') do
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'qwerty'
      end
      click_button 'Sign up'
      expect(page).to have_content('Password confirmation doesn\'t match Password')
    end
  end

  context 'when Employee signs in' do
    let!(:employee) { create(:employee) }

    before do
      visit new_employee_session_path
    end

    it 'allows to sign in with valid email and password' do
      within('form') do
        fill_in 'Email', with: employee.email
        fill_in 'Password', with: employee.password
      end
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end

    it 'does not allow to sign in with invalid email' do
      within('form') do
        fill_in 'Email', with: 'employ@test.com'
        fill_in 'Password', with: employee.password
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'does not allow to sign in with invalid password' do
      within('form') do
        fill_in 'Email', with: employee.email
        fill_in 'Password', with: 'qwerty'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
