class LikesController < ApplicationController
	def create
    unless current_user.likes.where(message: Message.find(params[:message_id])).first
      current_user.likes.create(message: Message.find(params[:message_id]))
      redirect_to "/messages/#{ params[:post_id] }"
    else
      redirect_to "/messages/#{ params[:post_id] }"
    end
  end
  def destroy
    if current_user.likes.where(message: Message.find(params[:message_id])).first
      current_user.likes.where(message: Message.find(params[:message_id])).first.destroy
      redirect_to "/messages/#{ params[:post_id] }"
    else
      redirect_to "/messages/#{ params[:post_id] }"
    end
  end
end