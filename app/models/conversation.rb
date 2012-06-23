class Conversation < ActiveRecord::Base
  has_many :messages
  belongs_to :mentee
  belongs_to :mentor
end
