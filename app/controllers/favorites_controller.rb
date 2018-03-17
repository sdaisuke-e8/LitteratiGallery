class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(
      user_id = current_user.id,
      post_id = params[:post_id]
    )
    @favorite.save
    redirect_to("/posts/#{params[:post_id]}")
  end
end
