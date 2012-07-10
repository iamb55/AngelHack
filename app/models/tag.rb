class Tag < ActiveRecord::Base
  attr_accessible :value
  belongs_to :app
  has_and_belongs_to_many :mentors
  has_and_belongs_to_many :mentees
  has_and_belongs_to_many :conversations
  has_and_belongs_to_many :apps
  
  def as_json(options ={})
    self.value
  end
end
