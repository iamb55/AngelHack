class DropAccidentalMentorTable < ActiveRecord::Migration
  def up
    drop_table :mentors
  end

  def down
    # There was no previous acceptable state
  end
end
