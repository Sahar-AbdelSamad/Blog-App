class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params.require(:comment).permit(:text))
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]
    @comment.save
    redirect_to user_post_url(current_user, @comment.post_id)
  end
end
