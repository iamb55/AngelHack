class AddDefaultTypeForMessage < ActiveRecord::Migration
  def up
    change_column :messages, :type, :string, :default => "text"
  end

  def down
    change_column :messages, :type, :string, :default => "text"
  end
end
