require 'rails_helper'

RSpec.describe 'Kudos', type: :system do
  let(:giver) { create(:employee) }
  let!(:receiver) { create(:employee) }
  let!(:company_value) { create(:company_value) }
  let!(:company_value2) { create(:company_value, title: 'Second Company Value') }

  context 'when Employee creates the Kudo' do
    before do
      sign_in giver
      visit kudos_path
      click_link 'New Kudo'
      select receiver.email
      select company_value.title
    end

    it 'allows to create a Kudo and increases number of receiver\'s earned points' do
      within('form') do
        fill_in 'Title', with: 'Nice kudo title'
        fill_in 'Content', with: 'Nice kudo content'
      end
      click_button 'Create Kudo'
      expect(page).to have_content('Kudo was successfully created.')
      expect(receiver.earned_points).to eq(1)
    end
  end

  context 'when Employee edits the Kudo' do
    before do
      create(:kudo, giver: giver, receiver: receiver, company_value: company_value)
      sign_in giver
      visit kudos_path
      click_link 'Edit'
    end

    it 'allows to edit Kudo\'s title and content' do
      within('form') do
        fill_in 'Title', with: 'New title'
        fill_in 'Content', with: 'New content'
      end
      click_button 'Update Kudo'
      expect(page).to have_content('Kudo was successfully updated.')
    end

    it 'allows to edit Kudo\'s company value' do
      select company_value2.title
      click_button 'Update Kudo'
      expect(page).to have_content('Kudo was successfully updated.')
    end
  end

  context 'when Employee deletes the Kudo' do
    it 'allows to delete the Kudo and decreases number of receiver\'s earned points' do
      create(:kudo, giver: giver, receiver: receiver, company_value: company_value)
      sign_in giver
      visit kudos_path

      expect { click_link 'Delete' }.to change(Kudo, :count).by(-1)
      expect(page).to have_content('Kudo was successfully destroyed.')
      expect(receiver.earned_points).to eq(0)
    end
  end
end
