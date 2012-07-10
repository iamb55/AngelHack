class AddHabtmRelationshipTagsApps < ActiveRecord::Migration
  def self.up
    create_table :apps_tags, :id => false do |t|
        t.references :app
        t.references :tag
    end
    add_index :apps_tags, [:tag_id , :app_id]
    add_index :apps_tags, [:app_id, :tag_id]
    remove_column :tags, :app_id
  end

  def down
    drop_table :apps_tags
  end
end
