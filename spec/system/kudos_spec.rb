require 'rails_helper'

RSpec.describe "Kudos", type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'create the kudo' do
    before(:each) do
      employee = create(:employee, email: 'employee@test.com', password: 'password')
      visit new_employee_session_path
      within('form') do
        fill_in 'Email', with: 'employee@test.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'

      click_link 'New Kudo'
      expect(page).to have_content('New Kudo')
    end

    scenario "should be succesful" do 
      within('form') do
        fill_in 'Title', with: 'Nice kudo'
        fill_in 'Content', with: 'Nice content'
      end
      click_button 'Create Kudo'
      expect(page).to have_content('Kudo was successfully created.')
    end

    scenario "should fail - no title" do 
      within('form') do
        fill_in 'Title', with: ''
        fill_in 'Content', with: 'Nice content'
      end
      click_button 'Create Kudo'
      expect(page).to have_content('Title can\'t be blank')
    end

    scenario "should fail - no content" do 
      within('form') do
        fill_in 'Title', with: 'Kudo'
        fill_in 'Content', with: ''
      end
      click_button 'Create Kudo'
      expect(page).to have_content('Content can\'t be blank')
    end

  end

  context 'edit the kudo' do
    before(:each) do
      employee = create(:employee, email: 'employee@test.com', password: 'password')
      visit new_employee_session_path
      within('form') do
        fill_in 'Email', with: 'employee@test.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      click_link 'New Kudo'
      within('form') do
        fill_in 'Title', with: 'Nice kudo'
        fill_in 'Content', with: 'Nice content'
      end
      click_button 'Create Kudo'
      click_link "Edit"
      expect(page).to have_content('Editing Kudo')
    end

    scenario "should be succesful" do
      within('form') do
        fill_in 'Title', with: 'New title'
        fill_in 'Content', with: 'New content'
      end
      click_button 'Update Kudo'
      expect(page).to have_content('Kudo was successfully updated.')
    end

    scenario "should fail - no title" do
      within('form') do
        fill_in 'Title', with: ''
        fill_in 'Content', with: 'New content'
      end
      click_button 'Update Kudo'
      expect(page).to have_content('Title can\'t be blank')
    end

    scenario "should fail - no content" do
      within('form') do
        fill_in 'Title', with: 'New kudo'
        fill_in 'Content', with: ''
      end
      click_button 'Update Kudo'
      expect(page).to have_content('Content can\'t be blank')
    end

  end

  context 'delete the kudo' do
    scenario "should be succesful" do
      employee = create(:employee, email: 'employee@test.com', password: 'password')
      visit new_employee_session_path
      within('form') do
        fill_in 'Email', with: 'employee@test.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      click_link 'New Kudo'
      within('form') do
        fill_in 'Title', with: 'Nice kudo'
        fill_in 'Content', with: 'Nice content'
      end
      click_button 'Create Kudo'
      
      expect { click_link 'Delete' }.to change(Kudo, :count).by(-1)
      expect(page).to have_content('Kudo was successfully destroyed.')
    end
  end
end
