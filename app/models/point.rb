class Point < ActiveRecord::Base
  belongs_to :user
  acts_as_votable 

  allowed_first_words = /\A([Tt]he|[Aa]|[Aa]n|[Tt]his|[Tt]hat|[Tt]hese|[Tt]hose)\s+/
  allowed_final_characters = /[^\.\,\;\:\?\!]\s*\z/

  validates :moment, length:      { minimum: 4  }
  validates :location, length:    { minimum: 2  }
  validates :description, length: { in: 64..512 }
  validates :description, format: { with: allowed_first_words,
    								message: "should begin with the word \"a\", \"an\", \"the\", " +
                             "\"this\", \"that\", \"these\", or \"those\"." }
  validates :description, format: { with: allowed_final_characters,
    								message: "should not end with a punctuation mark" }

  scope :timeline, -> { 
  	order("created_at DESC")
  }

  scope :recent, -> { 
  	timeline.first(7)
  }

  def title
    self.moment.to_s + '; ' + self.location.to_s
  end
end
