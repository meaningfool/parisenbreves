class AddMetadataToVersions < ActiveRecord::Migration
  def change
  	add_column :versions, :edit_type, :string
  end
end
