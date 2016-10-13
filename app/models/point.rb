class Point < ActiveRecord::Base
  belongs_to :user
  acts_as_votable 

  validates :description, length: { in: 1..512 }

  scope :recent, -> { 
  	where("created_at" => 3.days.ago..0.days.ago)
  }

end
