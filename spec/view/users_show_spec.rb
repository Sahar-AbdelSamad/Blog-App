require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'Show' do
    before(:all) do
      Post.destroy_all
      User.destroy_all
      @u1 = User.create(id: 123, name: 'user1', bio: 'This is the bio for user1',
                        photo: 'https://cdn.eso.org/images/thumb700x/eso0907a.jpg',
                        password: '123123', email: 'u@u', confirmed_at: Time.now)
      @u2 = User.create(id: 1234, name: 'user2', bio: 'This is the bio for user2',
                        photo: 'https://cdn.eso.org/images/thumb700x/eso0907a.jpg',
                        password: '123123', email: 'u@i', confirmed_at: Time.now)

      @p1 = Post.create(id: 1, title: 'post1', comments_counter: 0, likes_counter: 0, author_id: @u1.id, text: 'a generation lost in space')
      @p2 = Post.create(id: 2, title: 'post2', comments_counter: 0, likes_counter: 0, author_id: @u1.id, text: 'no angel born in hell')
      @p3 = Post.create(id: 3, title: 'post3', comments_counter: 0, likes_counter: 0, author_id: @u1.id, text: 'the day the music died')
      @p4 = Post.create(id: 4, title: 'post4', comments_counter: 0, likes_counter: 0, author_id: @u1.id, text: 'bye, bye, miss american pie')
    end
    before(:each) do
      visit new_user_session_path
      fill_in 'Email', with: 'u@u'
      fill_in 'Password', with: '123123'
      click_button 'Login'
      click_on 'user1'
    end

    it 'I can see the user\'s profile picture.' do
      expect(page).to have_selector('img')
    end

    it 'I can see the user\'s username.' do
      expect(page).to have_content('user1')
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content('Number of posts: 4')
    end

    it 'I can see the user\'s bio.' do
      expect(page).to have_content('This is the bio for user1')
    end

    it 'I can see the user\'s first 3 posts.' do
      expect(page).to have_css('.posts', count: 3)
    end

    it 'I can see a button that lets me view all of a user\'s posts.' do
      expect(page).to have_content('See all posts')
    end

    it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
      click_on 'post4'
      expect(page.current_path).to eq('/users/123/posts/4')
    end

    it 'When I click to see all posts, it redirects me to the user\'s post\'s index page.' do
      click_link 'See all posts'
      expect(page.current_path).to eq('/users/123/posts')
    end
  end
end
