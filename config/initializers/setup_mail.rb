ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.smtp_settings = {
  		:address              => "smtp.gmail.com",
  		:port                 => '587',
  		:domain               => 'baci.lindsaar.net',
  		:user_name            => 'gi00013ovs@gmail.com',
  		:password             => 'UniversityPassword1',
  		:authentication       => :plain,
  		:enable_starttls_auto => true  
	}











