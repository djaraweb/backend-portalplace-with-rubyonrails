class UserMailer < ApplicationMailer
	default from: 'notifications@portalplace.com'
 
  def notifications_email(user)
    @user = user
    @url  = 'http://portalplace.com'
    #mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    mail(to: 'djaravirtual@gmail.com', subject: 'Welcome to My Awesome Site')
  end
end
