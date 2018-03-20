class CommentsController < ApplicationController
  def new
      @comment = Comment.new
    end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = @current_user.id
    @comment.post_id = params[:post_id]
    @comment.save
    redirect_to posts_path
  end

  private
  def comment_params
    params.require(:comment).permit(:post_id, :comment)
  end
end
