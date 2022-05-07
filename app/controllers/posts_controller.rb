class PostsController < ApplicationController
  def index
    @user = User.includes(:posts, posts: [:comments, { comments: [:author] }]).find(params[:user_id])
    @post = Post.where(author_id: @user.id).order(created_at: :desc)
  end

  def show
    @post = Post.includes(:comments, comments: [:author]).find(params[:id])
    @comment = Comment.where(post_id: @post.id).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path(@post.author_id), notice: 'Post was successfully created.' }
      else
        flash[:error] = 'Failed to create post'
        format.html { redirect_to new_user_post_path }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
