class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :value, unique: true

      t.timestamps
    end
  end
end
