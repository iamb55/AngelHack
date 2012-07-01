class Message < ActiveRecord::Base
  include ActionView::Helpers
  belongs_to :conversation

  attr_accessible :value, :owner_type, :data_type
  
  def as_json
    owner = self.conversation.send(self.owner_type)
    {
      created_at: time_ago_in_words(self.created_at),
      name: owner.first_name,
      picture_url: owner.picture_url,
      value: self.value
    }
  end
end
