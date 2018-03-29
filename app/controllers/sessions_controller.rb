class SessionsController < ApplicationController
  before_action :authenticate_user, {only: [:destroy]}
  before_action :forbid_login_user, {only: [:new, :create]}

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:notice] = 'ログインしました'
      redirect_to posts_path
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render :new
    end
  end

  def destroy
    log_out
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end

  def twitter_create
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    log_in user
    flash[:notice] = 'ログインしました'
    redirect_to posts_path
  end

  private
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
