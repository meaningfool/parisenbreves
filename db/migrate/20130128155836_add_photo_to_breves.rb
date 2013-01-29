class AddPhotoToBreves < ActiveRecord::Migration
  def self.up
  	add_attachment :breves, :photo
  end
  def self.down
  	remove_attachment :breves, :photo
  end
end
