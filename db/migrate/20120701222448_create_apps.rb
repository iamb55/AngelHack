class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.text :bio
      t.string :email
      t.string :twitter
      t.string :linkedin
      t.string :personal
      t.string :name
      t.string :uid
      t.string :picture
      t.text :education
      t.text :work
      t.timestamps
    end
  end
end
