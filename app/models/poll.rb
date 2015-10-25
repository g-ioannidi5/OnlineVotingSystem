class Poll < ActiveRecord::Base
  belongs_to :history
  belongs_to :lecturer
  belongs_to :subject
  has_many :questions
  has_one :history
end