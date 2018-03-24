class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:show, :edit, :update, :destroy]}
  before_action :forbid_login_user, {only: [:new, :create]}
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image_name = "default_user.png"
    @user.profile = "はじめまして、#{@user.name}です！"
    if @user.save
      log_in @user
      redirect_to posts_path, notice: '登録が完了しました'
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @favorite_posts = current_user.favorite_posts
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.profile = params[:user][:profile]
    if @user.save
      redirect_to user_path, notice: 'ユーザー情報を編集しました'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to posts_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_name, :profile)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to posts_path
    end
  end
end
