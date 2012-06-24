class Mentee < ActiveRecord::Base
  attr_accessible :access_token, :birthday, :email, :first_name, :grade, :last_name, :picture_url

  has_many :conversations
  
  def mentor?
    false
  end
  
  def mentee?
    true
  end
end
