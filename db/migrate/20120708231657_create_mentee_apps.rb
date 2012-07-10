class CreateMenteeApps < ActiveRecord::Migration
  def change
    create_table :mentee_apps do |t|
      t.string :email
      t.string :info
      t.string :token

      t.timestamps
    end
  end
end
