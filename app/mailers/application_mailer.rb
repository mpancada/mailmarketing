class ApplicationMailer < ActionMailer::Base
  default from: ENV["rails_app_MAILER_DEFAULT_FROM"]
  layout "mailer"
end
