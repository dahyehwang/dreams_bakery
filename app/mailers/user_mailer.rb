class UserMailer < ActionMailer::Base
  default from: "dreams.bakery.online@gmail.com"

  def welcome_email(user)
  	@user = user
  	@url = "http://52.43.79.159"
  	mail(to: @user.email, subject: 'Welcome to Dreams Bakery!')
  end
  def reply_email(user, parent)
    @parent = parent
  	@user = user
  	@url = "http://52.43.79.159/messages/#{ @parent.id }"
  	mail(to: @user.email, subject: 'Someone has sent you a reply')
  end
end
