class SessionsController < ApplicationController
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

  private
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
