class Mentor < ActiveRecord::Base
  attr_accessible :access_token, :birthday, :email, :first_name, :last_name, :picture_url, :u_id

  has_many :conversations
  
  def self.find_or_create_from_fb(access)
    @graph  = Koala::Facebook::API.new(access)
  	@fb_info = @graph.get_object('me', fields: "email,picture,id,name,location,hometown,likes,gender")
  	if mentor = find_by_u_id(@fb_info['id'])
  	  mentor
	  else 	
    	Mentor.create u_id: @fb_info['id'],
    	  picture_url: @fb_info['picture'],
    	  email: @fb_info['email'],
    	  first_name: @fb_info['name'].split(' ')[0],
    	  last_name: @fb_info['name'].split(' ')[1],
    	  birthday: @fb_info['birthday']
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

def self.find_or_create_user(info)
  if @user = User.safe_find_by( uid: info["id"] )
    @user
  else
    @user = User.new name: info["name"],
  	  uid: info["id"],
  	  gender: info["gender"],
  	  picture: info["picture"],
  	  likes: info['likes'],
  	  email: info["email"]
	end
	
	@user.home_city = info["hometown"]["name"] if info["hometown"]
	@user.new_city = info["location"]["name"] if info["location"]
	
	return @user
end