class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @like = Like.new
    @like.author_id = current_user.id
    @like.post_id = params[:post_id]
    @like.save
    redirect_to user_post_path(current_user, @like.post_id)
  end
end
