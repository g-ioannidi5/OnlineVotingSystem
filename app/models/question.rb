class Question < ActiveRecord::Base
  belongs_to :history
  belongs_to :poll
  belongs_to :lecturer




end
