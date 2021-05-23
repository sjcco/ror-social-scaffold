require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.feature 'Friendships', type: :feature do
  context 'Add friends' do
    scenario 'send friend request button is displayed' do
      u1 = create(:user, email: 'friend1@test.com', name: 'friend1')
      u2 = create(:user, email: 'friend2@test.com', name: 'friend2')
      visit user_session_path
      within('form') do
        fill_in 'Email', with: u1.email
        fill_in 'Password', with: u1.password
      end
      click_button 'Log in'
      visit user_path(u2)

      expect(find_button('Send request').class).to be(Capybara::Node::Element)
    end

    scenario 'cancel request button is displayed' do
      u1 = create(:user, email: 'friend1@test.com', name: 'friend1')
      u2 = create(:user, email: 'friend2@test.com', name: 'friend2')
      create(:friendship, user_id: u1.id, friend_id: u2.id)
      visit user_session_path
      within('form') do
        fill_in 'Email', with: u1.email
        fill_in 'Password', with: u1.password
      end
      click_button 'Log in'
      visit user_path(u2)

      expect(find_button('cancel request').class).to be(Capybara::Node::Element)
    end

    scenario 'Accept button is displayed' do
      u1 = create(:user, email: 'friend1@test.com', name: 'friend1')
      u2 = create(:user, email: 'friend2@test.com', name: 'friend2')
      create(:friendship, user_id: u2.id, friend_id: u1.id)
      visit user_session_path
      within('form') do
        fill_in 'Email', with: u1.email
        fill_in 'Password', with: u1.password
      end
      click_button 'Log in'
      visit user_path(u2)

      expect(find_button('Accept').class).to be(Capybara::Node::Element)
    end

    scenario 'Unfriend button is displayed' do
      u1 = create(:user, email: 'friend1@test.com', name: 'friend1')
      u2 = create(:user, email: 'friend2@test.com', name: 'friend2')
      create(:friendship, user_id: u2.id, friend_id: u1.id, confirmed: true)
      create(:friendship, user_id: u1.id, friend_id: u2.id, confirmed: true)
      visit user_session_path
      within('form') do
        fill_in 'Email', with: u1.email
        fill_in 'Password', with: u1.password
      end
      click_button 'Log in'
      visit user_path(u2)

      expect(find_button('unfriend').class).to be(Capybara::Node::Element)
    end
  end
end

# rubocop:enable Metrics/BlockLength
