class CreateMentees < ActiveRecord::Migration
  def change
    create_table :mentees do |t|
      t.string :birthday
      t.string :access_token
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :picture_url
      t.integer :grade

      t.timestamps
    end
  end
end
