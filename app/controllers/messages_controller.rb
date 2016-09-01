class MessagesController < ApplicationController
  before_action :require_login, only: [:index, :create_post, :create_comment, :show, :destroy]
  # before_action :require_correct_user, only: [:destroy]

##################################################
  def index
	## root route (AKA "/") displays the message board main page
		## fetch all posts and put into @posts
		@posts = Message.where("parent_id is NULL")
		@array_of_comments
		@comment_count_array = @posts.map { |post|
			@array_of_comments = []
			get_all_comments @array_of_comments, post.comments
			@array_of_comments.length
		}

  end


##################################################
  def show
	## This shows a particular post. ":message_id" should only be post. Show not enabled for comments.
  ## params[:message_id] should be available to it
  	@post = Message.find_by_id(params[:message_id])
  	if @post
	  	if @post.parent_id == nil
		  	@array_of_comments = []
		  	if @post.comments
		  		get_all_comments @array_of_comments, @post.comments
		  	end
		  else
		  	redirect_to "/"
		  end
		else
			redirect_to "/"
		end
  end


##################################################
  def create_post
	## This creates a new post (message with no parent)
		@post = Message.create(content: params[:content], user: current_user)
		redirect_to "/"
  end


##################################################
  def create_comment
	## This creates a new comment (message with parent. Parent can be post or comment)
	## params[:parent_id] should be available to it
		@comment = Message.create(content: params[:content], user: current_user, parent_id: params[:parent_id])
		UserMailer.reply_email(@comment.parent.user).deliver
		redirect_to "/messages/#{ params[:post_id] }"
  end


##################################################
  def destroy
	## This deletes a particular message. Only the owner of message may delete.
		@message = Message.find(params[:message_id])
		if @message.user == current_user
			@message = Message.find(params[:message_id]).destroy
			if @message
				flash[:notice] = "You have successfully deleted your post!"
			else
				flash[:alert] = "Could not delete post!"
			end
		else
			flash[:alert] = "Cannot delete someone else's post!"
		end
		redirect_to "/users/#{current_user.id}"
  end


##################################################
private
	def get_all_comments flattened_comments, commentList ## this is post.comments on the first run
		commentList.each do |comment|
			flattened_comments << comment
			if comment.comments
				get_all_comments(flattened_comments, comment.comments)
			end
		end
	end

end
