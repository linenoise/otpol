class Relationship < ActiveRecord::Base
  validates :from_user_id, presence: true
  validates :to_user_id, presence: true
  validates :type, presence: true

  has_one :from_user, :class_name => 'User', :primary_key => :from_user_id, :foreign_key => 'id'
  has_one :to_user, :class_name => 'User', :primary_key => :to_user_id, :foreign_key => 'id'

  self.inheritance_column = :type
  def self.types
    %w(Block Follower)
  end

  class << self
    def list_from(user)
      self.where(from_user_id: user.id).find_each.map{ |relationship|
        User.find_by_id(relationship.to_user_id)
      }
    end

    def list_to(user)
      self.where(to_user_id: user.id).find_each.map{ |relationship|
        User.find_by_id(relationship.from_user_id)
      }
    end

    def count_from(user)
      list_from(user).count
    end

    def count_to(user)
      list_to(user).count
    end

    def between(from_user, to_user)
      self.where(from_user_id: from_user.id, to_user_id: to_user.id).first
    end

    def exists_between?(from_user, to_user)
      if between(from_user, to_user)
        return true
      end
      return false
    end

    def create_between(from_user, to_user)
      self.find_or_create_by(from_user_id: from_user.id, to_user_id: to_user.id)
    end

    def remove_between(from_user, to_user)
      if self.between(from_user, to_user).destroy
        return true
      end
      return false
    end
  end
end
