class Point < ActiveRecord::Base

  #### Relation

  belongs_to :user
  
  ### Voting

  acts_as_votable 

  ### Validation

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

  ### Scopes

  scope :timeline, -> { 
  	order("created_at DESC")
  }

  scope :recent, -> { 
  	timeline.first(7)
  }

  scope :for, ->(user_id) {
    joins("LEFT JOIN relationships ON relationships.to_user_id = points.user_id")
    .where('relationships.type = \'Follower\' AND relationships.from_user_id = ? OR points.user_id = ?', user_id, user_id)
    .order("created_at DESC")
  }

  ### Attributes

  def title
    self.moment.to_s + '; ' + self.location.to_s
  end
end
