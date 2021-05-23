require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.feature 'Users', type: :feature do
  context 'create new user' do
    scenario 'Should be successful' do
      visit new_user_registration_path
      within('form') do
        fill_in 'Name', with: 'capybara1'
        fill_in 'Email', with: 'capybara@test.com'
        fill_in 'Password', with: '12345678'
        fill_in 'Password confirmation', with: '12345678'
      end
      click_button 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
    scenario 'Should not be successful' do
      visit new_user_registration_path
      within('form') do
        fill_in 'Email', with: 'capybara@test.com'
        fill_in 'Password', with: '12345678'
        fill_in 'Password confirmation', with: '12345678'
      end
      click_button 'Sign up'
      expect(page).to have_content("Name can't be blank")
    end
  end

  context 'log in and log out as existing user' do
    scenario 'Should be successsful' do
      create(:user, email: 'login@test.com')
      visit user_session_path
      within('form') do
        fill_in 'Email', with: 'login@test.com'
        fill_in 'Password', with: '12345678'
      end
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
    end
    scenario 'Should not be successsful' do
      visit user_session_path
      within('form') do
        fill_in 'Email', with: 'loginbad test'
        fill_in 'Password', with: '12345678'
      end
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end

# rubocop:enable Metrics/BlockLength
