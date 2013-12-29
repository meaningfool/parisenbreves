
ActiveAdmin.register User do
	controller do 
		with_role :admin 
	end

	menu :priority => 1

	scope :admin
	scope :editor
	scope :standard

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
			f.input :password
			f.input :password_confirmation
			f.input :role, :as => :select, :collection => ["standard", "editor", "admin"]
		end
		f.actions
	end
  	
end
