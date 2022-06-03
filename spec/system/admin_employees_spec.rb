require 'rails_helper'

RSpec.describe 'Admin - RUD actions for Employee', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }

  context 'when I list all employees' do
    it 'shows all employees' do
      sign_in admin
      visit '/admins/pages/dashboard'
      click_link 'Employees'
      expect(page).to have_content employee.email
      expect(page).to have_content employee.number_of_available_kudos
      expect(page).to have_content('Edit')
      expect(page).to have_content('Delete')
    end

    it 'does not show employees without logging in' do
      visit '/admins/employees'
      expect(page).to have_current_path '/admin/sign_in'
    end
  end

  context 'when I delete employee' do
    before do
      sign_in admin
      visit '/admins/employees'
    end

    it 'allows to delete the employee' do
      expect { click_link 'Delete' }.to change(Employee, :count).by(-1)
      expect(page).to have_content('Employee was successfully destroyed.')
    end
  end

  context 'when I edit employee' do
    before do
      sign_in admin
      visit '/admins/employees'
      click_link 'Edit'
    end

    it 'allows to edit employee with changing password' do
      within('form') do
        fill_in 'Email', with: 'test2@test.com'
        fill_in 'Password', with: 'password2'
      end
      click_button 'Update'
      expect(page).to have_content('Employee was successfully updated.')
    end

    it 'allows to edit employee without changing password' do
      within('form') do
        fill_in 'Email', with: 'test2a@test.com'
      end
      click_button 'Update'
      expect(page).to have_content('Employee was successfully updated.')
    end
  end
end
