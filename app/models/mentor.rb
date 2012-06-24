class Mentor < ActiveRecord::Base
  attr_accessible :access_token, :birthday, :email, :first_name, :last_name, :picture_url

  has_many :conversations
  
  def mentor?
    true
  end
  
  def mentee?
    false
  end

  def user_type
    "mentor"
  end
end
