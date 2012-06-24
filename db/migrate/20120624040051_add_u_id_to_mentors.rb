class AddUIdToMentors < ActiveRecord::Migration
  def change
    add_column :mentors, :u_id, :string
  end
end
