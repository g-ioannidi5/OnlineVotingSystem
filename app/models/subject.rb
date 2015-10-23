class Subject < ActiveRecord::Base
  belongs_to :lecturer
  has_many :access_codes
  has_many :polls
end
