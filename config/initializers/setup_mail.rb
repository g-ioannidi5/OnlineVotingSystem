ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.smtp_settings = {
  :address        => "smtp.sendgrid.net",
  :port           => "25",
  :authentication => :plain,
  :user_name      => ENV['app42949118@heroku.com'],
  :password       => ENV['6xtdktpt6235'],
  :domain         => ENV['heroku.com']
}










