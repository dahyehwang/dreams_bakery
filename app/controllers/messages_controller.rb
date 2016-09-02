class MessagesController < ApplicationController
  before_action :require_login, only: [:index, :create_post, :create_comment, :show, :destroy]
  # before_action :require_correct_user, only: [:destroy]


  # respond_to :html, :js
##################################################
  def index
	## root route (AKA "/") displays the message board main page
		## fetch all posts and put into @posts
		@posts = Message.where("parent_id is NULL").order("created_at DESC")

				
		@array_of_comments
		@comment_count_array = @posts.map { |post|
			@array_of_comments = []
			get_all_comments @array_of_comments, post.comments
			@array_of_comments.length
		}



  end

##################################################
  def sort
  	if params[:option] == "dropdown-recents"
			@posts = Message.where("parent_id is NULL").order("created_at DESC")
		elsif params[:option] == "dropdown-likesDESC"
			@posts = Message.select("messages.content, messages.parent_id, messages.user_id, messages.id, messages.created_at,count(likes.id) AS likes_count").joins("LEFT JOIN likes ON messages.id = likes.message_id").where("parent_id is NULL").group("messages.id").order("likes_count DESC")
		elsif params[:option] == "dropdown-oldest"
			@posts = Message.where("parent_id is NULL").order("created_at ASC")
		elsif params[:option] == "dropdown-likesASC"
			@posts = Message.select("messages.content, messages.parent_id, messages.user_id, messages.id, messages.created_at, count(likes.id) AS likes_count").joins("LEFT JOIN likes ON messages.id = likes.message_id").where("parent_id is NULL").group("messages.id").order("likes_count ASC")
		else params[:option] == ""
			@posts = Message.where("parent_id is NULL").order("created_at DESC")
		end
		@array_of_comments
		@comment_count_array = @posts.map { |post|
			@array_of_comments = []
			get_all_comments @array_of_comments, post.comments
			puts @array_of_comments.length
			@array_of_comments.length
		}
		puts "\n\n\n\n\n"
		print @comment_count_array

		@likes_count_array = @posts.map { |post|
			puts post.likes.count
			post.likes.count
		}
		puts "\n\n\n\n\n"
		print @likes_count_array
		
		render json: {posts: @posts, comments: @comment_count_array, likes: @likes_count_array}

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
		
		if @post.valid?
      redirect_to "/", notice: "You have successfully created a dream!"
    else
      redirect_to :back, alert: @post.errors.full_messages
    end
  end


##################################################
  def create_comment
	## This creates a new comment (message with parent. Parent can be post or comment)
	## params[:parent_id] should be available to it
		@comment = Message.create(content: params[:content], user: current_user, parent_id: params[:parent_id])
		if @comment.valid?
			UserMailer.reply_email(@comment.parent.user, @comment.parent).deliver
      redirect_to "/messages/#{ params[:post_id] }", notice: "You have successfully created a comment!"
    else
      redirect_to "/messages/#{ params[:post_id] }", alert: @comment.errors.full_messages
    end
		
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
				flash[:alert] = ["Could not delete post!"]
			end
		else
			flash[:alert] = ["Cannot delete someone else's post!"]
		end
		redirect_to "/users/#{current_user.id}"
  end
##################################################
  def destroy_comment
  ## This deletes a particular message. Only the owner of message may delete.
    @message = Message.find(params[:message_id])
    if @message.user == current_user
      @message = Message.find(params[:message_id]).destroy
      if @message
        flash[:notice] = "You have successfully deleted your comment!"
      else
        flash[:alert] = ["Could not delete comment!"]
      end
    else
      flash[:alert] = ["Cannot delete someone else's comment!"]
    end
    redirect_to "/messages/#{params[:post_id]}"
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
