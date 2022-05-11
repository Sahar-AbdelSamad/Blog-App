require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'Index' do
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
      
      @c1 = Comment.create(id: 1001, text: 'be nimble, be quick', author_id: 1235, post_id: 901)
      @c2 = Comment.create(id: 1002, text: 'fire is the devils only friend', author_id: 1234, post_id: 901)
      @c3 = Comment.create(id: 1003, text: 'i can still remember how that music used to make me smil', author_id: 1235, post_id: 901)
      @c4 = Comment.create(id: 1004, text: 'they be happy for a while', author_id: 1235, post_id: 901)
      @c5 = Comment.create(id: 1005, text: 'with every paper i delivered', author_id: 1234, post_id: 901)
      @c6 = Comment.create(id: 1006, text: 'drove my chevy to the levy', author_id: 1234, post_id: 901)

      @l1 = Like.create(id: 201, author_id: 1234, post_id: 901)
      @l2 = Like.create(id: 202, author_id: 1235, post_id: 901)
    end
    before(:each) do
      visit new_user_session_path
      fill_in 'Email', with: 'u@u'
      fill_in 'Password', with: '123123'
      click_button 'Login'
      click_link 'user1'
      click_link 'See all posts'
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

    it 'I can see a post\'s title.' do
      expect(page).to have_content('post3')
    end

    it 'I can see some of the post\'s body.' do
      expect(page).to have_content('the day the music died')
    end

    it 'I can see the first comments on a post.' do
      expect(page).to have_css('.comments > p', count: 5)
    end

    it 'I can see how many comments a post has.' do
      expect(page).to have_content('Comments: 6')
    end

    it 'I can see how many likes a post has.' do
      expect(page).to have_content('Likes: 2')
    end

    it 'I can see a section for pagination if there are more posts than fit on the view.' do
      expect(page).to have_content('Pagination')
    end

    it 'When I click on a post, it redirects me to that post\'s show page.' do
      click_on 'post1'
      expect(page.current_path).to eq('/users/1234/posts/901')
    end
  end
end
