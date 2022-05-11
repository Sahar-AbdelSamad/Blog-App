require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'Show' do
    before(:all) do
      Comment.destroy_all
      Like.destroy_all
      Post.destroy_all
      User.destroy_all
      @u1 = User.create(id: 1234, name: 'user1', bio: 'This is the bio for user1',
        photo: 'https://cdn.eso.org/images/thumb700x/eso0907a.jpg',
        password: '123123', email: 'u@u', posts_counter: 0, confirmed_at: Time.now)
@u2 = User.create(id: 1235, name: 'user2', bio: 'This is the bio for user2',
        photo: 'https://cdn.eso.org/images/thumb700x/eso0907a.jpg',
        password: '123123', email: 'u@i', posts_counter: 0, confirmed_at: Time.now)

@p1 = Post.create(id: 901, title: 'post1', comments_counter: 0, likes_counter: 0, text: 'a generation lost in space', author_id: 1234)
@p2 = Post.create(id: 902, title: 'post2', comments_counter: 0, likes_counter: 0, text: 'no angel born in hell', author_id: 1234)
@p3 = Post.create(id: 903, title: 'post3', comments_counter: 0, likes_counter: 0, text: 'the day the music died', author_id: 1234)
@p4 = Post.create(id: 904, title: 'post4', comments_counter: 0, likes_counter: 0, text: 'bye, bye, miss american pie', author_id: 1234)

      @c1 = @p4.comments.create(text: 'comment1', author_id: 1234)
      @c2 = @p4.comments.create(text: 'comment2', author_id: 1235)

      @like = @p4.likes.create(author_id: 1234)
    end

    before(:each) do
      visit new_user_session_path
      fill_in 'Email', with: 'u@u'
      fill_in 'Password', with: '123123'
      click_button 'Login'
      click_on 'user1'
      click_on 'post4'
    end

    it 'I can see the post\'s title.' do
      expect(page).to have_content('post4')
    end

    it 'I can see who wrote the post.' do
      expect(page).to have_content('user1')
    end

    it 'I can see how many comments it has.' do
      expect(page).to have_content('Comments: 2')
    end

    it 'I can see how many likes it has.' do
      expect(page).to have_content('Likes: 1')
    end

    it 'I can see the post body.' do
      expect(page).to have_content('bye, bye, miss american pie')
    end

    it 'I can see the username of each commentor.' do
      expect(page).to have_content('user1: ')
    end

    it 'I can see the comment each commentor left.' do
      expect(page).to have_content('comment2')
    end
  end
end
