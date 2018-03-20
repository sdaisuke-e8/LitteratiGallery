class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: '登録が完了しました'
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @favorite_posts = current_user.favorite_posts
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
