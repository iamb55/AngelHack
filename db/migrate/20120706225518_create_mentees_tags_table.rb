class CreateMenteesTagsTable < ActiveRecord::Migration
  def self.up
      create_table :mentees_tags, :id => false do |t|
          t.references :mentee
          t.references :tag
      end
      add_index :mentees_tags, [:tag_id , :mentee_id]
      add_index :mentees_tags, [:mentee_id, :tag_id]
    end

  def down
    drop_table :mentees_tags
  end
end
