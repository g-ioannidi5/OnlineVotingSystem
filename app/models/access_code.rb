class AccessCode < ActiveRecord::Base
  belongs_to :lecturer 
  belongs_to :subject
end