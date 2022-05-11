require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'Index' do
    before(:each) do
      User.create(id: 1234, name: 'user1', bio: 'This is the bio for user1',
                  photo: 'https://cdn.eso.org/images/thumb700x/eso0907a.jpg',
                  password: '123123', email: 'u@u', posts_counter: 5, confirmed_at: Time.now)
      User.create(id: 1235, name: 'user2', bio: 'This is the bio for user2',
                  photo: 'https://cdn.eso.org/images/thumb700x/eso0907a.jpg',
                  password: '123123', email: 'u@i', posts_counter: 5, confirmed_at: Time.now)
      visit new_user_session_path
      fill_in 'Email', with: 'u@u'
      fill_in 'Password', with: '123123'
      click_button 'Login'
    end

    it 'I can see the username of all other users' do
      expect(page).to have_content('user1')
      expect(page).to have_content('user2')
    end

    it 'I can see the profile picture for each user' do
      expect(page).to have_selector('img', count: 2)
    end

    it 'I can see the number of posts each user has written' do
      expect(page).to have_content('Number of posts: 5')
    end

    it "When I click on a user, I am redirected to that user's show page" do
      click_link 'user1'
      expect(page.current_path).to have_content('/users/1234')
    end
  end
end
