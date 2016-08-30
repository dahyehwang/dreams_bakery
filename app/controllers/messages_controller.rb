class MessagesController < ApplicationController
  before_action :require_login, only: [:index, :create_post, :create_comment, :show, :destroy]
  before_action :require_correct_user, only: [:destroy]

##################################################
  def index
	## root route (AKA "/") displays the message board main page
		## fetch all groups and put into @groups
  end


##################################################
  def show
	## This shows a particular post. ":message_id" should only be post. Show not enabled for comments.
  ## params[:meesage_id] should be available to it

  end


##################################################
  def create_post
	## This creates a new post (message with no parent)
  end


##################################################
  def create_comment
	## This creates a new comment (message with parent. Parent can be post or comment)
	## params[:parent_id] should be available to it
  end


##################################################
  def destroy
	## This deletes a particular message. Only the owner of message may delete.
  end


##################################################

end
