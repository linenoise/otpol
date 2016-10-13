class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  acts_as_votable 
end
