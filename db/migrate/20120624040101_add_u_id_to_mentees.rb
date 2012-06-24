class AddUIdToMentees < ActiveRecord::Migration
  def change
    add_column :mentees, :u_id, :string
  end
end
