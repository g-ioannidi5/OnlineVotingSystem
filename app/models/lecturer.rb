class Lecturer < ActiveRecord::Base
	has_many :subjects, :dependent => :destroy
	has_many :polls, :dependent => :destroy
	has_many :access_codes, :dependent => :destroy
	
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
