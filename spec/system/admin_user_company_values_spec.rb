require 'rails_helper'

RSpec.describe 'AdminUser - CRUD actions for CompanyValue', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:admin_user) { create(:admin_user) }
  let!(:company_value) { create(:company_value) }

  context 'when I list all CompanyValues' do
    it 'is shows all CompanyValues' do
      sign_in admin_user
      visit '/admin/pages/dashboard'
      click_link 'Company Values'
      expect(page).to have_content company_value.title
      expect(page).to have_content company_value.created_at
      expect(page).to have_content company_value.updated_at
    end

    it 'does not show CompanyValues without logging in' do
      visit '/admin/company_values'
      expect(page).to have_current_path '/admin/sign_in'
    end
  end

  context 'when I create CompanyValue' do
    before do
      sign_in admin_user
      visit '/admin/company_values'
    end

    it 'allows to create new CompanyValue' do
      click_link "New Company Value"
      within('form') do
        fill_in 'Title', with: 'New CompanyValue'
      end
      click_button 'Create Company value'
      expect(page).to have_content('Company value was successfully created.')
    end

    it 'does not allow to create CompanyValue with the same title' do
        click_link "New Company Value"
        within('form') do
          fill_in 'Title', with: company_value.title
        end
        click_button 'Create Company value'
        expect(page).to have_content('Title has already been taken')
      end
  end

  context 'when I edit CompanyValue' do
    before do
      sign_in admin_user
      visit '/admin/company_values'
    end

    it 'allows to update the title' do
      click_link "Edit"
      within('form') do
        fill_in 'Title', with: 'Edited CompanyValue'
      end
      click_button 'Update Company value'
      expect(page).to have_content('Company value was successfully updated.')
    end
  end

  context 'when I delete Company Value' do
    before do
      sign_in admin_user
      visit '/admin/company_values'
    end

    it 'allows to delete the CompanyValue' do
      expect { click_link 'Delete' }.to change(CompanyValue, :count).by(-1)
      expect(page).to have_content('Company value was successfully destroyed.')
    end
  end
end
