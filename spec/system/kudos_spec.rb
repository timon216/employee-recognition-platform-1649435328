require 'rails_helper'

RSpec.describe 'Kudos', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:giver) { create(:employee) }
  let!(:receiver) { create(:employee) }
  let!(:company_value) { create(:company_value) }
  let!(:company_value2) { create(:company_value, title: 'Second Company Value') }
  let!(:kudo) { create(:kudo, giver: giver, receiver: receiver, company_value: company_value) }

  context 'when I create the kudo' do
    before do
      sign_in giver
      visit kudos_path
      click_link 'New Kudo'
      select receiver.email
      select company_value.title
    end

    it 'allows to create a kudo with title, content, receiver, and company value' do
      within('form') do
        fill_in 'Title', with: kudo.title
        fill_in 'Content', with: kudo.content
      end
      click_button 'Create Kudo'
      expect(page).to have_content('Kudo was successfully created.')
    end

    it 'does not allow to create a kudo without title' do
      within('form') do
        fill_in 'Title', with: ''
        fill_in 'Content', with: kudo.content
      end
      click_button 'Create Kudo'
      expect(page).to have_content('Title can\'t be blank')
    end

    it 'does not allow to create a kudo without content' do
      within('form') do
        fill_in 'Title', with: kudo.title
        fill_in 'Content', with: ''
      end
      click_button 'Create Kudo'
      expect(page).to have_content('Content can\'t be blank')
    end
  end

  context 'when I edit the kudo' do
    before do
      sign_in giver
      visit kudos_path
      click_link 'Edit'
    end

    it 'allows to edit kudo\'s title and content' do
      within('form') do
        fill_in 'Title', with: 'New title'
        fill_in 'Content', with: 'New content'
      end
      click_button 'Update Kudo'
      expect(page).to have_content('Kudo was successfully updated.')
    end

    it 'allows to edit kudo\'s company value' do
      select company_value2.title
      click_button 'Update Kudo'
      expect(page).to have_content('Kudo was successfully updated.')
    end

    it 'does not allow to update kudo without title' do
      within('form') do
        fill_in 'Title', with: ''
        fill_in 'Content', with: 'New content'
      end
      click_button 'Update Kudo'
      expect(page).to have_content('Title can\'t be blank')
    end

    it 'does not allow to update kudo without content' do
      within('form') do
        fill_in 'Title', with: 'New kudo'
        fill_in 'Content', with: ''
      end
      click_button 'Update Kudo'
      expect(page).to have_content('Content can\'t be blank')
    end
  end

  context 'when I delete the kudo' do
    it 'allows to delete the kudo' do
      sign_in giver
      visit kudos_path

      expect { click_link 'Delete' }.to change(Kudo, :count).by(-1)
      expect(page).to have_content('Kudo was successfully destroyed.')
    end
  end
end
