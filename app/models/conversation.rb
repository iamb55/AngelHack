class Conversation < ActiveRecord::Base
  include ActionView::Helpers
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
      created_at: time_ago_in_words(self.created_at),
      id: self.id,
      mentor_id: self.mentor_id,
      mentee_id: self.mentee_id,
      messages: self.messages.as_json
    }
  end
end
