class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login

  has_many :points

  # Image attachments
  has_attached_file :avatar, styles: {
    thumb: '100x100#',
    square: '250x250#',
  }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  devise authentication_keys: [:login]
  validates_formatting_of :website, using: :url, allow_nil: true, allow_blank: true
end
