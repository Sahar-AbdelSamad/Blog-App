class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @like = current_user.likes.new
    @like.post_id = params[:post_id]
    @like.save
    redirect_to user_post_path(@like.author_id, @like.post_id)
  end
end
