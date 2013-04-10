class AddPhotoCredit < ActiveRecord::Migration
    def change
    	add_column :breves, :photo_credit_name, :string
    	add_column :breves, :photo_credit_URL, :string
  	end
end
