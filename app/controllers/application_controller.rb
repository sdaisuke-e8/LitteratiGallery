class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def log_in(user)
    user_session[:user_id] = user.id
  end

  def forbid_login_user
    if user_signed_in?
      flash[:notice] = "すでにログインしています"
      redirect_to posts_path
    end
  end

end
