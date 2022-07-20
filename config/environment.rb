# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# config.action_mailer.delivery_method = :smtp

# ActionMailer::Base.smtp_settings = {
#   :user_name => 'Mazeblogapikey', # This is the string literal 'apikey', NOT the ID of your API key
#   :password => 'Xzj9KqQxYgnWw2bG', # This is the secret sendgrid API key which was issued during API key creation
#   :domain => 'http://localhost:3000',
#   :address => 'smtp-relay.sendinblue.com',
#   :port => 587,
#   :authentication => :plain,
#   :enable_starttls_auto => true
# }

# config.action_mailer.smtp_settings = {
#   :address        => ENV.fetch('SMTP_HOST', 'smtp-relay.sendinblue.com'),
#   :port           => ENV.fetch('SMTP_PORT', '587'),
#   :authentication => :plain,
#   :user_name      => ENV['Mazeblogapikey'], #See: https://account.sendinblue.com/advanced/api
#   :password       => ENV['Xzj9KqQxYgnWw2bG'], #See: https://account.sendinblue.com/advanced/api
#   :enable_starttls_auto => true
# }