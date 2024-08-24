class CustomDeviseMailer < Devise::Mailer
  layout "mailer"
  include Devise::Controllers::UrlHelpers
  default template_path: "users/mailer"
  default from: "XPTO<#{ENV["rails_app_MAILER_DEFAULT_FROM"]}>"
end
