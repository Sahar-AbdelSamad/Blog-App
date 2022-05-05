class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(post_params)
    @comment.post_id = params[:post_id]
    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(@comment.author_id, @comment.post_id) }
      else
        format.html { render :new }
      end
    end
  end

  private

  def post_params
    params.require(:comment).permit(:text)
  end
end
