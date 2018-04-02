class UsersController < ApplicationController
  before_action :authenticate_user!, {only: [:show]}

  def show
    @user = User.find_by(id: params[:id])
    @user_posts = @user.posts
  end

end
