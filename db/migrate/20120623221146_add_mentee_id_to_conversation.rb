class AddMenteeIdToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :mentee_id, :integer
  end
end
