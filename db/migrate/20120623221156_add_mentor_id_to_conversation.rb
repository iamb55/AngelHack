class AddMentorIdToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :mentor_id, :integer
  end
end
