require 'rails_helper'

RSpec.describe Post, type: :model do
  post = Post.new(title: 'Post1', text: 'This is my first post', comments_counter: 0, likes_counter: 0, author_id: 1)

  before(:each) { post.save }

  context '#title' do
    it 'title should be present' do
      post.title = nil
      expect(post).to_not be_valid
    end

    it 'title should not have length>250' do
      post.title = 'a' * 260
      expect(post).to_not be_valid
    end
  end

  context '#comments_counter' do
    it 'comments_counter should be an integer' do
      post.comments_counter = 'a'
      expect(post).to_not be_valid
    end

    it 'comments_counter should be bigger or equal to zero' do
      post.comments_counter = -1
      expect(post).to_not be_valid
    end
  end

  context '#likes_counter' do
    it 'likes_counter should be an integer' do
      post.likes_counter = 'a'
      expect(post).to_not be_valid
    end

    it 'likes_counter should be bigger or equal to zero' do
      post.likes_counter = -1
      expect(post).to_not be_valid
    end
  end

  context '#most_recent_comments' do
    before(:each) do
      6.times do |i|
        Comment.new(text: "Comment #{i}", post_id: post.id)
      end
    end

    it 'should return the 5 latest comments' do
      expect(post.most_recent_comments).to eq(Comment.order(created_at: :desc).limit(5))
    end
  end

  context '#update_post_counter' do
    it 'should be private' do
      expect { post.update_post_counter }.to raise_error(NoMethodError)
    end
  end
end
