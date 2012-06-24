class Mentee < ActiveRecord::Base
  attr_accessible :access_token, :birthday, :email, :first_name, :grade, :last_name, :picture_url, :u_id

  has_many :conversations
  
  def self.find_or_create_from_fb(access)
    @graph  = Koala::Facebook::API.new(access)
  	@fb_info = @graph.get_object('me', fields: "email,picture,id,name,location,hometown,likes,gender")
  	if mentee = find_by_u_id(@fb_info['id'])
  	  mentee
	  else 	
	    p @fb_info['name']
    	Mentee.create u_id: @fb_info['id'],
    	  picture_url: @fb_info['picture'],
    	  email: @fb_info['email'],
    	  first_name: @fb_info['name'].split(' ')[0],
    	  last_name: @fb_info['name'].split(' ')[1],
    	  birthday: @fb_info['birthday']
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
