# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.sendgrid.net",
  :domain               => onlinevotingsystem.net,
  :user_name            => ENV['app42949118@heroku.com'],
  :password             => ENV['6xtdktpt6235'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}
ActionMailer::Base.default_url_options = { host: 'onlinevotingsystem.net' }
