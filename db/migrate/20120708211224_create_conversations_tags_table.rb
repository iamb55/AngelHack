class CreateConversationsTagsTable < ActiveRecord::Migration
  def self.up
    create_table :conversations_tags, :id => false do |t|
        t.references :conversation
        t.references :tag
    end
    add_index :conversations_tags, [:tag_id , :conversation_id]
    add_index :conversations_tags, [:conversation_id, :tag_id]
  end

  def down
    drop_table :conversations_tags
  end
end
