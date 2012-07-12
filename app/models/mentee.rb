require 'shared_methods'
class Mentee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  include SharedMethods
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :birthday, :picture_url
  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :conversations
  has_many :ratings
  has_and_belongs_to_many :tags
  
  def mentor?
    false
  end
  
  def mentee?
    true
  end

  def user_type
    "mentee"
  end
  
  def picture_url
    '/assets/avatar.png'
  end
end
