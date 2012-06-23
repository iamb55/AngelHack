class AddMentorToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :mentor, :boolean
  end
end
