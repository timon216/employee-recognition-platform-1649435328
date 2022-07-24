require 'rails_helper'

RSpec.describe 'Admin - CRUD actions for Company Value', type: :system do
  let(:admin) { create(:admin) }
  let!(:company_value) { create(:company_value) }

  context 'when Admin lists all Company Values' do
    it 'shows all Company Values' do
      sign_in admin
      visit '/admins/pages/dashboard'
      click_link 'Company Values'
      expect(page).to have_content company_value.title
      expect(page).to have_content company_value.created_at
      expect(page).to have_content company_value.updated_at
    end

    it 'does not show Company Values without Admin logging in' do
      visit '/admins/company_values'
      expect(page).to have_current_path '/admin/sign_in'
    end
  end

  context 'when Admin creates Company Value' do
    before do
      sign_in admin
      visit '/admins/company_values'
    end

    it 'allows to create new Company Value' do
      click_link 'New Company Value'
      within('form') do
        fill_in 'Title', with: 'New Company Value'
      end
      click_button 'Create Company value'
      expect(page).to have_content('Company value was successfully created.')
    end

    it 'does not allow to create Company Value with the same title' do
      click_link 'New Company Value'
      within('form') do
        fill_in 'Title', with: company_value.title
      end
      click_button 'Create Company value'
      expect(page).to have_content('Title has already been taken')
    end
  end

  context 'when Admin edits the Company Value' do
    before do
      sign_in admin
      visit '/admins/company_values'
    end

    it 'allows to update the title' do
      click_link 'Edit'
      within('form') do
        fill_in 'Title', with: 'Edited CompanyValue'
      end
      click_button 'Update Company value'
      expect(page).to have_content('Company value was successfully updated.')
    end
  end

  context 'when Admin deletes Company Value' do
    before do
      sign_in admin
      visit '/admins/company_values'
    end

    it 'allows to delete the Company Value' do
      expect { click_link 'Delete' }.to change(CompanyValue, :count).by(-1)
      expect(page).to have_content('Company value was successfully destroyed.')
    end
  end
end
