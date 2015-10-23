class Lecturer < ActiveRecord::Base
	has_many :subjects
	has_many :polls
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
