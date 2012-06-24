class RenameFormatToDataType < ActiveRecord::Migration
  def up
    rename_column :messages, :format, :data_type
  end

  def down
    rename_column :messages, :data_type, :format
  end
end
