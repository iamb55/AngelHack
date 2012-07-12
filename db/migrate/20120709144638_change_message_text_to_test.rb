class ChangeMessageTextToTest < ActiveRecord::Migration
  def up
    change_column :messages, :text, :text
  end

  def down
    change_column :messages, :text, :string
  end
end
