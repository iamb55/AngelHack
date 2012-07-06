class AddFieldsToMentorsAndMentees < ActiveRecord::Migration
  def change
    add_column :mentors, :u_id, :string
    add_column :mentors, :grade, :integer
    add_column :mentors, :picture_url, :string
    add_column :mentors, :last_name, :string
    add_column :mentors, :first_name, :string
    add_column :mentors, :access_token, :string
    add_column :mentors, :birthday, :string
    
    add_column :mentees, :u_id, :string
    add_column :mentees, :grade, :integer
    add_column :mentees, :picture_url, :string
    add_column :mentees, :last_name, :string
    add_column :mentees, :first_name, :string
    add_column :mentees, :access_token, :string
    add_column :mentees, :birthday, :string
  end
end
