class ChangeMessagesTable < ActiveRecord::Migration
  def change
    remove_column :messages, :data_type
    rename_column :messages, :value, :text
    add_column :messages, :video, :stringz
  end
end
