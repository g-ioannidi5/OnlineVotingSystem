class Subject < ActiveRecord::Base
  belongs_to :lecturer
  has_many :access_codes, :dependent => :destroy
  has_one :poll, :dependent => :destroy
end
