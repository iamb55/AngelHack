class Message < ActiveRecord::Base
  belongs_to :conversation

  attr_accessible :value, :owner_type, :data_type
end
