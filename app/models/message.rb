class Message < ActiveRecord::Base
  include ActionView::Helpers
  belongs_to :conversation

  attr_accessible :text, :owner_type, :video
  
  def as_json
    owner = self.conversation.send(self.owner_type)
    {
      created_at: time_ago_in_words(self.created_at),
      name: owner.first_name,
      picture_url: owner.picture_url,
      text: self.text,
      video: self.video,
      owner_type: self.owner_type
    }
  end
end
