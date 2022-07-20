class UserNotifierMailer < ApplicationMailer
  default :from => 'hello@mydomain.com'

#   send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @users = user
    mail( :to => @users.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end
end
