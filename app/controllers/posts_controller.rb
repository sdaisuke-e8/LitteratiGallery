class PostsController < ApplicationController
  before_action :authenticate_user, {only: [:create, :index, :show, :edit, :update, :destory]}

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
    @favorites = Favorite.all

    from = Time.now.at_beginning_of_day
    to = (from + 6.day).at_end_of_day
    latest_posts = Post.where(created_at: from...to)
    @popular_posts = latest_posts.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
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
