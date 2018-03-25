class PostsController < ApplicationController
  before_action :authenticate_user, {only: [:create, :index, :show, :edit, :update, :destory]}

  def indextest
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
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
    @comments = Comment.where(post_id: params[:id])
    @favorites_count = Favorite.where(post_id: @post.id).count
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.description = params[:post][:description]
    if @post.save
      redirect_to posts_path, notice: '投稿を編集しました'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:image, :description)
  end

end
