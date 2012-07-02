class App < ActiveRecord::Base
  attr_accessible :bio, :email, :twitter, :linkedin, :personal, :name, :uid, :picture, :education, :work
end
