class AddChangeNameOfTypeToFormatForMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :type, :format
  end
end
