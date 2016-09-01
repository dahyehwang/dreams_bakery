class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :update, :destroy]


  def new
    # renders new.html.erb
  end

  def create
    user = User.create(get_user_info)
    if user.valid?
      session[:user_id] = user.id
      UserMailer.welcome_email(user).deliver
      redirect_to "/", notice: "You have successfully registered!"
    else
      redirect_to :back, alert: user.errors.full_messages
    end
  end

  def show
    @posts = @user.messages.where("parent_id is NULL")
  end
  def update
    user = User.update(@user.id, get_user_info)
    if user.valid?
      redirect_to "/users/#{current_user.id}", notice: "You have successfully updated your profile!"
    else
      redirect_to :back, alert: user.errors.full_messages
    end
  end

  def destroy
    user = @user.destroy
    if user
      session[:user_id] = nil
      redirect_to "/login", notice: "You have successfully deleted the user!"
    else
      redirect_to :back, alert: "Something went wrong while deleting!"
    end
  end
  private
  def set_user
    @user = User.find(params[:id])
    # @user = current_user
  end
  def get_user_info
    # params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    params.require(:user).permit(:first_name, :last_name, :nickname, :email, :password, :password_confirmation)
  end
end
