class AddMentorIdToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :mentor_id, :integer
  end
end
