class AddDeviseIndexesToMentees < ActiveRecord::Migration
  def change
    add_index :mentees, :email,                :unique => true
    add_index :mentees, :reset_password_token, :unique => true
    add_index :mentees, :confirmation_token,   :unique => true
  end
end
