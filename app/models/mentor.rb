class Mentor < ActiveRecord::Base
  attr_accessible :access_token, :birthday, :email, :first_name, :last_name, :picture_url, :u_id

  has_many :conversations
  
  def self.find_or_create_from_singly(access)
    @fb_profile = HTTParty.get(
                  "https://api.singly.com/profiles/facebook",
                   { :query => { :access_token => access } }
                   ).parsed_response['data']
    if mentor = find_by_u_id(@fb_profile['id'])
      mentor
    else
      Mentor.create first_name: @fb_profile['first_name'],
        last_name: @fb_profile['last_name'],
        birthday: @fb_profile['birthday'],
        email: @fb_profile['email'],
        picture_url: @fb_profile['picture'],
        u_id: @fb_profile['id']
    end
  end
  
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
