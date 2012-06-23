class AddOwnerTypeToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :owner_type, :string
  end
end
