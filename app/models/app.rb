class App < ActiveRecord::Base
  attr_accessible :bio, :email, :twitter, :linkedin, :personal, :name, :uid, :picture, :education, :work, :token
  has_and_belongs_to_many :tags
  include SharedMethods
end
