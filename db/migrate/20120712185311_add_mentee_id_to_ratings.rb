class AddMenteeIdToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :mentee_id, :integer
  end
end
