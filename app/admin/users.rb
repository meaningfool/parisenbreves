


ActiveAdmin.register User do
	controller do 
		with_role :admin 
	end

	index do 
		column :id
		column :name
		column :email
		column :created_at
		column :role
		default_actions
	end

	form do |f|
		f.inputs "User details" do
			f.input :name
			f.input :email
			# when the following is false the block returns nil
			unless f.object.persisted?
				f.input :password
				f.input :password_confirmation
			end
			f.input :role
		end
		f.buttons
	end
  	
end
