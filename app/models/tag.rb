class Tag < ActiveRecord::Base
  attr_accessible :value
  belongs_to :app
end
