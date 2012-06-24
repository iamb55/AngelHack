class Mentee < ActiveRecord::Base
  attr_accessible :access_token, :birthday, :email, :first_name, :grade, :last_name, :picture_url

  has_many :conversations
  
  def self.find_or_create_from_singly(access)
    @fb_profile = HTTParty.get(
                  "https://api.singly.com/profiles/facebook",
                   { :query => { :access_token => access } }
                   )
    if @fb_profile
      @fb_profile = @fb_profile.parsed_response['data']
    else
      redirect_to 'auth/failure'
    end
    if mentee = find_by_u_id(@fb_profile['id'])
      mentee
    else
      Mentee.create first_name: @fb_profile['first_name'],
        last_name: @fb_profile['last_name'],
        birthday: @fb_profile['birthday'],
        email: @fb_profile['email'],
        picture_url: "https://graph.facebook.com/#{@fb_profile['id']}/picture?type=square",
        u_id: @fb_profile['id']
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
