class Message < ActiveRecord::Base
  belongs_to :conversation

  attr_accessible :value, :owner_type, :format
end
