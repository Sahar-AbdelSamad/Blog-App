require 'rails_helper'

RSpec.describe 'Session', type: :system do
  describe 'New' do
    before(:each) do
      User.create(name: 'user1', password: '123123', email: 'u@u', confirmed_at: Time.now)
      visit new_user_session_path
    end

    it 'I can see the username and password inputs and the submit button' do
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      expect(page).to have_button('Login')
    end

    it 'Should redirect to the root page if click the submit after filling in email and password with correct data' do
      fill_in 'Email', with: 'u@u'
      fill_in 'Password', with: '123123'
      click_button 'Login'
      expect(page.current_path).to eq('/')
    end

    it 'When I click the submit button without filling in the username and the password, I get a detailed error.' do
      click_button 'Login'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'Should get a detailed error if click the submit after filling the emails and pass with incorrect data' do
      fill_in 'Email', with: 'a@z'
      fill_in 'Password', with: '321432'
      click_button 'Login'
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
