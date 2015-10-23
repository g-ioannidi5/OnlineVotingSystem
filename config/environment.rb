# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Rails.application.initialize!

# Configuration for using SendGrid on Heroku
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => "app42949118@heroku.com",
  :password => "6xtdktpt6235",
  :domain => "onlinevotingsystem.herokuapp.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}