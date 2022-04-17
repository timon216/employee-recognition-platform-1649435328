require 'rails_helper'

RSpec.describe "Employees", type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'sign up' do
    before(:each) do
      visit new_employee_registration_path
      within('form') do
        fill_in 'Email', with: 'employee@test.com'
      end
    end

    scenario "should be succesful" do
      within('form') do
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
      end
      click_button 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    scenario "should fail - no password" do
      within('form') do
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: ''
      end
      click_button 'Sign up'
      expect(page).to have_content('Password can\'t be blank')
    end

    scenario "should fail - password and password confirmation are different" do
      within('form') do
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'qwerty'
      end
      click_button 'Sign up'
      expect(page).to have_content('Password confirmation doesn\'t match Password')
    end
  end

  context 'sign in' do
    before(:each) do
      employee = create(:employee, email: 'employee@test.com', password: 'password')
      visit new_employee_session_path
    end

    scenario "should be succesful" do
      within('form') do
        fill_in 'Email', with: 'employee@test.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end
    
    scenario "should fail - invalid email" do
      within('form') do
        fill_in 'Email', with: 'employ@test.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    scenario "should fail - invalid password" do
      within('form') do
        fill_in 'Email', with: 'employee@test.com'
        fill_in 'Password', with: 'qwerty'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
