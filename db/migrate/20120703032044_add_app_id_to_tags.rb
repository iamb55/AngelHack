class AddAppIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :app_id, :integer
  end
end
