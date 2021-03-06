class FavoritesController < ApplicationController
  before_action :authenticate_user!, {only: [:create, :destroy]}

  def create
    @favorite = Favorite.new
    @favorite.user_id = current_user.id
    @favorite.post_id = params[:post_id]
    @favorite.save
    redirect_to post_path(params[:post_id])
  end

  def destroy
    @favorite = Favorite.find_by(
      user_id: current_user.id,
      post_id: params[:post_id]
    )
    @favorite.destroy
    redirect_to post_path(params[:post_id])
  end
end
