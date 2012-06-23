class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.text :email

      t.timestamps
    end
  end
end
