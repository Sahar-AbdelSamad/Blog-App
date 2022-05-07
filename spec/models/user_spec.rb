require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'Tom', bio: 'Teacher from Mexico', posts_counter: 0, photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1')

  before(:each) { user.save }

  context '#name' do
    it 'name should be present' do
      user.name = nil
      expect(user).to_not be_valid
    end
  end

  context '#post_counter' do
    it 'post_counter should be present' do
      user.posts_counter = nil
      expect(user).to_not be_valid
    end

    it 'post_counter should be an integer' do
      user.posts_counter = 'a'
      expect(user).to_not be_valid
    end
  end

  it 'post_counter should be bigger or equal to zero' do
    user.posts_counter = -1
    expect(user).to_not be_valid
  end

  context '#most_recent_posts' do
    before(:each) do
      5.times do |i|
        Post.new(title: "Post #{i}", text: "text#{i}", comments_counter: 0, likes_counter: 0, author_id: user.id)
      end
    end

    it 'should return the 3 latest posts' do
      expect(user.most_recent_posts).to eq(Post.order(created_at: :desc).limit(3))
    end
  end
end