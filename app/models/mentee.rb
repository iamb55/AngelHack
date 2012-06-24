class Mentee < ActiveRecord::Base
  attr_accessible :access_token, :birthday, :email, :first_name, :grade, :last_name, :picture_url

  has_many :conversations
  
  def self.find_or_create_from_singly(auth)
    if user = find_by_access_token(auth.credentials.token)
      user
    else
      user = Mentee.new access_token: auth.credentials.token
      @fb_profile = HTTParty.get(
                    "https://api.singly.com/profiles/facebook",
                     { :query => { :access_token => user.access_token } }
                     ).parsed_response.data
      user.first_name = @fb_profile.first_name
      user.last_name = @fb_profile.last_name
      user.birthday = @fb_profile.birthday
      user.email = @fb_profile.email
      user.picture_url = @fb_profile.picture
      user.save
    end
  end
  
  def mentor?
    false
  end
  
  def mentee?
    true
  end

  def user_type
    "mentee"
  end
end
