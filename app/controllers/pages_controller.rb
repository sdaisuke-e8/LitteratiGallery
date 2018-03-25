class PagesController < ApplicationController
  before_action :forbid_login_user, {only: [:top]}

  def home
  end

  def about
  end
end
