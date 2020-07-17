# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def notyify
  	UserMailer.notifications_email User.new(name: 'Sample User', email: 'sample@email.com')
  end
end
