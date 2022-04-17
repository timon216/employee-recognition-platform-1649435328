require 'rails_helper'

RSpec.describe 'Employees', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when I sign up' do
    before do
      visit new_employee_registration_path
      within('form') do
        fill_in 'Email', with: 'employee@test.com'
      end
    end

    it 'is succesful' do
      within('form') do
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
      end
      click_button 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    it 'fails - no password' do
      within('form') do
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: ''
      end
      click_button 'Sign up'
      expect(page).to have_content('Password can\'t be blank')
    end

    it 'fails - password and password confirmation are different' do
      within('form') do
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'qwerty'
      end
      click_button 'Sign up'
      expect(page).to have_content('Password confirmation doesn\'t match Password')
    end
  end

  context 'when I sign in' do
    before do
      create(:employee, email: 'employee@test.com', password: 'password')
      visit new_employee_session_path
    end

    it 'is succesful' do
      within('form') do
        fill_in 'Email', with: 'employee@test.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end

    it 'fails - invalid email' do
      within('form') do
        fill_in 'Email', with: 'employ@test.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'fails - invalid password' do
      within('form') do
        fill_in 'Email', with: 'employee@test.com'
        fill_in 'Password', with: 'qwerty'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
