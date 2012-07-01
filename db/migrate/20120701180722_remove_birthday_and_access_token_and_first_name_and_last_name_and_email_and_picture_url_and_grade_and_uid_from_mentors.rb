class RemoveBirthdayAndAccessTokenAndFirstNameAndLastNameAndEmailAndPictureUrlAndGradeAndUidFromMentors < ActiveRecord::Migration
  def up
    remove_column :mentors, :birthday
    remove_column :mentors, :access_token
    remove_column :mentors, :first_name
    remove_column :mentors, :last_name
    remove_column :mentors, :email
    remove_column :mentors, :picture_url
    remove_column :mentors, :grade
    remove_column :mentors, :u_id
  end

  def down
    add_column :mentors, :u_id, :string
    add_column :mentors, :grade, :integer
    add_column :mentors, :picture_url, :string
    add_column :mentors, :email, :string
    add_column :mentors, :last_name, :string
    add_column :mentors, :first_name, :string
    add_column :mentors, :access_token, :string
    add_column :mentors, :birthday, :string
  end
end
