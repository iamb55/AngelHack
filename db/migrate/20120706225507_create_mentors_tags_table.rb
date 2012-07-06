class CreateMentorsTagsTable < ActiveRecord::Migration
  def self.up
      create_table :mentors_tags, :id => false do |t|
          t.references :mentor
          t.references :tag
      end
      add_index :mentors_tags, [:tag_id , :mentor_id]
      add_index :mentors_tags, [:mentor_id, :tag_id]
    end

  def down
    drop_table :mentors_tags
  end
end
