class User < ActiveRecord::Base

  ### Authentication

  devise :database_authenticatable, 
         :registerable, 
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable, 
         :lockable

  attr_accessor :login
  devise authentication_keys: [:login]

  ### Relation

  has_many :points

  ### Scopes

  scope :newcomers, -> { 
    where("created_at" => 3.days.ago..0.days.ago)
  }
  scope :active, -> { 
    where("last_seen_at" => 1.days.ago..0.days.ago)
  }

  ### Attributes

  has_attached_file :avatar, styles: {
    thumb: '50x50#',
    square: '250x250#',
  }

  ### Validation

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_formatting_of :website, using: :url, allow_nil: true, allow_blank: true

  ### Methods

  def display_name
    if self.name.empty?
      '@' + self.username
    else
      self.name
    end
  end

  def self.find_for_database_authentication(warden_conditions)    
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

end
