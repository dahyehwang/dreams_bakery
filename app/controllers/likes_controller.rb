class LikesController < ApplicationController
	def create
		current_user.likes.create(message: Message.find(params[:message_id]))
	  redirect_to "messages/#{ params[:message_id] }"
  end
  def destroy
  	like = current_user.likes.where(message: Message.find(params[:id]))
  	like.destroy_all
  	redirect_to "messages/#{ params[:message_id] }"
  end
end