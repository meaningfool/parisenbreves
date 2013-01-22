class ResetBreves < ActiveRecord::Migration
  def change
  	add_column :breves, :location, :string
  	add_column :breves, :source_name, :string
  	add_column :breves, :source_URL, :string
  	add_column :breves, :latitude, :float
  	add_column :breves, :longitude, :float
  end
end
