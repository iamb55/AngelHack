class Mentee < ActiveRecord::Base
  attr_accessible :access_token, :birthday, :email, :first_name, :grade, :last_name, :picture_url, :u_id

  has_many :conversations
  
  def self.find_or_create_from_singly(access)
    begin
      @fb_profile = HTTParty.get(
                    "https://api.singly.com/profiles/facebook",
                     { :query => { :access_token => access } }
                     ).parsed_response['data']
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
    rescue
      false
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
