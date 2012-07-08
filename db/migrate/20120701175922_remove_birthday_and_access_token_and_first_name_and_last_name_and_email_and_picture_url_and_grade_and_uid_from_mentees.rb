class RemoveBirthdayAndAccessTokenAndFirstNameAndLastNameAndEmailAndPictureUrlAndGradeAndUidFromMentees < ActiveRecord::Migration
  def up
    remove_column :mentees, :birthday
    remove_column :mentees, :access_token
    remove_column :mentees, :first_name
    remove_column :mentees, :last_name
    remove_column :mentees, :email
    remove_column :mentees, :picture_url
    remove_column :mentees, :grade
    remove_column :mentees, :u_id
  end

  def down
    add_column :mentees, :u_id, :string
    add_column :mentees, :grade, :integer
    add_column :mentees, :picture_url, :string
    add_column :mentees, :email, :string
    add_column :mentees, :last_name, :string
    add_column :mentees, :first_name, :string
    add_column :mentees, :access_token, :string
    add_column :mentees, :birthday, :string
  end
end
