class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if current_user.posts.create(post_params)
      redirect_to posts_path, notice: '投稿に成功しました'
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.includes(:user).find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:image, :description)
  end
end
