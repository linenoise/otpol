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
    where("created_at" => 3.days.ago..0.days.ago).order("created_at DESC")
  }

  ### Attributes

  has_attached_file :avatar, styles: {
    thumb: '50x50#',
    square: '250x250#',
  }, :default_url => "otpol.png"

  def display_name
    if self.name.to_s.empty?
      '@' + self.username
    else
      self.name
    end
  end


  ### Validation

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_formatting_of :website, using: :url, allow_nil: true, allow_blank: true

  def self.find_for_database_authentication(warden_conditions)    
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { 
        :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end


  ### Points

  def timeline
    timeline_points = self.points.all
    self.following.each do |followed_user|
      timeline_points.push(followed_user.points.all)
    end
    timeline_points.flatten.sort {|x,y| y.created_at <=> x.created_at}
  end

  def self.active_recently
    Point.joins(:user)
      .where("points.created_at" => 7.days.ago..0.days.ago)
      .group("users.username")
      .order("count_all DESC")
      .count()
      .map{|row| [
        self.find_by_username(row[0]),
        row[1]
      ]}
  end

  ### Blocking

  def blocks
    Block.list_from(self)
  end

  def block_count
    Block.count_from(self)
  end

  def is_blocking(user)
    Block.exists_between?(self, user)
  end

  def can_block(user)
    if self.username == user.username
      return false
    end
    return true
  end

  def is_blocked_by(user)
    Block.exists_between?(user, self)
  end

  def is_blocked_from(user)
    self.is_blocking(user) || self.is_blocked_by(user)
  end

  def block(user)
    Block.create_between(self, user)
  end

  def unblock(user)
    Block.remove_between(self, user)
  end


  ### Following

  def followers
    Follower.list_to(self)
  end

  def following
    Follower.list_from(self)
  end

  def follower_count
    Follower.count_to(self)
  end

  def following_count
    Follower.count_from(self)
  end

  def is_following(user)
    Follower.exists_between?(self, user)
  end

  def can_follow(user)
    self.username != user.username
  end

  def follow(user)
    relationship = Follower.create_between(self, user)
    # relationship.event = Event.new(user_id: self.id, prototype: :started_following, archive: {
    #   to_user_name: user.name, to_user_id: user.id})
    # relationship.event.save
    relationship.save
  end

  def unfollow(user)
    # event = Follower.between(self, user).event
    # event.destroy! if event
    Follower.remove_between(self, user)
  end

end
