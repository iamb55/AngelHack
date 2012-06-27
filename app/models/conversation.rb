class Conversation < ActiveRecord::Base
  has_many :messages
  belongs_to :mentee
  belongs_to :mentor

  def self.answered
    Conversation.all.collect do |conv|
      conv if conv.messages.count > 1 
    end.compact
  end

  def self.unanswered
    Conversation.all.collect do |conv|
      conv if conv.messages.count == 1 
    end.compact
  end
  
  def as_json(options = {})
    {
      messages: messages,
      mentor: mentor,
      mentee: mentee,
      id: id,
      updated_at: updated_at
    }
  end
end
