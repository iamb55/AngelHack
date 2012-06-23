class Message < ActiveRecord::Base
  belongs_to :conversation

  attr_accessible :value
end
