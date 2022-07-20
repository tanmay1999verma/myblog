class LikesController < ApplicationController
  def create
    @like=current_user.likes.new(like_params)

    if !@like.save
      flash[:notice] = @like.errors.full_message.to_sentence
    end
     redirect_back(fallback_location: root_path)
  end


  def destroy
    @like=current_user.likes.find(params[:id])
    @like.destroy
     redirect_back(fallback_location: root_path)
  end

  private

  def  like_params
    params.permit(:article_id)
    end
end
