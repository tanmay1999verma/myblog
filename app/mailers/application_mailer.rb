class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
   # @smtp_settings = Rails.application.secrets[:smtp][server]
end
