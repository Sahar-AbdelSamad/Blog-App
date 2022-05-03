class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  after_save :update_likes_counter

  private

  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
