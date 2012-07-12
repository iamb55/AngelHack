require 'shared_methods'
class Mentor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  include SharedMethods
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :birthday, :picture_url

  has_many :conversations
  has_many :ratings
  has_and_belongs_to_many :tags
  
  def mentor?
    true
  end
  
  def mentee?
    false
  end

  def user_type
    "mentor"
  end

  def rating
    return self.ratings.where(value: 'good').count - self.ratings.where(value: 'bad').count
  end
end
