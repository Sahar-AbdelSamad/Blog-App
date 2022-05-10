class UsersController < ApplicationController
  def index
    @user = User.all
    @current = current_user
  end

  def show
    @user = User.find(params[:id])
    @post = @user.most_recent_posts
  end
end
