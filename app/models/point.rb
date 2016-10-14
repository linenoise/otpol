class Point < ActiveRecord::Base
  belongs_to :user
  acts_as_votable 

  validates :description, length: { in: 64..512 }
  validates :description, format: { with: /\A[Tt]he/,
    								message: "should begin with the word \"The\"" }
  validates :description, format: { with: /[^\.\,\?\!\:\;]\z/,
    								message: "should end without a punctuation mark" }
  validates :moment, length:      { minimum: 4 }
  validates :location, length:    { minimum: 2 }

  scope :timeline, -> { 
  	order("created_at DESC")
  }

  scope :recent, -> { 
  	where("created_at" => 3.days.ago..0.days.ago)
  }

end
