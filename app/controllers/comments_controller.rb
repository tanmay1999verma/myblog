class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @blog = Article.find(params[:article_id])
    @comment = @blog.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save!
    redirect_to article_path(@blog)
  end

  def destroy
    @blog = Article.find(params[:article_id])
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@blog), status: 303
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
