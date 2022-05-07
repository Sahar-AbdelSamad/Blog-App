require 'rails_helper'

RSpec.describe Like, type: :model do
  like = Like.new
  before(:each) { like.save }

  context '#update_likes_counter' do
    it 'should be private' do
      expect { like.update_likes_counter }.to raise_error(NoMethodError)
    end
  end
end
