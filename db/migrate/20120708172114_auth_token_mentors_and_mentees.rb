class AuthTokenMentorsAndMentees < ActiveRecord::Migration
  def up
    change_table :mentors do |t|
      t.string :authentication_token
    end
    change_table :mentees do |y|
      y.string :authentication_token
    end
  end

  def down
    t.remove :authentication_token
    y.remove :authentication_token
  end
end