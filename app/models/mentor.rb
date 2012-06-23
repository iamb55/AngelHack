class Mentor < ActiveRecord::Base
  attr_accessible :access_token, :birthday, :email, :first_name, :last_name, :picture_url
end
