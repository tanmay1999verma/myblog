class UserNotifierMailer < ApplicationMailer
  default :from => 'vermatanmay1999@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email()

    mail( :to => current_user,
    :subject => 'Thanks for signing up for our amazing app' )
  end
end

